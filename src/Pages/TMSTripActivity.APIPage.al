page 50628 "TMS Trip Activity API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'tripactivity';
    EntitySetName = 'tripactivities';
    SourceTable = "TMS Trip Activity";
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
                field(activityType; Rec."Activity Type") { }
                field(activityLabel; Rec."Activity Label") { }
                field(activityAt; Rec."Activity At") { }
                field(portalUserId; Rec."Portal User ID") { }
                field(bcUserId; Rec."BC User ID") { }
                field(sourceTable; Rec."Source Table") { }
                field(oldValue; Rec."Old Value") { }
                field(newValue; Rec."New Value") { }
                field(details; Rec.Details) { }
            }
        }
    }
}
