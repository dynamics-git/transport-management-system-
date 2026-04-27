table 50812 "Rebate Transaction"
{
    Caption = 'Rebate Transaction';
    DataClassification = CustomerContent;
    LookupPageId = "Rebate Transaction List";
    DrillDownPageId = "Rebate Transaction List";

    fields
    {
        field(1; "Transaction ID"; Code[20])
        {
            Caption = 'Transaction ID';
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionMembers = "Purchase Order","Sales Order","Purchase Invoice","Sales Invoice","Custom";
            OptionCaption = 'Purchase Order,Sales Order,Purchase Invoice,Sales Invoice,Custom';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(6; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if "Item No." <> '' then begin
                    Item.Get("Item No.");
                    "Item Description" := Item.Description;
                end else
                    "Item Description" := '';
            end;
        }
        field(7; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                CalculateLineAmount();
                SuggestRebate();
            end;
        }
        field(9; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;

            trigger OnValidate()
            begin
                CalculateLineAmount();
                SuggestRebate();
            end;
        }
        field(10; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(11; "Entity Type"; Enum "Entity Type")
        {
            Caption = 'Entity Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Clear("Entity ID");
                Clear("Entity Name");
                SuggestRebate();
            end;
        }
        field(12; "Entity ID"; Code[20])
        {
            Caption = 'Entity ID';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateEntity();
                SuggestRebate();
            end;
        }
        field(13; "Entity Name"; Text[100])
        {
            Caption = 'Entity Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Setup ID"; Code[20])
        {
            Caption = 'Setup ID';
            DataClassification = CustomerContent;
            TableRelation = "Rebate Setup Master" where(Status = const(Approved));

            trigger OnValidate()
            begin
                if "Setup ID" <> '' then
                    CalculateRebateComponents()
                else
                    ClearRebateComponents();
            end;
        }
        field(15; "Market Rebate"; Decimal)
        {
            Caption = 'Market Rebate (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(16; EPI; Decimal)
        {
            Caption = 'EPI (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(17; PPI; Decimal)
        {
            Caption = 'PPI (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(18; VI; Decimal)
        {
            Caption = 'VI (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(19; "Additional Rebate"; Decimal)
        {
            Caption = 'Additional Rebate (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(20; "Special Rebate"; Decimal)
        {
            Caption = 'Special Rebate (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(21; "Total Rebate"; Decimal)
        {
            Caption = 'Total Rebate (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(22; "Proposed Adjustment"; Decimal)
        {
            Caption = 'Proposed Adjustment (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                CalculateTotalRebate();
            end;
        }
        field(23; "Final Rebate"; Decimal)
        {
            Caption = 'Final Rebate (RM/MT)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(24; Status; Enum "Rebate Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            InitValue = Draft;

            trigger OnValidate()
            begin
                if Status = Status::Applied then
                    ValidateApplication();
            end;
        }
        field(25; "Applied Date"; DateTime)
        {
            Caption = 'Applied Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "Applied By"; Code[50])
        {
            Caption = 'Applied By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(27; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(28; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(29; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Transaction ID")
        {
            Clustered = true;
        }
        key(Document; "Document Type", "Document No.", "Line No.")
        {
        }
        key(Item; "Item No.")
        {
        }
        key(Entity; "Entity Type", "Entity ID")
        {
        }
        key(Setup; "Setup ID")
        {
        }
        key(Status; Status)
        {
        }
        key(Date; "Posting Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;

    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;

    trigger OnDelete()
    var
        RebateTransactionLine: Record "Rebate Transaction Line";
    begin
        if Status = Status::Applied then
            Error('Cannot delete applied rebate transactions');

        RebateTransactionLine.SetRange("Transaction ID", "Transaction ID");
        RebateTransactionLine.DeleteAll(true);
    end;

    local procedure CalculateLineAmount()
    begin
        "Line Amount" := Quantity * "Unit Price";
    end;

    local procedure ValidateEntity()
    begin
        case "Entity Type" of
            "Entity Type"::Customer:
                ValidateCustomer();
            "Entity Type"::Vendor:
                ValidateVendor();
            "Entity Type"::"Project Support",
            "Entity Type"::"End User":
                ValidateProjectEntity();
        end;
    end;

    local procedure ValidateCustomer()
    var
        Customer: Record Customer;
    begin
        if "Entity ID" <> '' then begin
            Customer.Get("Entity ID");
            "Entity Name" := Customer.Name;
        end else
            "Entity Name" := '';
    end;

    local procedure ValidateVendor()
    var
        Vendor: Record Vendor;
    begin
        if "Entity ID" <> '' then begin
            Vendor.Get("Entity ID");
            "Entity Name" := Vendor.Name;
        end else
            "Entity Name" := '';
    end;

    local procedure ValidateProjectEntity()
    begin
        "Entity Name" := "Entity ID";
    end;

    local procedure SuggestRebate()
    var
        RebateMatchingEngine: Codeunit "Rebate Matching Engine";
    begin
        if ("Item No." <> '') and ("Entity ID" <> '') and ("Posting Date" <> 0D) then
            RebateMatchingEngine.SuggestRebateSetup(Rec);
    end;

    local procedure CalculateRebateComponents()
    var
        RebateCalculationEngine: Codeunit "Rebate Calculation Engine";
    begin
        RebateCalculationEngine.CalculateRebateComponents(Rec);
    end;

    local procedure ClearRebateComponents()
    begin
        "Market Rebate" := 0;
        EPI := 0;
        PPI := 0;
        VI := 0;
        "Additional Rebate" := 0;
        "Special Rebate" := 0;
        "Total Rebate" := 0;
        "Proposed Adjustment" := 0;
        "Final Rebate" := 0;
    end;

    local procedure CalculateTotalRebate()
    begin
        "Total Rebate" := "Market Rebate" + EPI + PPI + VI + "Additional Rebate" + "Special Rebate";
        "Final Rebate" := "Total Rebate" + "Proposed Adjustment";
    end;

    local procedure ValidateApplication()
    begin
        if "Final Rebate" = 0 then
            Error('Cannot apply rebate transaction with zero final rebate amount');

        "Applied Date" := CurrentDateTime;
        "Applied By" := UserId;
    end;
}