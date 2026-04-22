page 50510 "Rebate Setup FactBox"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = "Rebate Setup Master";
    Caption = 'Rebate Setup Details';

    layout
    {
        area(content)
        {
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
            field("From Date"; Rec."From Date")
            {
                ApplicationArea = All;
            }
            field("To Date"; Rec."To Date")
            {
                ApplicationArea = All;
            }
            field("Entity Type"; Rec."Entity Type")
            {
                ApplicationArea = All;
            }
            field("Entity Name"; Rec."Entity Name")
            {
                ApplicationArea = All;
            }
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = All;
            }
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
            }
        }
    }
}
