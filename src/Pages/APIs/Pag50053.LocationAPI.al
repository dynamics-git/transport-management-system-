page 50153 "Location API"
{
    APIGroup = 'procure';
    APIPublisher = 'tecsa';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'locationAPI';
    DelayedInsert = true;
    EntityName = 'location';
    EntitySetName = 'locations';
    PageType = API;
    SourceTable = Location;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(adjustmentBinCode; Rec."Adjustment Bin Code")
                {
                    Caption = 'Adjustment Bin Code';
                }
                field(allowBreakbulk; Rec."Allow Breakbulk")
                {
                    Caption = 'Allow Breakbulk';
                }
                field(alwaysCreatePickLine; Rec."Always Create Pick Line")
                {
                    Caption = 'Always Create Pick Line';
                }
                field(alwaysCreatePutAwayLine; Rec."Always Create Put-away Line")
                {
                    Caption = 'Always Create Put-away Line';
                }
                field(asmConsumpWhseHandling; Rec."Asm. Consump. Whse. Handling")
                {
                    Caption = 'Asm. Consump. Whse. Handling';
                }
                field(asmToOrderShptBinCode; Rec."Asm.-to-Order Shpt. Bin Code")
                {
                    Caption = 'Asm.-to-Order Shpt. Bin Code';
                }
                field(baseCalendarCode; Rec."Base Calendar Code")
                {
                    Caption = 'Base Calendar Code';
                }
                field(binCapacityPolicy; Rec."Bin Capacity Policy")
                {
                    Caption = 'Bin Capacity Policy';
                }
                field(binMandatory; Rec."Bin Mandatory")
                {
                    Caption = 'Bin Mandatory';
                }
                field(checkWhseClass; Rec."Check Whse. Class")
                {
                    Caption = 'Check Warehouse Class';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(crossDockBinCode; Rec."Cross-Dock Bin Code")
                {
                    Caption = 'Cross-Dock Bin Code';
                }
                field(crossDockDueDateCalc; Rec."Cross-Dock Due Date Calc.")
                {
                    Caption = 'Cross-Dock Due Date Calc.';
                }
                field(defaultBinCode; Rec."Default Bin Code")
                {
                    Caption = 'Default Bin Code';
                }
                field(defaultBinSelection; Rec."Default Bin Selection")
                {
                    Caption = 'Default Bin Selection';
                }
                field(directedPutAwayAndPick; Rec."Directed Put-away and Pick")
                {
                    Caption = 'Directed Put-away and Pick';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(fromAssemblyBinCode; Rec."From-Assembly Bin Code")
                {
                    Caption = 'From-Assembly Bin Code';
                }
                field(fromProductionBinCode; Rec."From-Production Bin Code")
                {
                    Caption = 'From-Production Bin Code';
                }
                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }
                field(inboundWhseHandlingTime; Rec."Inbound Whse. Handling Time")
                {
                    Caption = 'Inbound Whse. Handling Time';
                }
                field(jobConsumpWhseHandling; Rec."Job Consump. Whse. Handling")
                {
                    Caption = 'Project Consump. Whse. Handling';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(openShopFloorBinCode; Rec."Open Shop Floor Bin Code")
                {
                    Caption = 'Open Shop Floor Bin Code';
                }
                field(outboundWhseHandlingTime; Rec."Outbound Whse. Handling Time")
                {
                    Caption = 'Outbound Whse. Handling Time';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(phoneNo2; Rec."Phone No. 2")
                {
                    Caption = 'Phone No. 2';
                }
                field(pickAccordingToFEFO; Rec."Pick According to FEFO")
                {
                    Caption = 'Pick According to FEFO';
                }
                field(pickBinPolicy; Rec."Pick Bin Policy")
                {
                    Caption = 'Pick Bin Policy';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(prodConsumpWhseHandling; Rec."Prod. Consump. Whse. Handling")
                {
                    Caption = 'Prod. Consump. Whse. Handling';
                }
                field(prodOutputWhseHandling; Rec."Prod. Output Whse. Handling")
                {
                    Caption = 'Prod. Output Whse. Handling';
                }
                field(putAwayBinPolicy; Rec."Put-away Bin Policy")
                {
                    Caption = 'Put-away Bin Policy';
                }
                field(putAwayTemplateCode; Rec."Put-away Template Code")
                {
                    Caption = 'Put-away Template Code';
                }
                field(receiptBinCode; Rec."Receipt Bin Code")
                {
                    Caption = 'Receipt Bin Code';
                }
                field(requirePick; Rec."Require Pick")
                {
                    Caption = 'Require Pick';
                }
                field(requirePutAway; Rec."Require Put-away")
                {
                    Caption = 'Require Put-away';
                }
                field(requireReceive; Rec."Require Receive")
                {
                    Caption = 'Require Receive';
                }
                field(requireShipment; Rec."Require Shipment")
                {
                    Caption = 'Require Shipment';
                }
                field(shipmentBinCode; Rec."Shipment Bin Code")
                {
                    Caption = 'Shipment Bin Code';
                }
                field(specialEquipment; Rec."Special Equipment")
                {
                    Caption = 'Special Equipment';
                }
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
                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }
                field(toAssemblyBinCode; Rec."To-Assembly Bin Code")
                {
                    Caption = 'To-Assembly Bin Code';
                }
                field(toJobBinCode; Rec."To-Job Bin Code")
                {
                    Caption = 'To-Project Bin Code';
                }
                field(toProductionBinCode; Rec."To-Production Bin Code")
                {
                    Caption = 'To-Production Bin Code';
                }
                field(useADCS; Rec."Use ADCS")
                {
                    Caption = 'Use ADCS';
                }
                field(useAsInTransit; Rec."Use As In-Transit")
                {
                    Caption = 'Use As In-Transit';
                }
                field(useCrossDocking; Rec."Use Cross-Docking")
                {
                    Caption = 'Use Cross-Docking';
                }
                field(usePutAwayWorksheet; Rec."Use Put-away Worksheet")
                {
                    Caption = 'Use Put-away Worksheet';
                }
            }
        }
    }
}
