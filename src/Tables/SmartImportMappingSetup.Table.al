table 50613 "Smart Import Map Setup"
{
    Caption = 'Smart Import Mapping Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Target Document Type"; Enum "Smart Import Target Doc Type")
        {
            Caption = 'Target Document Type';
        }
        field(2; "Source Field Name"; Text[100])
        {
            Caption = 'Source Field Name';
        }
        field(3; "Target Field Name"; Text[100])
        {
            Caption = 'Target Field Name';
        }
        field(4; "Target Table Name"; Text[100])
        {
            Caption = 'Target Table Name';
        }
        field(5; "Target Field No."; Integer)
        {
            Caption = 'Target Field No.';
        }
        field(6; "Is Required"; Boolean)
        {
            Caption = 'Is Required';
        }
        field(7; "Default Value"; Text[250])
        {
            Caption = 'Default Value';
        }
        field(8; "Validation Rule"; Text[250])
        {
            Caption = 'Validation Rule';
        }
        field(9; "Is Active"; Boolean)
        {
            Caption = 'Is Active';
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "Target Document Type", "Source Field Name")
        {
            Clustered = true;
        }
    }
}
