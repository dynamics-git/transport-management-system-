table 50611 "TMS Truck"
{
    Caption = 'TMS Truck';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Truck No."; Code[20])
        {
            Caption = 'Truck No.';
        }
        field(2; "Transporter Code"; Code[20])
        {
            Caption = 'Transporter Code';
            TableRelation = "TMS Transporter";
        }
        field(3; "Plate No."; Text[20])
        {
            Caption = 'Plate No.';
        }
        field(4; "Load Type"; Enum "TMS Load Type")
        {
            Caption = 'Load Type';
        }
        field(5; "Capacity Tonne"; Decimal)
        {
            Caption = 'Capacity Tonne';
        }
        field(6; "GPS Enabled"; Boolean)
        {
            Caption = 'GPS Enabled';
        }
        field(7; "Active"; Boolean)
        {
            Caption = 'Active';
        }
    }
    keys
    {
        key(PK; "Truck No.")
        {
            Clustered = true;
        }
    }
}
