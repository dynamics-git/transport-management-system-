codeunit 50620 "Smart Import Mgt"
{
    procedure GenerateImportNo(): Code[20]
    var
        SmartImportHeader: Record "Smart Import Header";
        GuidText: Text;
        CandidateImportNo: Code[20];
    begin
        repeat
            GuidText := DelChr(Format(CreateGuid()), '=', '{}-');
            CandidateImportNo := CopyStr(StrSubstNo('IMP%1', GuidText), 1, 20);
        until not SmartImportHeader.Get(CandidateImportNo);

        exit(CandidateImportNo);
    end;

    procedure AnalyzeImport(var ImportHeader: Record "Smart Import Header")
    begin
        ImportHeader.LockTable();
        ImportHeader.Get(ImportHeader."Import No.");

        EnsureImportEditable(ImportHeader);

        if ImportHeader.Status = ImportHeader.Status::Analyzing then
            Error('Import %1 is already being analyzed. Please retry after the current analysis completes.', ImportHeader."Import No.");

        ImportHeader.Validate(Status, ImportHeader.Status::Analyzing);
        ImportHeader.Modify(true);
        AddLog(ImportHeader."Import No.", 'Analyze', 'Analysis started.', Enum::"Smart Import Log Status"::Info);

        ClearStaging(ImportHeader."Import No.");
        CreateMockExtractedFields(ImportHeader);
        CreateMockExtractedLines(ImportHeader);

        ImportHeader.Validate(Status, ImportHeader.Status::ReviewRequired);
        ImportHeader."Error Message" := '';
        ImportHeader.Modify(true);
        AddLog(ImportHeader."Import No.", 'Analyze', 'Mock OCR extraction saved to staging tables.', Enum::"Smart Import Log Status"::Info);
    end;

    procedure CreateDraftDocument(var ImportHeader: Record "Smart Import Header")
    var
        CreatedDocumentNo: Code[20];
        ErrorMessage: Text;
    begin
        EnsureImportEditable(ImportHeader);
        ValidateImportForCreate(ImportHeader);

        ImportHeader.Validate(Status, ImportHeader.Status::ReadyToCreate);
        ImportHeader.Modify(true);
        AddLog(ImportHeader."Import No.", 'CreateDocument', 'Draft document creation started.', Enum::"Smart Import Log Status"::Info);

        if not TryCreateTargetDocument(ImportHeader, CreatedDocumentNo, ErrorMessage) then begin
            ErrorMessage := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Error Message"));
            FailImport(ImportHeader, ErrorMessage);
            Error(ErrorMessage);
        end;

        if (CreatedDocumentNo = '') then begin
            if ErrorMessage = '' then
                ErrorMessage := 'No target document number was returned by the creation handler.';
            FailImport(ImportHeader, ErrorMessage);
            Error(ErrorMessage);
        end;

        ImportHeader."Created Document Type" := ImportHeader."Target Document Type";
        ImportHeader."Created Document No." := CreatedDocumentNo;
        ImportHeader."Error Message" := '';
        ImportHeader.Validate(Status, ImportHeader.Status::Created);
        ImportHeader.Modify(true);

        AddLog(ImportHeader."Import No.", 'CreateDocument', StrSubstNo('Draft %1 %2 created using existing business logic.', Format(ImportHeader."Created Document Type"), CreatedDocumentNo), Enum::"Smart Import Log Status"::Info);

        TryAttachSourceDocument(ImportHeader);
    end;

    procedure RejectImport(var ImportHeader: Record "Smart Import Header"; RejectReason: Text)
    begin
        if ImportHeader.Status = ImportHeader.Status::Created then
            Error('Cannot reject import %1 because document %2 already exists.', ImportHeader."Import No.", ImportHeader."Created Document No.");

        ImportHeader.Validate(Status, ImportHeader.Status::Rejected);
        ImportHeader."Error Message" := CopyStr(RejectReason, 1, MaxStrLen(ImportHeader."Error Message"));
        ImportHeader.Modify(true);

        AddLog(
          ImportHeader."Import No.",
          'Reject',
          StrSubstNo('Import was rejected. Reason: %1', CopyStr(RejectReason, 1, 250)),
          Enum::"Smart Import Log Status"::Warning);
    end;

    local procedure ValidateImportForCreate(var ImportHeader: Record "Smart Import Header")
    var
        SmartImportField: Record "Smart Import Field";
        SmartImportLine: Record "Smart Import Line";
        ValueToUse: Text;
    begin
        if ImportHeader."Target Document Type" <> ImportHeader."Target Document Type"::PurchaseRequisition then
            Error('Phase 1 only supports %1.', Format(ImportHeader."Target Document Type"::PurchaseRequisition));

        SmartImportField.SetRange("Import No.", ImportHeader."Import No.");
        SmartImportField.SetRange("Is Required", true);
        if SmartImportField.FindSet() then
            repeat
                ValueToUse := SmartImportField."Corrected Value";
                if ValueToUse = '' then
                    ValueToUse := SmartImportField."Extracted Value";

                if ValueToUse = '' then
                    Error('Required field %1 does not have a value.', SmartImportField."Field Name");

                if SmartImportField."Validation Status" = SmartImportField."Validation Status"::Invalid then
                    Error('Field %1 is marked as invalid.', SmartImportField."Field Name");
            until SmartImportField.Next() = 0;

        SmartImportLine.SetRange("Import No.", ImportHeader."Import No.");
        if not SmartImportLine.FindSet() then
            Error('At least one import line is required before creating a draft document.');

        repeat
            if SmartImportLine.Quantity <= 0 then
                Error('Line %1 has invalid quantity.', SmartImportLine."Line No.");

            if SmartImportLine."Mapping Status" = SmartImportLine."Mapping Status"::Invalid then
                Error('Line %1 is marked as invalid.', SmartImportLine."Line No.");
        until SmartImportLine.Next() = 0;
    end;

    [TryFunction]
    local procedure TryCreateTargetDocument(var ImportHeader: Record "Smart Import Header"; var CreatedDocumentNo: Code[20]; var ErrorMessage: Text)
    var
        Handled: Boolean;
        CreatedDocumentType: Enum "Smart Import Target Doc Type";
    begin
        CreatedDocumentType := ImportHeader."Target Document Type";
        OnCreateTargetDocument(ImportHeader, CreatedDocumentType, CreatedDocumentNo, Handled, ErrorMessage);

        if (not Handled) and (ImportHeader."Target Document Type" = ImportHeader."Target Document Type"::PurchaseRequisition) then
            OnCreatePurchaseRequisitionDraft(ImportHeader, CreatedDocumentNo, Handled, ErrorMessage);

        if not Handled then
            Error('No creation handler is configured for target document type %1.', Format(ImportHeader."Target Document Type"));

        if ErrorMessage <> '' then
            Error(ErrorMessage);
    end;

    [TryFunction]
    local procedure TryAttachSourceDocument(var ImportHeader: Record "Smart Import Header")
    begin
        OnAttachSourceDocumentToCreatedDocument(ImportHeader);
    end;

    local procedure EnsureImportEditable(var ImportHeader: Record "Smart Import Header")
    begin
        if ImportHeader.Status in [ImportHeader.Status::Created, ImportHeader.Status::Rejected] then
            Error('Import %1 cannot be modified in status %2.', ImportHeader."Import No.", Format(ImportHeader.Status));
    end;

    local procedure FailImport(var ImportHeader: Record "Smart Import Header"; ErrorMessage: Text)
    begin
        ImportHeader.Validate(Status, ImportHeader.Status::Failed);
        ImportHeader."Error Message" := CopyStr(ErrorMessage, 1, MaxStrLen(ImportHeader."Error Message"));
        ImportHeader.Modify(true);

        AddLog(ImportHeader."Import No.", 'CreateDocument', ImportHeader."Error Message", Enum::"Smart Import Log Status"::Error);
    end;

    local procedure AddLog(ImportNo: Code[20]; Step: Text[100]; Message: Text; Status: Enum "Smart Import Log Status")
    var
        SmartImportLog: Record "Smart Import Log";
    begin
        SmartImportLog.Init();
        SmartImportLog."Import No." := ImportNo;
        SmartImportLog.Step := Step;
        SmartImportLog.Message := CopyStr(Message, 1, MaxStrLen(SmartImportLog.Message));
        SmartImportLog.Status := Status;
        SmartImportLog.Insert(true);
    end;

    local procedure ClearStaging(ImportNo: Code[20])
    var
        SmartImportLine: Record "Smart Import Line";
        SmartImportField: Record "Smart Import Field";
    begin
        SmartImportLine.LockTable();
        SmartImportLine.SetRange("Import No.", ImportNo);
        SmartImportLine.DeleteAll(true);

        SmartImportField.LockTable();
        SmartImportField.SetRange("Import No.", ImportNo);
        SmartImportField.DeleteAll(true);
    end;

    local procedure CreateMockExtractedFields(var ImportHeader: Record "Smart Import Header")
    begin
        InsertField(ImportHeader."Import No.", 'VendorNo', 'Vendor', '10000', 'Buy-from Vendor No.', 0.93, true);
        InsertField(ImportHeader."Import No.", 'VendorName', 'Vendor Name', 'Fabrikam, Inc.', 'Buy-from Vendor Name', 0.92, false);
        InsertField(ImportHeader."Import No.", 'CurrencyCode', 'Currency', 'MYR', 'Currency Code', 0.88, true);
        InsertField(ImportHeader."Import No.", 'DocumentDate', 'Document Date', Format(Today(), 0, 9), 'Document Date', 0.90, true);
        InsertField(ImportHeader."Import No.", 'RequiredDate', 'Required Date', Format(CalcDate('<+7D>', Today()), 0, 9), 'Requested Receipt Date', 0.89, true);

        ImportHeader."Vendor No." := '10000';
        ImportHeader."Vendor Name" := 'Fabrikam, Inc.';
        ImportHeader."Currency Code" := 'MYR';
        ImportHeader."Document Date" := Today();
        ImportHeader."Required Date" := CalcDate('<+7D>', Today());
        ImportHeader."Confidence Score" := 0.90;
        ImportHeader.Modify(true);
    end;

    local procedure InsertField(ImportNo: Code[20]; FieldName: Code[100]; SourceLabel: Text[100]; ExtractedValue: Text; TargetFieldName: Text[100]; ConfidenceScore: Decimal; IsRequired: Boolean)
    var
        SmartImportField: Record "Smart Import Field";
    begin
        SmartImportField.Init();
        SmartImportField."Import No." := ImportNo;
        SmartImportField."Field Name" := FieldName;
        SmartImportField."Source Label" := SourceLabel;
        SmartImportField."Extracted Value" := CopyStr(ExtractedValue, 1, MaxStrLen(SmartImportField."Extracted Value"));
        SmartImportField."Target Field Name" := TargetFieldName;
        SmartImportField."Confidence Score" := ConfidenceScore;
        SmartImportField."Is Required" := IsRequired;
        SmartImportField."Validation Status" := SmartImportField."Validation Status"::Pending;
        SmartImportField.Insert(true);
    end;

    local procedure CreateMockExtractedLines(var ImportHeader: Record "Smart Import Header")
    var
        SmartImportLine: Record "Smart Import Line";
    begin
        SmartImportLine.Init();
        SmartImportLine."Import No." := ImportHeader."Import No.";
        SmartImportLine."Target Document Type" := ImportHeader."Target Document Type";
        SmartImportLine."Item No." := '1896-S';
        SmartImportLine.Description := 'ATHENS Desk';
        SmartImportLine.Quantity := 5;
        SmartImportLine."Unit of Measure" := 'PCS';
        SmartImportLine."Unit Cost" := 100;
        SmartImportLine."Line Amount" := 500;
        SmartImportLine."Required Date" := CalcDate('<+7D>', Today());
        SmartImportLine."Confidence Score" := 0.87;
        SmartImportLine."Mapping Status" := SmartImportLine."Mapping Status"::NeedsReview;
        SmartImportLine.Insert(true);

        SmartImportLine.Init();
        SmartImportLine."Import No." := ImportHeader."Import No.";
        SmartImportLine."Target Document Type" := ImportHeader."Target Document Type";
        SmartImportLine."G/L Account No." := '61100';
        SmartImportLine.Description := 'Office Supplies';
        SmartImportLine.Quantity := 1;
        SmartImportLine."Unit of Measure" := 'PCS';
        SmartImportLine."Unit Cost" := 250;
        SmartImportLine."Line Amount" := 250;
        SmartImportLine."Required Date" := CalcDate('<+7D>', Today());
        SmartImportLine."Confidence Score" := 0.85;
        SmartImportLine."Mapping Status" := SmartImportLine."Mapping Status"::NeedsReview;
        SmartImportLine.Insert(true);

        ImportHeader."Total Amount" := 750;
        ImportHeader.Modify(true);
    end;

    [IntegrationEvent(false, false)]
    procedure OnCreateTargetDocument(var ImportHeader: Record "Smart Import Header"; var CreatedDocumentType: Enum "Smart Import Target Doc Type"; var CreatedDocumentNo: Code[20]; var Handled: Boolean; var ErrorMessage: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCreatePurchaseRequisitionDraft(var ImportHeader: Record "Smart Import Header"; var CreatedDocumentNo: Code[20]; var Handled: Boolean; var ErrorMessage: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAttachSourceDocumentToCreatedDocument(var ImportHeader: Record "Smart Import Header")
    begin
    end;
}
