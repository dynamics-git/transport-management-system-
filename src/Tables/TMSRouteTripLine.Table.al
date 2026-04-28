table 50613 "TMS Route Trip Line"
{
    Caption = 'TMS Route Trip Line';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Trip No."; Code[20])
        {
            Caption = 'Trip No.';
            TableRelation = "TMS Route Trip Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Source Document Type"; Enum "TMS Source Document Type")
        {
            Caption = 'Source Document Type';
        }
        field(4; "Source Document No."; Code[20])
        {
            Caption = 'Source Document No.';
        }
        field(5; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(7; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Customer No."));
        }
        field(8; "Region"; Text[50])
        {
            Caption = 'Region';
        }
        field(9; "Weight Tonne"; Decimal)
        {
            Caption = 'Weight Tonne';
        }
        field(10; "Bag Count"; Integer)
        {
            Caption = 'Bag Count';
        }
        field(11; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
        }
        field(12; "Line Status"; Enum "TMS Trip Status")
        {
            Caption = 'Line Status';
        }
    }
    keys
    {
        key(PK; "Trip No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
