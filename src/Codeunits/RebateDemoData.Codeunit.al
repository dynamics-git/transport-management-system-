codeunit 50503 "Rebate Demo Data"
{
    procedure CreateSampleRebateSetup()
    var
        RebateSetupMaster: Record "Rebate Setup Master";
        RebateSetupLine: Record "Rebate Setup Line";
        SetupID: Code[20];
    begin
        // Create sample rebate setup for MCP product
        SetupID := 'DEMO-001';

        // Create master record
        RebateSetupMaster.Init();
        RebateSetupMaster."Setup ID" := SetupID;
        RebateSetupMaster.Description := 'Demo Rebate Setup for MCP';
        RebateSetupMaster."From Date" := Today();
        RebateSetupMaster."To Date" := CalcDate('<+1Y>', Today());
        RebateSetupMaster."Item No." := 'MCP'; // Assuming this item exists
        RebateSetupMaster."Entity Type" := RebateSetupMaster."Entity Type"::Customer;
        RebateSetupMaster."Entity ID" := ''; // Apply to all customers
        RebateSetupMaster."Rebate Type" := RebateSetupMaster."Rebate Type"::Recurring;
        RebateSetupMaster.Priority := 1;
        RebateSetupMaster.Status := RebateSetupMaster.Status::Approved;
        RebateSetupMaster.Insert();

        // Create setup lines
        CreateRebateComponent(SetupID, RebateSetupLine."Component Type"::"Market Rebate", 5.0, 'Standard market rebate');
        CreateRebateComponent(SetupID, RebateSetupLine."Component Type"::EPI, 2.0, 'Early payment incentive');
        CreateRebateComponent(SetupID, RebateSetupLine."Component Type"::PPI, 1.5, 'Prompt payment incentive');
        CreateRebateComponent(SetupID, RebateSetupLine."Component Type"::VI, 3.0, 'Volume incentive for >100 units');
        CreateRebateComponent(SetupID, RebateSetupLine."Component Type"::"Additional Rebate", 1.0, 'Additional rebate');
        CreateRebateComponent(SetupID, RebateSetupLine."Component Type"::"Special Rebate", 0.5, 'Special rebate');

        Message('Sample rebate setup created successfully!');
    end;

    local procedure CreateRebateComponent(SetupID: Code[20]; ComponentType: Enum "Rebate Component Type"; RebatePercent: Decimal; Description: Text[100])
    var
        RebateSetupLine: Record "Rebate Setup Line";
    begin
        RebateSetupLine.Init();
        RebateSetupLine."Setup ID" := SetupID;
        RebateSetupLine."Component Type" := ComponentType;
        RebateSetupLine."Rebate %" := RebatePercent;
        RebateSetupLine.Description := Description;

        // Set thresholds for VI component
        if ComponentType = RebateSetupLine."Component Type"::VI then begin
            RebateSetupLine."Min. Quantity" := 100;
            RebateSetupLine."Max. Quantity" := 999999;
        end;

        RebateSetupLine.Insert();
    end;

    procedure CreateSampleRebateTransaction()
    var
        RebateTransaction: Record "Rebate Transaction";
        RebateMatchingEngine: Codeunit "Rebate Matching Engine";
    begin
        // Create sample transaction
        RebateTransaction.Init();
        RebateTransaction."Transaction ID" := 'DEMO-TRX-001';
        RebateTransaction."Document Type" := RebateTransaction."Document Type"::"Purchase Order";
        RebateTransaction."Document No." := 'PO-001'; // Sample PO
        RebateTransaction."Line No." := 10000;
        RebateTransaction."Posting Date" := Today();
        RebateTransaction."Item No." := 'MCP';
        RebateTransaction.Quantity := 150; // Above VI threshold
        RebateTransaction."Unit Price" := 100.00;
        RebateTransaction."Entity Type" := RebateTransaction."Entity Type"::Customer;
        RebateTransaction."Entity ID" := 'CUST001'; // Sample customer
        RebateTransaction.Insert();

        // Suggest rebate automatically
        RebateMatchingEngine.SuggestRebateSetup(RebateTransaction);

        Message('Sample rebate transaction created and rebate suggested!');
    end;
}
