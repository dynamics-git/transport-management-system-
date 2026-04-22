table 50515 "TMS POD Entry"
{
    Caption = 'TMS POD Entry';
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
        field(3; "POD Date"; DateTime)
        {
            Caption = 'POD Date';
        }
        field(4; "Received By"; Code[50])
        {
            Caption = 'Received By';
        }
        field(5; "Photo Path"; Text[250])
        {
            Caption = 'Photo Path';
        }
        field(6; "Remarks"; Text[250])
        {
            Caption = 'Remarks';
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