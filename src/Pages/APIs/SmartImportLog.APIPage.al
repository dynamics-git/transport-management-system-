page 50633 "Smart Import Log API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'documentImportLog';
    EntitySetName = 'documentImportLogs';
    SourceTable = "Smart Import Log";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(systemId; Rec.SystemId) { Editable = false; }
                field(importNo; Rec."Import No.") { Editable = false; }
                field(entryNo; Rec."Entry No.") { Editable = false; }
                field(step; Rec.Step) { Editable = false; }
                field(message; Rec.Message) { Editable = false; }
                field(status; Rec.Status) { Editable = false; }
                field(createdDateTime; Rec."Created DateTime") { Editable = false; }
                field(createdBy; Rec."Created By") { Editable = false; }
            }
        }
    }
}
