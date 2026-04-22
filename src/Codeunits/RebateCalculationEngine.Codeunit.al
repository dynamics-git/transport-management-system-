codeunit 50100 "Rebate Calculation Engine"
{
    TableNo = "Rebate Transaction";

    trigger OnRun()
    begin
        CalculateRebateComponents(Rec);
    end;

    procedure CalculateRebateComponents(var RebateTransaction: Record "Rebate Transaction")
    var
        RebateSetupLine: Record "Rebate Setup Line";
        RebateTransactionLine: Record "Rebate Transaction Line";
        ComponentType: Enum "Rebate Component Type";
    begin
        // Clear existing calculations
        ClearRebateAmounts(RebateTransaction);

        // Delete existing transaction lines
        RebateTransactionLine.SetRange("Transaction ID", RebateTransaction."Transaction ID");
        RebateTransactionLine.DeleteAll();

        // Get setup lines for the matched setup
        RebateSetupLine.SetRange("Setup ID", RebateTransaction."Setup ID");
        if RebateSetupLine.FindSet() then
            repeat
                CalculateComponentAmount(RebateTransaction, RebateSetupLine, RebateTransactionLine);
            until RebateSetupLine.Next() = 0;

        // Calculate totals
        CalculateTotals(RebateTransaction);

        RebateTransaction.Modify();
    end;

    local procedure ClearRebateAmounts(var RebateTransaction: Record "Rebate Transaction")
    begin
        RebateTransaction."Market Rebate" := 0;
        RebateTransaction.EPI := 0;
        RebateTransaction.PPI := 0;
        RebateTransaction.VI := 0;
        RebateTransaction."Additional Rebate" := 0;
        RebateTransaction."Special Rebate" := 0;
        RebateTransaction."Total Rebate" := 0;
        RebateTransaction."Final Rebate" := 0;
    end;

    local procedure CalculateComponentAmount(RebateTransaction: Record "Rebate Transaction"; RebateSetupLine: Record "Rebate Setup Line"; var RebateTransactionLine: Record "Rebate Transaction Line")
    var
        ComponentAmount: Decimal;
        BaseAmount: Decimal;
    begin
        BaseAmount := RebateTransaction."Line Amount";

        // Check quantity thresholds
        if not IsQuantityWithinThreshold(RebateTransaction.Quantity, RebateSetupLine) then
            exit;

        // Check amount thresholds
        if not IsAmountWithinThreshold(BaseAmount, RebateSetupLine) then
            exit;

        // Calculate component amount
        ComponentAmount := CalculatePercentageAmount(BaseAmount, RebateSetupLine."Rebate %");

        // Create transaction line record
        RebateTransactionLine.Init();
        RebateTransactionLine."Transaction ID" := RebateTransaction."Transaction ID";
        RebateTransactionLine."Component Type" := RebateSetupLine."Component Type";
        RebateTransactionLine."Rebate %" := RebateSetupLine."Rebate %";
        RebateTransactionLine."Rebate Amount" := ComponentAmount;
        RebateTransactionLine."Base Amount" := BaseAmount;
        RebateTransactionLine."Setup ID" := RebateSetupLine."Setup ID";
        RebateTransactionLine."Setup Line No." := RebateSetupLine."Line No.";
        RebateTransactionLine.Description := RebateSetupLine.Description;
        RebateTransactionLine.Insert();

        // Update transaction header amounts
        UpdateTransactionAmounts(RebateTransaction, RebateSetupLine."Component Type", ComponentAmount);
    end;

    local procedure IsQuantityWithinThreshold(Quantity: Decimal; RebateSetupLine: Record "Rebate Setup Line"): Boolean
    begin
        if (RebateSetupLine."Min. Quantity" = 0) and (RebateSetupLine."Max. Quantity" = 0) then
            exit(true); // No quantity restrictions

        if (RebateSetupLine."Min. Quantity" <> 0) and (Quantity < RebateSetupLine."Min. Quantity") then
            exit(false);

        if (RebateSetupLine."Max. Quantity" <> 0) and (Quantity > RebateSetupLine."Max. Quantity") then
            exit(false);

        exit(true);
    end;

    local procedure IsAmountWithinThreshold(Amount: Decimal; RebateSetupLine: Record "Rebate Setup Line"): Boolean
    begin
        if (RebateSetupLine."Min. Amount" = 0) and (RebateSetupLine."Max. Amount" = 0) then
            exit(true); // No amount restrictions

        if (RebateSetupLine."Min. Amount" <> 0) and (Amount < RebateSetupLine."Min. Amount") then
            exit(false);

        if (RebateSetupLine."Max. Amount" <> 0) and (Amount > RebateSetupLine."Max. Amount") then
            exit(false);

        exit(true);
    end;

    local procedure CalculatePercentageAmount(BaseAmount: Decimal; Percentage: Decimal): Decimal
    begin
        exit(Round(BaseAmount * Percentage / 100, 0.01));
    end;

    local procedure UpdateTransactionAmounts(var RebateTransaction: Record "Rebate Transaction"; ComponentType: Enum "Rebate Component Type"; Amount: Decimal)
    begin
        case ComponentType of
            ComponentType::"Market Rebate":
                RebateTransaction."Market Rebate" += Amount;
            ComponentType::EPI:
                RebateTransaction.EPI += Amount;
            ComponentType::PPI:
                RebateTransaction.PPI += Amount;
            ComponentType::VI:
                RebateTransaction.VI += Amount;
            ComponentType::"Additional Rebate":
                RebateTransaction."Additional Rebate" += Amount;
            ComponentType::"Special Rebate":
                RebateTransaction."Special Rebate" += Amount;
        end;
    end;

    local procedure CalculateTotals(var RebateTransaction: Record "Rebate Transaction")
    begin
        RebateTransaction."Total Rebate" :=
            RebateTransaction."Market Rebate" +
            RebateTransaction.EPI +
            RebateTransaction.PPI +
            RebateTransaction.VI +
            RebateTransaction."Additional Rebate" +
            RebateTransaction."Special Rebate";

        RebateTransaction."Final Rebate" :=
            RebateTransaction."Total Rebate" +
            RebateTransaction."Proposed Adjustment";
    end;

    procedure RecalculateRebate(TransactionID: Code[20])
    var
        RebateTransaction: Record "Rebate Transaction";
    begin
        if RebateTransaction.Get(TransactionID) then
            CalculateRebateComponents(RebateTransaction);
    end;
}