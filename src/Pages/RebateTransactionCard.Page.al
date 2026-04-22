page 50504 "Rebate Transaction Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Rebate Transaction";
    Caption = 'Rebate Transaction Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group(Product)
            {
                Caption = 'Product & Quantity';

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Entity)
            {
                Caption = 'Entity';

                field("Entity Type"; Rec."Entity Type")
                {
                    ApplicationArea = All;
                }
                field("Entity ID"; Rec."Entity ID")
                {
                    ApplicationArea = All;
                }
                field("Entity Name"; Rec."Entity Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Rebate)
            {
                Caption = 'Rebate Calculation';

                field("Setup ID"; Rec."Setup ID")
                {
                    ApplicationArea = All;
                }
                field("Market Rebate"; Rec."Market Rebate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(EPI; Rec.EPI)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(PPI; Rec.PPI)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(VI; Rec.VI)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Additional Rebate"; Rec."Additional Rebate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Special Rebate"; Rec."Special Rebate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Rebate"; Rec."Total Rebate")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Proposed Adjustment"; Rec."Proposed Adjustment")
                {
                    ApplicationArea = All;
                    Style = Attention;
                }
                field("Final Rebate"; Rec."Final Rebate")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                }
            }
            part("Rebate Components"; "Rebate Transaction Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Transaction ID" = field("Transaction ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Suggest Rebate")
            {
                ApplicationArea = All;
                Caption = 'Suggest Rebate';
                Image = Suggest;
                Visible = Rec.Status = Rec.Status::Draft;

                trigger OnAction()
                var
                    RebateMatchingEngine: Codeunit "Rebate Matching Engine";
                begin
                    RebateMatchingEngine.SuggestRebateSetup(Rec);
                    CurrPage.Update();
                end;
            }
            action("Recalculate")
            {
                ApplicationArea = All;
                Caption = 'Recalculate';
                Image = Calculate;
                Visible = Rec."Setup ID" <> '';

                trigger OnAction()
                var
                    RebateCalculationEngine: Codeunit "Rebate Calculation Engine";
                begin
                    RebateCalculationEngine.RecalculateRebate(Rec."Transaction ID");
                    CurrPage.Update();
                end;
            }
            action("Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Visible = Rec.Status = Rec.Status::Suggested;

                trigger OnAction()
                var
                    RebateApplicationManager: Codeunit "Rebate Application Manager";
                begin
                    RebateApplicationManager.ApproveRebate(Rec);
                    CurrPage.Update();
                end;
            }
            action("Apply Rebate")
            {
                ApplicationArea = All;
                Caption = 'Apply Rebate';
                Image = Apply;
                Visible = Rec.Status = Rec.Status::Approved;

                trigger OnAction()
                var
                    RebateApplicationManager: Codeunit "Rebate Application Manager";
                begin
                    RebateApplicationManager.ApplyRebate(Rec);
                    CurrPage.Update();
                end;
            }
        }
        area(navigation)
        {
            action("View Document")
            {
                ApplicationArea = All;
                Caption = 'View Document';
                Image = Document;

                trigger OnAction()
                begin
                    ViewSourceDocument();
                end;
            }
            action("View Setup")
            {
                ApplicationArea = All;
                Caption = 'View Setup';
                Image = Setup;
                Visible = Rec."Setup ID" <> '';

                trigger OnAction()
                var
                    RebateSetupMaster: Record "Rebate Setup Master";
                    RebateSetupCard: Page "Rebate Setup Card";
                begin
                    RebateSetupMaster.Get(Rec."Setup ID");
                    RebateSetupCard.SetRecord(RebateSetupMaster);
                    RebateSetupCard.Run();
                end;
            }
        }
    }

    local procedure ViewSourceDocument()
    var
        PurchaseOrder: Page "Purchase Order";
        SalesOrder: Page "Sales Order";
        PurchaseInvoice: Page "Posted Purchase Invoice";
        SalesInvoice: Page "Posted Sales Invoice";
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        case Rec."Document Type" of
            Rec."Document Type"::"Purchase Order":
                begin
                    PurchaseHeader := GetPurchaseHeader();
                    PurchaseOrder.SetRecord(PurchaseHeader);
                    PurchaseOrder.Run();
                end;
            Rec."Document Type"::"Sales Order":
                begin
                    SalesHeader := GetSalesHeader();
                    SalesOrder.SetRecord(SalesHeader);
                    SalesOrder.Run();
                end;
            Rec."Document Type"::"Purchase Invoice":
                begin
                    PurchInvHeader := GetPurchaseInvoiceHeader();
                    PurchaseInvoice.SetRecord(PurchInvHeader);
                    PurchaseInvoice.Run();
                end;
            Rec."Document Type"::"Sales Invoice":
                begin
                    SalesInvHeader := GetSalesInvoiceHeader();
                    SalesInvoice.SetRecord(SalesInvHeader);
                    SalesInvoice.Run();
                end;
        end;
    end;

    local procedure GetPurchaseHeader(): Record "Purchase Header"
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, Rec."Document No.");
        exit(PurchaseHeader);
    end;

    local procedure GetSalesHeader(): Record "Sales Header"
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Document No.");
        exit(SalesHeader);
    end;

    local procedure GetPurchaseInvoiceHeader(): Record "Purch. Inv. Header"
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        PurchInvHeader.Get(Rec."Document No.");
        exit(PurchInvHeader);
    end;

    local procedure GetSalesInvoiceHeader(): Record "Sales Invoice Header"
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.Get(Rec."Document No.");
        exit(SalesInvoiceHeader);
    end;
}
