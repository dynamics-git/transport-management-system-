page 50622 "TMS Route Trip Header API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'routetripheader';
    EntitySetName = 'routetripheaders';
    SourceTable = "TMS Route Trip Header";
    DelayedInsert = true;
    ODataKeyFields = "Trip No.";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(tripNo; Rec."Trip No.") { }
                field(plannedDate; Rec."Planned Date") { }
                field(locationCode; Rec."Hub Location Code") { }
                field(loadType; Rec."Load Type") { }
                field(transporterNo; Rec."Transporter Code") { }
                field(truckNo; Rec."Truck No.") { }
                field(status; Rec."Status") { }
                field(totalWeightTonne; Rec."Total Weight") { }
                field(totalBags; Rec."Total Bags") { }
                field(podReceived; Rec."POD Received") { }
                field(podDate; Rec."POD Date") { }
                field(notes; Rec."Notes") { }
                field(createdBy; Rec."Created By") { }
                field(createdAt; Rec."Created At") { }
                field(plannedAt; Rec."Planned At") { }
                field(loadedAt; Rec."Loaded At") { }
                field(dispatchedAt; Rec."Dispatched At") { }
                field(deliveredAt; Rec."Delivered At") { }
                field(podPendingAt; Rec."POD Pending At") { }
                field(closedAt; Rec."Closed At") { }
                field(lastStatusChangedAt; Rec."Last Status Changed At") { }
                field(lastStatusChangedBy; Rec."Last Status Changed By") { }
                field(portalUserId; Rec."Portal User ID") { }
            }
        }
    }
}
