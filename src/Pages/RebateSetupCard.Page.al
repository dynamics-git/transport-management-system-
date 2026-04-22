page 50001 "Rebate Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Rebate Setup Master";
    Caption = 'Rebate Setup Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Setup ID"; Rec."Setup ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Rebate Type"; Rec."Rebate Type")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Lower number = higher priority';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group(Validity)
            {
                Caption = 'Validity Period';

                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Product)
            {
                Caption = 'Product';

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Entity)
            {
                Caption = 'Entity (Customer/Vendor/Project)';

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
            part("Rebate Setup Lines"; "Rebate Setup Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Setup ID" = field("Setup ID");
            }
        }
        area(factboxes)
        {
            part("Rebate Setup FactBox"; "Rebate Setup FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Setup ID" = field("Setup ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Approve Setup")
            {
                ApplicationArea = All;
                Caption = 'Approve Setup';
                Image = Approve;
                Visible = Rec.Status = Rec.Status::Draft;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify();
                    Message('Rebate setup has been approved.');
                end;
            }
            action("Copy Setup")
            {
                ApplicationArea = All;
                Caption = 'Copy Setup';
                Image = Copy;

                trigger OnAction()
                begin
                    Message('Copy functionality will be implemented in future version.');
                end;
            }
        }
        area(navigation)
        {
            action("Rebate Transactions")
            {
                ApplicationArea = All;
                Caption = 'Rebate Transactions';
                Image = Ledger;
                RunObject = Page "Rebate Transaction List";
                RunPageLink = "Setup ID" = field("Setup ID");
            }
        }
    }
}