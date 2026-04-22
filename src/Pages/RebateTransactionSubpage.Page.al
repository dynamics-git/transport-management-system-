page 50105 "Rebate Transaction Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Rebate Transaction Line";
    Caption = 'Rebate Components';

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
                field("Base Amount"; Rec."Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Rebate Amount"; Rec."Rebate Amount")
                {
                    ApplicationArea = All;
                }
                field("Setup ID"; Rec."Setup ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
