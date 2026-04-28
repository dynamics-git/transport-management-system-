page 50623 "TMS Route Trip Line API"
{
    PageType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'routetripline';
    EntitySetName = 'routetriplines';
    SourceTable = "TMS Route Trip Line";
    DelayedInsert = true;
    ODataKeyFields = "Trip No.", "Line No.";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(tripNo; Rec."Trip No.") { }
                field(lineNo; Rec."Line No.") { }
                field(sourceDocumentType; Rec."Source Document Type") { }
                field(sourceDocumentNo; Rec."Source Document No.") { }
                field(sourceLineNo; Rec."Source Line No.") { }
                field(customerNo; Rec."Customer No.") { }
                field(shipToCode; Rec."Ship-to Code") { }
                field(region; Rec."Region") { }
                field(weightTonne; Rec."Weight Tonne") { }
                field(bagCount; Rec."Bag Count") { }
                field(sequenceNo; Rec."Sequence No.") { }
                field(lineStatus; Rec."Line Status") { }
            }
        }
    }
}
