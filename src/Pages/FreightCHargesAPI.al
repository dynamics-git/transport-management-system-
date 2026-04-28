page 50601 "Freight Charges API"
{
    APIGroup = 'procure';
    APIPublisher = 'tecsa';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'freightCHargesAPI';
    DelayedInsert = true;
    EntityName = 'freightCharge';
    EntitySetName = 'freightCharges';
    PageType = API;
    SourceTable = "Freight Charges";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(active; Rec.Active)
                {
                    Caption = 'Active';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(freightRate; Rec."Freight Rate")
                {
                    Caption = 'Freight Rate';
                }
                field(handlingCharge; Rec."Handling Charge")
                {
                    Caption = 'Handling Charge';
                }
                field(loadType; Rec."Load Type")
                {
                    Caption = 'Load Type';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(region; Rec.Region)
                {
                    Caption = 'Region';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
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
            }
        }
    }
}
