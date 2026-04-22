page 50524 "TMS Weighbridge Entry API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'weighbridgeentry';
    EntitySetName = 'weighbridgeentries';
    SourceTable = "TMS Weighbridge Entry";
    DelayedInsert = true;
    ODataKeyFields = "Entry No.";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(entryNo; Rec."Entry No.") { }
                field(tripNo; Rec."Trip No.") { }
                field(tareWeight; Rec."Tare Weight") { }
                field(grossWeight; Rec."Gross Weight") { }
                field(netWeight; Rec."Net Weight") { }
                field(overload; Rec."Overload") { }
                field(recordedBy; Rec."Recorded By") { }
                field(recordedAt; Rec."Recorded At") { }
            }
        }
    }
}