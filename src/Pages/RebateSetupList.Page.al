page 50500 "Rebate Setup List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rebate Setup Master";
    Caption = 'Rebate Setup List';
    CardPageId = "Rebate Setup Card";

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
                var
                    RebateSetupMaster: Record "Rebate Setup Master";
                    NewRebateSetupMaster: Record "Rebate Setup Master";
                    NewRebateSetupLine: Record "Rebate Setup Line";
                    RebateSetupLine: Record "Rebate Setup Line";
                    NewSetupID: Code[20];
                begin
                    if not RebateSetupMaster.Get(Rec."Setup ID") then
                        exit;

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
                    NewRebateSetupMaster := RebateSetupMaster;
                    NewRebateSetupMaster."Setup ID" := NewSetupID;
                    NewRebateSetupMaster.Description := CopyStr(RebateSetupMaster.Description + ' (Copy)', 1, 100);
                    NewRebateSetupMaster.Status := NewRebateSetupMaster.Status::Draft;
                    NewRebateSetupMaster.Insert();

                    // Copy setup lines
                    RebateSetupLine.SetRange("Setup ID", RebateSetupMaster."Setup ID");
                    if RebateSetupLine.FindSet() then
                        repeat
                            NewRebateSetupLine := RebateSetupLine;
                            NewRebateSetupLine."Setup ID" := NewSetupID;
                            NewRebateSetupLine.Insert();
                        until RebateSetupLine.Next() = 0;

                    Message('Setup %1 has been copied to %2', RebateSetupMaster."Setup ID", NewSetupID);
                    CurrPage.Update();
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