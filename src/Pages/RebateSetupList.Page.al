page 50000 "Rebate Setup List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rebate Setup Master";
    Caption = 'Rebate Setup List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Setup ID"; Rec."Setup ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
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
                }
                field("Rebate Type"; Rec."Rebate Type")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
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
            action("New Setup")
            {
                ApplicationArea = All;
                Caption = 'New Setup';
                Image = New;
                RunObject = Page "Rebate Setup Card";
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
            action("Setup Lines")
            {
                ApplicationArea = All;
                Caption = 'Setup Lines';
                Image = Line;
                RunObject = Page "Rebate Setup Subpage";
                RunPageLink = "Setup ID" = field("Setup ID");
            }
        }
    }
}