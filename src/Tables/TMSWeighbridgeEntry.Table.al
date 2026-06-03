table 50614 "TMS Weighbridge Entry"
{
    Caption = 'TMS Weighbridge Entry';
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
        field(3; "Tare Weight"; Decimal)
        {
            Caption = 'Tare Weight';
        }
        field(4; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
        }
        field(5; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
        }
        field(6; "Overload"; Boolean)
        {
            Caption = 'Overload';
        }
        field(7; "Recorded By"; Code[50])
        {
            Caption = 'Recorded By';
        }
        field(8; "Recorded At"; DateTime)
        {
            Caption = 'Recorded At';
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
            "Entry No." := CopyStr('WB' + DelChr(Format(CreateGuid()), '=', '{}-'), 1, MaxStrLen("Entry No."));

        if "Recorded At" = 0DT then
            "Recorded At" := CurrentDateTime;

        BCActor := CopyStr(UserId, 1, MaxStrLen(BCActor));
        Actor := "Recorded By";
        if Actor = '' then
            Actor := BCActor;

        ActivityMgt.LogActivity(
            "Trip No.",
            'WEIGHBRIDGE',
            'Weighbridge recorded',
            "Recorded At",
            Actor,
            BCActor,
            'TMS Weighbridge Entry',
            '',
            Format("Net Weight"),
            StrSubstNo('Net %1T, Gross %2T, Tare %3T.', "Net Weight", "Gross Weight", "Tare Weight")
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
        if "Recorded At" = 0DT then
            "Recorded At" := ActivityAt;

        BCActor := CopyStr(UserId, 1, MaxStrLen(BCActor));
        Actor := "Recorded By";
        if Actor = '' then
            Actor := BCActor;

        ActivityMgt.LogActivity(
            "Trip No.",
            'WEIGHBRIDGE',
            'Weighbridge updated',
            ActivityAt,
            Actor,
            BCActor,
            'TMS Weighbridge Entry',
            Format(xRec."Net Weight"),
            Format("Net Weight"),
            StrSubstNo('Net %1T, Gross %2T, Tare %3T.', "Net Weight", "Gross Weight", "Tare Weight")
        );
    end;
}
