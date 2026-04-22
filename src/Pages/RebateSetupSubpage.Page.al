page 50502 "Rebate Setup Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Rebate Setup Line";
    Caption = 'Rebate Setup Lines';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Component Type"; Rec."Component Type")
                {
                    ApplicationArea = All;
                }
                field("Rebate %"; Rec."Rebate %")
                {
                    ApplicationArea = All;
                }
                field("Rebate Amount"; Rec."Rebate Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Min. Quantity"; Rec."Min. Quantity")
                {
                    ApplicationArea = All;
                }
                field("Max. Quantity"; Rec."Max. Quantity")
                {
                    ApplicationArea = All;
                }
                field("Min. Amount"; Rec."Min. Amount")
                {
                    ApplicationArea = All;
                }
                field("Max. Amount"; Rec."Max. Amount")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculate Sample")
            {
                ApplicationArea = All;
                Caption = 'Calculate Sample';
                Image = Calculate;

                trigger OnAction()
                var
                    SampleAmountPage: Page "Sample Amount";
                    SampleAmount: Decimal;
                begin
                    SampleAmountPage.LookupMode(true);
                    if SampleAmountPage.RunModal() = Action::LookupOK then begin
                        SampleAmount := SampleAmountPage.GetAmount();
                        Rec."Rebate Amount" := Round(SampleAmount * Rec."Rebate %" / 100, 0.01);
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    var
        SampleAmount: Decimal;

    local procedure GetPage(var Amount: Decimal): Boolean
    var
        SampleAmountPage: Page "Sample Amount";
    begin
        SampleAmountPage.LookupMode(true);
        if SampleAmountPage.RunModal() = Action::LookupOK then begin
            Amount := SampleAmountPage.GetAmount();
            exit(true);
        end;
        exit(false);
    end;
}