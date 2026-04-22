page 50521 "TMS Truck API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'truck';
    EntitySetName = 'trucks';
    SourceTable = "TMS Truck";
    DelayedInsert = true;
    ODataKeyFields = "Truck No.";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(truckNo; Rec."Truck No.") { }
                field(transporterCode; Rec."Transporter Code") { }
                field(plateNo; Rec."Plate No.") { }
                field(loadType; Rec."Load Type") { }
                field(capacityTonne; Rec."Capacity Tonne") { }
                field(gpsEnabled; Rec."GPS Enabled") { }
                field(active; Rec."Active") { }
            }
        }
    }
}