table 50614 "Smart Import Log"
{
    Caption = 'Smart Import Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Import No."; Code[20])
        {
            Caption = 'Import No.';
            TableRelation = "Smart Import Header";
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; Step; Text[100])
        {
            Caption = 'Step';
        }
        field(4; Message; Text[2048])
        {
            Caption = 'Message';
        }
        field(5; Status; Enum "Smart Import Log Status")
        {
            Caption = 'Status';
        }
        field(6; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
        }
        field(7; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
    }

    keys
    {
        key(PK; "Import No.", "Entry No.")
        {
            Clustered = true;
        }
        key(SystemIdKey; SystemId)
        {
        }
    }

    trigger OnInsert()
    var
        SmartImportLog: Record "Smart Import Log";
    begin
        if "Entry No." = 0 then begin
            SmartImportLog.SetRange("Import No.", "Import No.");
            if SmartImportLog.FindLast() then
                "Entry No." := SmartImportLog."Entry No." + 1
            else
                "Entry No." := 1;
        end;

        if "Created DateTime" = 0DT then
            "Created DateTime" := CurrentDateTime();

        if "Created By" = '' then
            "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
    end;
}
