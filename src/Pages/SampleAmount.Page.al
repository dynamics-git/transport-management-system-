page 50011 "Sample Amount"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    Caption = 'Enter Sample Amount';

    layout
    {
        area(content)
        {
            field(Amount; Amount)
            {
                ApplicationArea = All;
                Caption = 'Sample Amount (RM/MT)';
            }
        }
    }

    var
        Amount: Decimal;

    procedure GetAmount(): Decimal
    begin
        exit(Amount);
    end;
}