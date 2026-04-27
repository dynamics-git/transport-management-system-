page 50634 "Smart Import Map Setup API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'documentImportMapping';
    EntitySetName = 'documentImportMappings';
    SourceTable = "Smart Import Map Setup";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(systemId; Rec.SystemId) { Editable = false; }
                field(targetDocumentType; Rec."Target Document Type") { }
                field(sourceFieldName; Rec."Source Field Name") { }
                field(targetFieldName; Rec."Target Field Name") { }
                field(targetTableName; Rec."Target Table Name") { }
                field(targetFieldNo; Rec."Target Field No.") { }
                field(isRequired; Rec."Is Required") { }
                field(defaultValue; Rec."Default Value") { }
                field(validationRule; Rec."Validation Rule") { }
                field(isActive; Rec."Is Active") { }
            }
        }
    }
}
