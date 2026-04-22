page 50151 "Sales Order Line API"
{
    PageType = API;
    Caption = 'Sales Order Lines', Locked = true;
    ChangeTrackingAllowed = true;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'salesOrderLine';
    EntitySetName = 'salesOrderLines';
    ODataKeyFields = "SystemId";
    SourceTable = "Sales Line";
    DelayedInsert = true;
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Id; Rec."SystemId")
                {
                    ApplicationArea = All;
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Document No.', Locked = true;
                }
                field(LineNo; Rec."Line No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Line No.', Locked = true;
                }
                field(DocumentType; Rec."Document Type")
                {
                    ApplicationArea = Suite;
                    Caption = 'Document Type', Locked = true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Suite;
                    Caption = 'Type', Locked = true;
                }
                field(No; Rec."No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'No.', Locked = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    Caption = 'Description', Locked = true;
                }
                field(Description2; Rec."Description 2")
                {
                    ApplicationArea = Suite;
                    Caption = 'Description 2', Locked = true;
                }
                field(UnitofMeasureCode; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Unit of Measure Code', Locked = true;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Suite;
                    Caption = 'Quantity', Locked = true;
                }
                field(QtytoShip; Rec."Qty. to Ship")
                {
                    ApplicationArea = Suite;
                    Caption = 'Qty. to Ship', Locked = true;
                }
                field(QtyShipped; Rec."Quantity Shipped")
                {
                    ApplicationArea = Suite;
                    Caption = 'Quantity Shipped', Locked = true;
                }
                field(UnitPrice; Rec."Unit Price")
                {
                    ApplicationArea = Suite;
                    Caption = 'Unit Price', Locked = true;
                }
                field(LineAmount; Rec."Line Amount")
                {
                    ApplicationArea = Suite;
                    Caption = 'Line Amount', Locked = true;
                }
                field(LineDiscount; Rec."Line Discount %")
                {
                    ApplicationArea = Suite;
                    Caption = 'Line Discount %', Locked = true;
                }
                field(LineDiscountAmount; Rec."Line Discount Amount")
                {
                    ApplicationArea = Suite;
                    Caption = 'Line Discount Amount', Locked = true;
                }
                field(AmountIncludingVAT; Rec."Amount Including VAT")
                {
                    ApplicationArea = Suite;
                    Caption = 'Amount Including VAT', Locked = true;
                }
                field(VATPercent; Rec."VAT %")
                {
                    ApplicationArea = Suite;
                    Caption = 'VAT %', Locked = true;
                }
                field(LocationCode; Rec."Location Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Location Code', Locked = true;
                }
                field(BinCode; Rec."Bin Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bin Code', Locked = true;
                }
                field(ShipmentDate; Rec."Shipment Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Shipment Date', Locked = true;
                }
                field(PromisedDeliveryDate; Rec."Promised Delivery Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Promised Delivery Date', Locked = true;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Currency Code', Locked = true;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Shortcut Dimension 1 Code', Locked = true;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Shortcut Dimension 2 Code', Locked = true;
                }
                field(JobNo; Rec."Job No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Job No.', Locked = true;
                }
                field(JobTaskNo; Rec."Job Task No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Job Task No.', Locked = true;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Suite;
                    Caption = 'Transaction Type', Locked = true;
                }
                field(TransportMethod; Rec."Transport Method")
                {
                    ApplicationArea = Suite;
                    Caption = 'Transport Method', Locked = true;
                }
                field(ItemCategoryCode; Rec."Item Category Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Category Code', Locked = true;
                }
            }
        }
    }
}
