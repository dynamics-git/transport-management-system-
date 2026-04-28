table 50610 "TMS Transporter"
{
    Caption = 'TMS Transporter';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(4; "Email"; Text[80])
        {
            Caption = 'Email';
        }
        field(5; "Active"; Boolean)
        {
            Caption = 'Active';
        }
        field(6; "Default Freight Type"; Text[50])
        {
            Caption = 'Default Freight Type';
        }
        field(7; "Remarks"; Text[250])
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
    }
}
