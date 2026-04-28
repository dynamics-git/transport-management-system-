query 50630 "TMS Route Order"
{
    QueryType = API;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'routeorder';
    EntitySetName = 'routeorders';
    elements
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableFilter = "Document Type" = const(Order);
            column(customerNo; "Sell-to Customer No.") { }
            column(customerName; "Sell-to Customer Name") { }
            column(hubLocationCode; "Location Code") { }
            column(deliveryDate; "Shipment Date") { }
            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document Type" = SalesHeader."Document Type", "Document No." = SalesHeader."No.";
                DataItemTableFilter = "Type" = const(Item);
                column(sourceDocumentNo; "Document No.") { }
                column(sourceLineNo; "Line No.") { }
                column(weightTonne; "Quantity") { }
                column(bagCount; "Quantity") { }
                dataitem(TripLine; "TMS Route Trip Line")
                {
                    DataItemLink = "Source Document No." = SalesHeader."No.", "Source Line No." = SalesLine."Line No.";
                    DataItemTableFilter = "Source Document Type" = const("Sales Order");
                    SqlJoinType = LeftOuterJoin;
                    column(assignedTripNo; "Trip No.") { }
                    column(status; "Line Status") { }
                }
            }
        }
    }
}
