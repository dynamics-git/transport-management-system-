table 50612 "Smart Import Field"
{
    Caption = 'Smart Import Field';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Import No."; Code[20])
        {
            Caption = 'Import No.';
            TableRelation = "Smart Import Header";
        }
        field(2; "Field Name"; Code[100])
        {
            Caption = 'Field Name';
        }
        field(3; "Source Label"; Text[100])
        {
            Caption = 'Source Label';
        }
        field(4; "Extracted Value"; Text[2048])
        {
            Caption = 'Extracted Value';
        }
        field(5; "Corrected Value"; Text[2048])
        {
            Caption = 'Corrected Value';
        }
        field(6; "Target Field Name"; Text[100])
        {
            Caption = 'Target Field Name';
        }
        field(7; "Confidence Score"; Decimal)
        {
            Caption = 'Confidence Score';
            DecimalPlaces = 0 : 5;
        }
        field(8; "Is Confirmed"; Boolean)
        {
            Caption = 'Is Confirmed';
        }
        field(9; "Is Required"; Boolean)
        {
            Caption = 'Is Required';
        }
        field(10; "Validation Status"; Enum "Smart Import Field Val Status")
        {
            Caption = 'Validation Status';
            InitValue = Pending;
        }
        field(11; "Error Message"; Text[2048])
        {
            Caption = 'Error Message';
        }
    }

    keys
    {
        key(PK; "Import No.", "Field Name")
        {
            Clustered = true;
        }
        key(SystemIdKey; SystemId)
        {
        }
    }
}
