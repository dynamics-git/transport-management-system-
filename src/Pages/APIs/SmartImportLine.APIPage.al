page 50631 "Smart Import Line API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'documentImportLine';
    EntitySetName = 'documentImportLines';
    SourceTable = "Smart Import Line";
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
                field(lineNo; Rec."Line No.") { }
                field(targetDocumentType; Rec."Target Document Type") { }
                field(itemNo; Rec."Item No.") { }
                field(glAccountNo; Rec."G/L Account No.") { }
                field(description; Rec.Description) { }
                field(quantity; Rec.Quantity) { }
                field(unitOfMeasure; Rec."Unit of Measure") { }
                field(unitCost; Rec."Unit Cost") { }
                field(lineAmount; Rec."Line Amount") { }
                field(departmentCode; Rec."Department Code") { }
                field(projectCode; Rec."Project Code") { }
                field(requiredDate; Rec."Required Date") { }
                field(confidenceScore; Rec."Confidence Score") { }
                field(mappingStatus; Rec."Mapping Status") { }
                field(errorMessage; Rec."Error Message") { }
            }
        }
    }
}
