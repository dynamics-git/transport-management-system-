table 50501 "Rebate Setup Line"
{
    Caption = 'Rebate Setup Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Setup ID"; Code[20])
        {
            Caption = 'Setup ID';
            DataClassification = CustomerContent;
            TableRelation = "Rebate Setup Master";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Component Type"; Enum "Rebate Component Type")
        {
            Caption = 'Component Type';
            DataClassification = CustomerContent;
        }
        field(4; "Rebate %"; Decimal)
        {
            Caption = 'Rebate %';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            MinValue = 0;
            MaxValue = 100;

            trigger OnValidate()
            begin
                CalculateRebateAmount();
            end;
        }
        field(5; "Rebate Amount"; Decimal)
        {
            Caption = 'Rebate Amount (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(6; "Min. Quantity"; Decimal)
        {
            Caption = 'Min. Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Max. Quantity" <> 0 then
                    if "Min. Quantity" > "Max. Quantity" then
                        Error('Min. Quantity cannot be greater than Max. Quantity');
            end;
        }
        field(7; "Max. Quantity"; Decimal)
        {
            Caption = 'Max. Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Min. Quantity" <> 0 then
                    if "Max. Quantity" < "Min. Quantity" then
                        Error('Max. Quantity cannot be less than Min. Quantity');
            end;
        }
        field(8; "Min. Amount"; Decimal)
        {
            Caption = 'Min. Amount (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Max. Amount" <> 0 then
                    if "Min. Amount" > "Max. Amount" then
                        Error('Min. Amount cannot be greater than Max. Amount');
            end;
        }
        field(9; "Max. Amount"; Decimal)
        {
            Caption = 'Max. Amount (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Min. Amount" <> 0 then
                    if "Max. Amount" < "Min. Amount" then
                        Error('Max. Amount cannot be less than Min. Amount');
            end;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Setup ID", "Line No.")
        {
            Clustered = true;
        }
        key(Component; "Component Type")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Line No." = 0 then
            "Line No." := GetNextLineNo();
    end;

    local procedure GetNextLineNo(): Integer
    var
        RebateSetupLine: Record "Rebate Setup Line";
    begin
        RebateSetupLine.SetRange("Setup ID", "Setup ID");
        if RebateSetupLine.FindLast() then
            exit(RebateSetupLine."Line No." + 10000)
        else
            exit(10000);
    end;

    local procedure CalculateRebateAmount()
    begin
        // For demo purposes, we'll calculate based on a base amount
        // In real implementation, this would be calculated based on transaction amount
        "Rebate Amount" := 0; // Will be calculated during transaction processing
    end;
}