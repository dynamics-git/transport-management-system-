table 50612 "TMS Route Trip Header"
{
    Caption = 'TMS Route Trip Header';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Trip No."; Code[20])
        {
            Caption = 'Trip No.';
        }
        field(2; "Planned Date"; Date)
        {
            Caption = 'Planned Date';
        }
        field(3; "Hub Location Code"; Code[10])
        {
            Caption = 'Hub Location Code';
            TableRelation = Location;
        }
        field(4; "Load Type"; Enum "TMS Load Type")
        {
            Caption = 'Load Type';
        }
        field(5; "Transporter Code"; Code[20])
        {
            Caption = 'Transporter Code';
            TableRelation = "TMS Transporter";
        }
        field(6; "Truck No."; Code[20])
        {
            Caption = 'Truck No.';
            TableRelation = "TMS Truck";
        }
        field(7; "Status"; Enum "TMS Trip Status")
        {
            Caption = 'Status';
        }
        field(8; "Total Weight"; Decimal)
        {
            Caption = 'Total Weight';
        }
        field(9; "Total Bags"; Integer)
        {
            Caption = 'Total Bags';
        }
        field(10; "POD Received"; Boolean)
        {
            Caption = 'POD Received';
        }
        field(11; "POD Date"; DateTime)
        {
            Caption = 'POD Date';
        }
        field(12; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
        field(13; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(14; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }
    }
    keys
    {
        key(PK; "Trip No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Trip No." = '' then
            "Trip No." := CopyStr('TR' + DelChr(Format(CreateGuid()), '=', '{}-'), 1, MaxStrLen("Trip No."));

        if Format(Status) = '' then
            Status := Status::Draft;

        if "Created By" = '' then
            "Created By" := CopyStr(UserId, 1, MaxStrLen("Created By"));

        if "Created At" = 0DT then
            "Created At" := CurrentDateTime;
    end;
}
