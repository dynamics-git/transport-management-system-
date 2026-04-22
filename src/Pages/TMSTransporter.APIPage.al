page 50520 "TMS Transporter API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'transporter';
    EntitySetName = 'transporters';
    SourceTable = "TMS Transporter";
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
                field(phoneNo; Rec."Phone No.") { }
                field(email; Rec."Email") { }
                field(active; Rec."Active") { }
                field(defaultFreightType; Rec."Default Freight Type") { }
                field(remarks; Rec."Remarks") { }
            }
        }
    }
}