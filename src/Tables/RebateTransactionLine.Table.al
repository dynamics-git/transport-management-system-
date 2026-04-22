table 50103 "Rebate Transaction Line"
{
    Caption = 'Rebate Transaction Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Transaction ID"; Code[20])
        {
            Caption = 'Transaction ID';
            DataClassification = CustomerContent;
            TableRelation = "Rebate Transaction";
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
        }
        field(5; "Rebate Amount"; Decimal)
        {
            Caption = 'Rebate Amount (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(6; "Base Amount"; Decimal)
        {
            Caption = 'Base Amount (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(7; "Setup ID"; Code[20])
        {
            Caption = 'Setup ID';
            DataClassification = CustomerContent;
            TableRelation = "Rebate Setup Master";
        }
        field(8; "Setup Line No."; Integer)
        {
            Caption = 'Setup Line No.';
            DataClassification = CustomerContent;
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(10; "Calculated Date"; DateTime)
        {
            Caption = 'Calculated Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Calculated By"; Code[50])
        {
            Caption = 'Calculated By';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Transaction ID", "Line No.")
        {
            Clustered = true;
        }
        key(Component; "Component Type")
        {
        }
        key(Setup; "Setup ID", "Setup Line No.")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Line No." = 0 then
            "Line No." := GetNextLineNo();

        "Calculated Date" := CurrentDateTime;
        "Calculated By" := UserId;
    end;

    local procedure GetNextLineNo(): Integer
    var
        RebateTransactionLine: Record "Rebate Transaction Line";
    begin
        RebateTransactionLine.SetRange("Transaction ID", "Transaction ID");
        if RebateTransactionLine.FindLast() then
            exit(RebateTransactionLine."Line No." + 10000)
        else
            exit(10000);
    end;
}