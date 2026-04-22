page 50101 "Rebate Setup Card"
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
                    TableRelation = if ("Entity Type" = const("Customer")) Customer."No." else
                    if ("Entity Type" = const("Vendor")) Vendor."No.";
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
                var
                    NewRebateSetupMaster: Record "Rebate Setup Master";
                    NewRebateSetupLine: Record "Rebate Setup Line";
                    RebateSetupLine: Record "Rebate Setup Line";
                    NewSetupID: Code[20];
                begin
                    // Generate new setup ID
                    NewSetupID := CopyStr(Rec."Setup ID" + '-COPY', 1, 20);

                    // Check if the new ID already exists and increment if needed
                    while NewRebateSetupMaster.Get(NewSetupID) do begin
                        if StrLen(NewSetupID) < 20 then
                            NewSetupID := CopyStr(NewSetupID + '1', 1, 20)
                        else
                            Error('Cannot generate unique setup ID for copy');
                    end;

                    // Copy master record
                    NewRebateSetupMaster := Rec;
                    NewRebateSetupMaster."Setup ID" := NewSetupID;
                    NewRebateSetupMaster.Description := CopyStr(Rec.Description + ' (Copy)', 1, 100);
                    NewRebateSetupMaster.Status := NewRebateSetupMaster.Status::Draft;
                    NewRebateSetupMaster.Insert();

                    // Copy setup lines
                    RebateSetupLine.SetRange("Setup ID", Rec."Setup ID");
                    if RebateSetupLine.FindSet() then
                        repeat
                            NewRebateSetupLine := RebateSetupLine;
                            NewRebateSetupLine."Setup ID" := NewSetupID;
                            NewRebateSetupLine.Insert();
                        until RebateSetupLine.Next() = 0;

                    Message('Setup %1 has been copied to %2', Rec."Setup ID", NewSetupID);
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