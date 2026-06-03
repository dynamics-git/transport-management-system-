page 50601 "Freight Charges API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'freightChargeSetup';
    EntitySetName = 'freightChargeSetups';
    SourceTable = "Freight Charges";
    DelayedInsert = true;
    ODataKeyFields = "Code";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(code; Rec."Code") { }
                field(locationCode; Rec."Location Code") { }
                field(region; Rec."Region") { }
                field(loadType; Rec."Load Type") { }
                field(freightRate; Rec."Freight Rate") { }
                field(handlingCharge; Rec."Handling Charge") { }
                field(active; Rec."Active") { }
                field(remarks; Rec."Remarks") { }
            }
        }
    }
}