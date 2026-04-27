table 50610 "Smart Import Header"
{
    Caption = 'Smart Import Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Import No."; Code[20])
        {
            Caption = 'Import No.';
        }
        field(2; "Target Document Type"; Enum "Smart Import Target Doc Type")
        {
            Caption = 'Target Document Type';
            InitValue = PurchaseRequisition;
        }
        field(3; "Source File Name"; Text[250])
        {
            Caption = 'Source File Name';
        }
        field(4; "Source File Extension"; Text[10])
        {
            Caption = 'Source File Extension';
        }
        field(5; "Source File Content"; Media)
        {
            Caption = 'Source File Content';
        }
        field(6; "Source File URL"; Text[2048])
        {
            Caption = 'Source File URL';
        }
        field(7; Status; Enum "Smart Import Status")
        {
            Caption = 'Status';
            InitValue = Uploaded;
        }
        field(8; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(9; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
        }
        field(10; "Requester User ID"; Code[50])
        {
            Caption = 'Requester User ID';
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(12; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(13; "Required Date"; Date)
        {
            Caption = 'Required Date';
        }
        field(14; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            AutoFormatType = 1;
        }
        field(15; "Confidence Score"; Decimal)
        {
            Caption = 'Confidence Score';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Created Document Type"; Enum "Smart Import Target Doc Type")
        {
            Caption = 'Created Document Type';
        }
        field(17; "Created Document No."; Code[20])
        {
            Caption = 'Created Document No.';
        }
        field(18; "Error Message"; Text[2048])
        {
            Caption = 'Error Message';
        }
        field(19; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(20; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            Editable = false;
        }
        field(21; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            Editable = false;
        }
        field(22; "Modified DateTime"; DateTime)
        {
            Caption = 'Modified DateTime';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Import No.")
        {
            Clustered = true;
        }
        key(SystemIdKey; SystemId)
        {
        }
    }

    trigger OnInsert()
    var
        SmartImportMgt: Codeunit "Smart Import Mgt";
    begin
        if "Import No." = '' then
            "Import No." := SmartImportMgt.GenerateImportNo();

        if "Requester User ID" = '' then
            "Requester User ID" := CopyStr(UserId(), 1, MaxStrLen("Requester User ID"));

        if "Target Document Type" <> "Target Document Type"::PurchaseRequisition then
            Error('Phase 1 only supports %1.', Format("Target Document Type"::PurchaseRequisition));

        Status := Status::Uploaded;
        "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
        "Created DateTime" := CurrentDateTime();
        "Modified By" := "Created By";
        "Modified DateTime" := "Created DateTime";
    end;

    trigger OnModify()
    begin
        "Modified By" := CopyStr(UserId(), 1, MaxStrLen("Modified By"));
        "Modified DateTime" := CurrentDateTime();
    end;

    trigger OnDelete()
    var
        SmartImportLine: Record "Smart Import Line";
        SmartImportField: Record "Smart Import Field";
        SmartImportLog: Record "Smart Import Log";
    begin
        if Status = Status::Created then
            Error('Cannot delete import %1 because it is already created.', "Import No.");

        SmartImportLine.SetRange("Import No.", "Import No.");
        SmartImportLine.DeleteAll(true);

        SmartImportField.SetRange("Import No.", "Import No.");
        SmartImportField.DeleteAll(true);

        SmartImportLog.SetRange("Import No.", "Import No.");
        SmartImportLog.DeleteAll(true);
    end;
}
