page 50526 "TMS Location API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'location';
    EntitySetName = 'locations';
    SourceTable = Location;
    DelayedInsert = true;
    ODataKeyFields = "Code";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(code; Rec."Code") { }
                field(name; Rec."Name") { }
                field(address; Rec."Address") { }
                field(city; Rec."City") { }
                field(postCode; Rec."Post Code") { }
            }
        }
    }
}