page 50632 "Smart Import Field API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'documentImportField';
    EntitySetName = 'documentImportFields';
    SourceTable = "Smart Import Field";
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
                field(importNo; Rec."Import No.") { }
                field(fieldName; Rec."Field Name") { }
                field(sourceLabel; Rec."Source Label") { }
                field(extractedValue; Rec."Extracted Value") { }
                field(correctedValue; Rec."Corrected Value") { }
                field(targetFieldName; Rec."Target Field Name") { }
                field(confidenceScore; Rec."Confidence Score") { }
                field(isConfirmed; Rec."Is Confirmed") { }
                field(isRequired; Rec."Is Required") { }
                field(validationStatus; Rec."Validation Status") { }
                field(errorMessage; Rec."Error Message") { }
            }
        }
    }
}
