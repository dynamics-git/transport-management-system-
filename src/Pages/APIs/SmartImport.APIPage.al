page 50630 "Smart Import API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'documentImport';
    EntitySetName = 'documentImports';
    SourceTable = "Smart Import Header";
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
                field(importNo; Rec."Import No.") { Editable = false; }
                field(targetDocumentType; Rec."Target Document Type") { }
                field(sourceFileName; Rec."Source File Name") { }
                field(sourceFileExtension; Rec."Source File Extension") { }
                field(sourceFileContent; Rec."Source File Content") { }
                field(sourceFileUrl; Rec."Source File URL") { }
                field(status; Rec.Status) { Editable = false; }
                field(vendorNo; Rec."Vendor No.") { }
                field(vendorName; Rec."Vendor Name") { }
                field(requesterUserId; Rec."Requester User ID") { }
                field(currencyCode; Rec."Currency Code") { }
                field(documentDate; Rec."Document Date") { }
                field(requiredDate; Rec."Required Date") { }
                field(totalAmount; Rec."Total Amount") { Editable = false; }
                field(confidenceScore; Rec."Confidence Score") { Editable = false; }
                field(createdDocumentType; Rec."Created Document Type") { Editable = false; }
                field(createdDocumentNo; Rec."Created Document No.") { Editable = false; }
                field(errorMessage; Rec."Error Message") { Editable = false; }
                field(createdBy; Rec."Created By") { Editable = false; }
                field(createdDateTime; Rec."Created DateTime") { Editable = false; }
                field(modifiedBy; Rec."Modified By") { Editable = false; }
                field(modifiedDateTime; Rec."Modified DateTime") { Editable = false; }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec."Target Document Type" <> Rec."Target Document Type"::PurchaseRequisition then
            Error('Phase 1 only supports %1.', Format(Rec."Target Document Type"::PurchaseRequisition));

        Rec.Status := Rec.Status::Uploaded;
        exit(true);
    end;

    [ServiceEnabled]
    procedure AnalyzeDocument(var ActionContext: WebServiceActionContext)
    var
        SmartImportMgt: Codeunit "Smart Import Mgt";
    begin
        SmartImportMgt.AnalyzeImport(Rec);
        SetActionResponse(ActionContext, WebServiceActionResultCode::Updated);
    end;

    [ServiceEnabled]
    procedure CreateDocument(var ActionContext: WebServiceActionContext)
    var
        SmartImportMgt: Codeunit "Smart Import Mgt";
    begin
        SmartImportMgt.CreateDraftDocument(Rec);
        SetActionResponse(ActionContext, WebServiceActionResultCode::Updated);
    end;

    [ServiceEnabled]
    procedure RejectImport(var ActionContext: WebServiceActionContext)
    var
        SmartImportMgt: Codeunit "Smart Import Mgt";
    begin
        SmartImportMgt.RejectImport(Rec, 'Rejected from API action.');
        SetActionResponse(ActionContext, WebServiceActionResultCode::Updated);
    end;

    local procedure SetActionResponse(var ActionContext: WebServiceActionContext; ResultCode: WebServiceActionResultCode)
    begin
        ActionContext.SetObjectType(ObjectType::Page);
        ActionContext.SetObjectId(Page::"Smart Import API");
        ActionContext.AddEntityKey(Rec.FieldNo(SystemId), Rec.SystemId);
        ActionContext.SetResultCode(ResultCode);
    end;
}
