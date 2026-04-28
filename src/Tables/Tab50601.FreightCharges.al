table 50601 "Freight Charges"
{
    Caption = 'Freight Charges';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code;
        }
        field(3; "Region"; Text[50])
        {
            Caption = 'Region';
        }
        field(4; "Load Type"; Enum "TMS Load Type")
        {
            Caption = 'Load Type';
        }
        field(5; "Freight Rate"; Decimal)
        {
            Caption = 'Freight Rate';
        }
        field(6; "Handling Charge"; Decimal)
        {
            Caption = 'Handling Charge';
        }
        field(7; "Active"; Boolean)
        {
            Caption = 'Active';
        }
        field(8; "Remarks"; Text[250])
        {
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(LocationLoadType; "Location Code", "Region", "Load Type")
        {
        }
    }
}
