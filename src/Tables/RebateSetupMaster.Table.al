table 50810 "Rebate Setup Master"
{
    Caption = 'Rebate Setup Master';
    DataClassification = CustomerContent;
    LookupPageId = "Rebate Setup List";
    DrillDownPageId = "Rebate Setup List";

    fields
    {
        field(1; "Setup ID"; Code[20])
        {
            Caption = 'Setup ID';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("To Date" <> 0D) and ("From Date" > "To Date") then
                    Error('From Date cannot be after To Date');
            end;
        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("From Date" <> 0D) and ("To Date" < "From Date") then
                    Error('To Date cannot be before From Date');
            end;
        }
        field(5; "Item No."; Code[20])
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
        field(6; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Entity Type"; Enum "Entity Type")
        {
            Caption = 'Entity Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Clear("Entity ID");
                Clear("Entity Name");
            end;
        }
        field(8; "Entity ID"; Code[20])
        {
            Caption = 'Entity ID';
            DataClassification = CustomerContent;

            trigger OnValidate()
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
        }
        field(9; "Entity Name"; Text[100])
        {
            Caption = 'Entity Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Rebate Type"; Enum "Rebate Type")
        {
            Caption = 'Rebate Type';
            DataClassification = CustomerContent;
        }
        field(11; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
            MinValue = 1;
            MaxValue = 999;
        }
        field(12; Status; Enum "Rebate Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            InitValue = Draft;
        }
        field(13; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Setup ID")
        {
            Clustered = true;
        }
        key(Date; "From Date", "To Date")
        {
        }
        key(Item; "Item No.")
        {
        }
        key(Entity; "Entity Type", "Entity ID")
        {
        }
        key(Priority; Priority)
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
        RebateSetupLine: Record "Rebate Setup Line";
    begin
        RebateSetupLine.SetRange("Setup ID", "Setup ID");
        RebateSetupLine.DeleteAll(true);
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
        // For Project Support and End User, we can use a custom table or text field
        // For demo purposes, we'll just set the name to the ID
        "Entity Name" := "Entity ID";
    end;
}