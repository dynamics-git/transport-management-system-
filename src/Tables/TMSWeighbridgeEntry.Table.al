table 50514 "TMS Weighbridge Entry"
{
    Caption = 'TMS Weighbridge Entry';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
        }
        field(2; "Trip No."; Code[20])
        {
            Caption = 'Trip No.';
            TableRelation = "TMS Route Trip Header";
        }
        field(3; "Tare Weight"; Decimal)
        {
            Caption = 'Tare Weight';
        }
        field(4; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
        }
        field(5; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
        }
        field(6; "Overload"; Boolean)
        {
            Caption = 'Overload';
        }
        field(7; "Recorded By"; Code[50])
        {
            Caption = 'Recorded By';
        }
        field(8; "Recorded At"; DateTime)
        {
            Caption = 'Recorded At';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}