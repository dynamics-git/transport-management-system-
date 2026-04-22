page 50525 "TMS POD Entry API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'podentry';
    EntitySetName = 'podentries';
    SourceTable = "TMS POD Entry";
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
                field(podDate; Rec."POD Date") { }
                field(receivedBy; Rec."Received By") { }
                field(photoPath; Rec."Photo Path") { }
                field(remarks; Rec."Remarks") { }
            }
        }
    }
}