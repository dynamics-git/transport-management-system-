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
    ODataKeyFields = SystemId;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(tripNo; Rec."Trip No.") { }
                field(plannedDate; Rec."Planned Date") { }
                field(hubLocationCode; Rec."Hub Location Code") { }
                field(loadType; Rec."Load Type") { }
                field(transporterCode; Rec."Transporter Code") { }
                field(truckNo; Rec."Truck No.") { }
                field(status; Rec."Status") { }
                field(totalWeight; Rec."Total Weight") { }
                field(totalBags; Rec."Total Bags") { }
                field(podReceived; Rec."POD Received") { }
                field(podDate; Rec."POD Date") { }
                field(notes; Rec."Notes") { }
                field(createdBy; Rec."Created By") { }
                field(createdAt; Rec."Created At") { }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
