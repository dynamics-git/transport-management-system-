table 50616 "TMS Trip Activity"
{
    Caption = 'TMS Trip Activity';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Trip No."; Code[20])
        {
            Caption = 'Trip No.';
            TableRelation = "TMS Route Trip Header";
        }
        field(3; "Activity Type"; Code[30])
        {
            Caption = 'Activity Type';
        }
        field(4; "Activity Label"; Text[100])
        {
            Caption = 'Activity Label';
        }
        field(5; "Activity At"; DateTime)
        {
            Caption = 'Activity At';
        }
        field(6; "Portal User ID"; Code[100])
        {
            Caption = 'Portal User ID';
        }
        field(7; "BC User ID"; Code[50])
        {
            Caption = 'BC User ID';
        }
        field(8; "Source Table"; Text[50])
        {
            Caption = 'Source Table';
        }
        field(9; "Old Value"; Text[100])
        {
            Caption = 'Old Value';
        }
        field(10; "New Value"; Text[100])
        {
            Caption = 'New Value';
        }
        field(11; Details; Text[250])
        {
            Caption = 'Details';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(TripDate; "Trip No.", "Activity At")
        {
        }
    }
}
