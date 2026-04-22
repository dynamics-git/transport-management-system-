codeunit 50501 "Rebate Matching Engine"
{
    TableNo = "Rebate Transaction";

    trigger OnRun()
    begin
        SuggestRebateSetup(Rec);
    end;

    procedure SuggestRebateSetup(var RebateTransaction: Record "Rebate Transaction")
    var
        RebateSetupMaster: Record "Rebate Setup Master";
        BestMatchFound: Boolean;
        BestPriority: Integer;
    begin
        // Clear existing setup if any
        RebateTransaction."Setup ID" := '';
        RebateTransaction.Modify();

        // Find the best matching rebate setup
        BestMatchFound := FindBestRebateSetup(RebateTransaction, RebateSetupMaster, BestPriority);

        if BestMatchFound then begin
            RebateTransaction."Setup ID" := RebateSetupMaster."Setup ID";
            RebateTransaction.Status := RebateTransaction.Status::Suggested;
            RebateTransaction.Modify();

            // Calculate rebate components
            CalculateRebateComponents(RebateTransaction);
        end;
    end;

    local procedure FindBestRebateSetup(RebateTransaction: Record "Rebate Transaction"; var RebateSetupMaster: Record "Rebate Setup Master"; var BestPriority: Integer): Boolean
    var
        TempRebateSetup: Record "Rebate Setup Master" temporary;
        Found: Boolean;
    begin
        BestPriority := 999999; // Initialize to high value

        // Find all potential matches
        RebateSetupMaster.SetRange(Status, RebateSetupMaster.Status::Approved);
        RebateSetupMaster.SetFilter("From Date", '<=%1', RebateTransaction."Posting Date");
        RebateSetupMaster.SetFilter("To Date", '>=%1|%2', RebateTransaction."Posting Date", 0D);
        RebateSetupMaster.SetRange("Item No.", RebateTransaction."Item No.");
        RebateSetupMaster.SetRange("Entity Type", RebateTransaction."Entity Type");
        RebateSetupMaster.SetRange("Entity ID", RebateTransaction."Entity ID");

        if RebateSetupMaster.FindSet() then
            repeat
                // Check if this is a better match (lower priority number = higher priority)
                if RebateSetupMaster.Priority < BestPriority then begin
                    BestPriority := RebateSetupMaster.Priority;
                    TempRebateSetup := RebateSetupMaster;
                    TempRebateSetup.Insert();
                    Found := true;
                end;
            until RebateSetupMaster.Next() = 0;

        // If exact match found, return it
        if Found and TempRebateSetup.FindFirst() then begin
            RebateSetupMaster := TempRebateSetup;
            exit(true);
        end;

        // If no exact match, try fallback logic
        exit(FindFallbackRebateSetup(RebateTransaction, RebateSetupMaster));
    end;

    local procedure FindFallbackRebateSetup(RebateTransaction: Record "Rebate Transaction"; var RebateSetupMaster: Record "Rebate Setup Master"): Boolean
    var
        TempRebateSetup: Record "Rebate Setup Master" temporary;
    begin
        // Fallback 1: Match by Item and Entity Type only (ignore specific Entity ID)
        RebateSetupMaster.Reset();
        RebateSetupMaster.SetRange(Status, RebateSetupMaster.Status::Approved);
        RebateSetupMaster.SetFilter("From Date", '<=%1', RebateTransaction."Posting Date");
        RebateSetupMaster.SetFilter("To Date", '>=%1|%2', RebateTransaction."Posting Date", 0D);
        RebateSetupMaster.SetRange("Item No.", RebateTransaction."Item No.");
        RebateSetupMaster.SetRange("Entity Type", RebateTransaction."Entity Type");
        RebateSetupMaster.SetRange("Entity ID", ''); // Empty entity ID = applies to all

        if RebateSetupMaster.FindFirst() then begin
            RebateSetupMaster := RebateSetupMaster;
            exit(true);
        end;

        // Fallback 2: Match by Item only (ignore entity completely)
        RebateSetupMaster.Reset();
        RebateSetupMaster.SetRange(Status, RebateSetupMaster.Status::Approved);
        RebateSetupMaster.SetFilter("From Date", '<=%1', RebateTransaction."Posting Date");
        RebateSetupMaster.SetFilter("To Date", '>=%1|%2', RebateTransaction."Posting Date", 0D);
        RebateSetupMaster.SetRange("Item No.", RebateTransaction."Item No.");
        RebateSetupMaster.SetRange("Entity ID", '');

        if RebateSetupMaster.FindFirst() then begin
            RebateSetupMaster := RebateSetupMaster;
            exit(true);
        end;

        exit(false);
    end;

    local procedure CalculateRebateComponents(var RebateTransaction: Record "Rebate Transaction")
    var
        RebateCalculationEngine: Codeunit "Rebate Calculation Engine";
    begin
        RebateCalculationEngine.CalculateRebateComponents(RebateTransaction);
    end;
}
