table 50611 "Smart Import Line"
{
    Caption = 'Smart Import Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Import No."; Code[20])
        {
            Caption = 'Import No.';
            TableRelation = "Smart Import Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Target Document Type"; Enum "Smart Import Target Doc Type")
        {
            Caption = 'Target Document Type';
            InitValue = PurchaseRequisition;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(5; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(8; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(9; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            AutoFormatType = 2;
            DecimalPlaces = 0 : 5;
        }
        field(10; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            AutoFormatType = 1;
        }
        field(11; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(12; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
            TableRelation = Job;
        }
        field(13; "Required Date"; Date)
        {
            Caption = 'Required Date';
        }
        field(14; "Confidence Score"; Decimal)
        {
            Caption = 'Confidence Score';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Mapping Status"; Enum "Smart Import Line Map Status")
        {
            Caption = 'Mapping Status';
            InitValue = Pending;
        }
        field(16; "Error Message"; Text[2048])
        {
            Caption = 'Error Message';
        }
    }

    keys
    {
        key(PK; "Import No.", "Line No.")
        {
            Clustered = true;
        }
        key(SystemIdKey; SystemId)
        {
        }
    }

    trigger OnInsert()
    var
        SmartImportLine: Record "Smart Import Line";
    begin
        if "Target Document Type" <> "Target Document Type"::PurchaseRequisition then
            Error('Phase 1 only supports %1.', Format("Target Document Type"::PurchaseRequisition));

        if "Line No." = 0 then begin
            SmartImportLine.LockTable();
            SmartImportLine.SetRange("Import No.", "Import No.");
            if SmartImportLine.FindLast() then
                "Line No." := SmartImportLine."Line No." + 10000
            else
                "Line No." := 10000;
        end;
    end;
}
