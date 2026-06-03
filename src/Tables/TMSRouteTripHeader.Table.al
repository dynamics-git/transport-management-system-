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
        field(15; "Planned At"; DateTime)
        {
            Caption = 'Planned At';
        }
        field(16; "Loaded At"; DateTime)
        {
            Caption = 'Loaded At';
        }
        field(17; "Dispatched At"; DateTime)
        {
            Caption = 'Dispatched At';
        }
        field(18; "Delivered At"; DateTime)
        {
            Caption = 'Delivered At';
        }
        field(19; "POD Pending At"; DateTime)
        {
            Caption = 'POD Pending At';
        }
        field(20; "Closed At"; DateTime)
        {
            Caption = 'Closed At';
        }
        field(21; "Last Status Changed At"; DateTime)
        {
            Caption = 'Last Status Changed At';
        }
        field(22; "Last Status Changed By"; Code[50])
        {
            Caption = 'Last Status Changed By';
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

        if "Last Status Changed At" = 0DT then
            "Last Status Changed At" := "Created At";

        if "Last Status Changed By" = '' then
            "Last Status Changed By" := "Created By";
    end;

    trigger OnModify()
    begin
        if xRec.Status <> Status then
            UpdateStatusAudit();
    end;

    local procedure UpdateStatusAudit()
    var
        StatusChangedAt: DateTime;
    begin
        StatusChangedAt := CurrentDateTime;

        "Last Status Changed At" := StatusChangedAt;
        "Last Status Changed By" := CopyStr(UserId, 1, MaxStrLen("Last Status Changed By"));

        case Status of
            Status::Planned:
                if "Planned At" = 0DT then
                    "Planned At" := StatusChangedAt;
            Status::Loaded:
                if "Loaded At" = 0DT then
                    "Loaded At" := StatusChangedAt;
            Status::Dispatched:
                if "Dispatched At" = 0DT then
                    "Dispatched At" := StatusChangedAt;
            Status::Delivered:
                if "Delivered At" = 0DT then
                    "Delivered At" := StatusChangedAt;
            Status::"POD Pending":
                if "POD Pending At" = 0DT then
                    "POD Pending At" := StatusChangedAt;
            Status::Closed:
                if "Closed At" = 0DT then
                    "Closed At" := StatusChangedAt;
        end;
    end;
}
