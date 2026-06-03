table 50615 "TMS POD Entry"
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
        field(7; "Received At"; DateTime)
        {
            Caption = 'Received At';
        }
        field(8; "Portal User ID"; Code[100])
        {
            Caption = 'Portal User ID';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        ActivityMgt: Codeunit "TMS Trip Activity Management";
        Actor: Code[100];
        BCActor: Code[50];
    begin
        if "Entry No." = '' then
            "Entry No." := CopyStr('PD' + DelChr(Format(CreateGuid()), '=', '{}-'), 1, MaxStrLen("Entry No."));

        if "Received At" = 0DT then
            "Received At" := CurrentDateTime;

        BCActor := CopyStr(UserId, 1, MaxStrLen(BCActor));
        Actor := "Portal User ID";
        if Actor = '' then
            Actor := "Received By";
        if Actor = '' then
            Actor := BCActor;

        ActivityMgt.LogActivity(
            "Trip No.",
            'POD',
            'POD received',
            "Received At",
            Actor,
            BCActor,
            'TMS POD Entry',
            '',
            Format("POD Date"),
            StrSubstNo('POD captured for trip %1.', "Trip No.")
        );
    end;

    trigger OnModify()
    var
        ActivityMgt: Codeunit "TMS Trip Activity Management";
        Actor: Code[100];
        BCActor: Code[50];
        ActivityAt: DateTime;
    begin
        ActivityAt := CurrentDateTime;
        if "Received At" = 0DT then
            "Received At" := ActivityAt;

        BCActor := CopyStr(UserId, 1, MaxStrLen(BCActor));
        Actor := "Portal User ID";
        if Actor = '' then
            Actor := "Received By";
        if Actor = '' then
            Actor := BCActor;

        ActivityMgt.LogActivity(
            "Trip No.",
            'POD',
            'POD updated',
            ActivityAt,
            Actor,
            BCActor,
            'TMS POD Entry',
            xRec.Remarks,
            Remarks,
            StrSubstNo('POD updated for trip %1.', "Trip No.")
        );
    end;
}
