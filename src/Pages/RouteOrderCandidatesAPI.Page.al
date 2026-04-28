page 50627 "Route Order Candidates API"
{
    PageType = API;
    Caption = 'Route Order Candidates';
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'routeOrderCandidate';
    EntitySetName = 'routeordercandidates';
    SourceTable = "Sales Line";
    DelayedInsert = true;
    ODataKeyFields = "SystemId";
    SourceTableView = WHERE("Document Type" = FILTER(Order), Type = FILTER(Item), "Outstanding Quantity" = FILTER(> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // Sales Line Info
                field(lineSystemId; Rec.SystemId) { }
                field(sourceDocumentNo; Rec."Document No.") { }
                field(sourceLineNo; Rec."Line No.") { }
                field(itemNo; Rec."No.") { }
                field(description; Rec.Description) { }
                field(quantity; Rec.Quantity) { }
                field(outstandingQuantity; Rec."Outstanding Quantity") { }
                field(unitOfMeasureCode; Rec."Unit of Measure Code") { }
                field(deliveryDate; Rec."Shipment Date") { }
                field(lineAmount; Rec.Amount) { }

                // Customer Info (from Sales Header)
                field(customerNo; CustNo) { }
                field(customerName; CustName) { }
                field(customerLocationCode; CustLocCode) { }
                field(customerCity; CustCity) { }
                field(customerPostCode; CustPostCode) { }
                field(customerPhoneNo; CustPhoneNo) { }
                field(customerEmail; CustEmail) { }

                // Delivery Location
                field(shipToCode; ShipToCode) { }

                // Assignment Info
                field(assignedTripNo; AssignedTripNo) { }
                field(sequenceNo; SequenceNo) { }
                field(lineStatus; LineStatus) { }

                // Planning Status
                field(planningStatus; PlanningStatus) { }
            }
        }
    }

    var
        CustNo: Code[20];
        CustName: Text[100];
        CustLocCode: Code[10];
        CustCity: Text[30];
        CustPostCode: Code[20];
        CustPhoneNo: Text[30];
        CustEmail: Text[80];
        ShipToCode: Code[10];
        AssignedTripNo: Code[20];
        SequenceNo: Integer;
        LineStatus: Text[20];
        PlanningStatus: Text[20];
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
        RouteTripLine: Record "TMS Route Trip Line";

    trigger OnAfterGetRecord()
    begin
        Clear(CustNo);
        Clear(CustName);
        Clear(CustLocCode);
        Clear(CustCity);
        Clear(CustPostCode);
        Clear(CustPhoneNo);
        Clear(CustEmail);
        Clear(ShipToCode);
        Clear(AssignedTripNo);
        Clear(SequenceNo);
        Clear(LineStatus);
        Clear(PlanningStatus);

        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then begin
            CustNo := SalesHeader."Sell-to Customer No.";
            ShipToCode := SalesHeader."Ship-to Code";

            if Customer.Get(CustNo) then begin
                CustName := Customer.Name;
                CustLocCode := Customer."Location Code";
                CustCity := Customer.City;
                CustPostCode := Customer."Post Code";
                CustPhoneNo := Customer."Phone No.";
                CustEmail := Customer."E-Mail";
            end;
        end;

        RouteTripLine.Reset();
        RouteTripLine.SetRange("Source Document Type", RouteTripLine."Source Document Type"::"Sales Order");
        RouteTripLine.SetRange("Source Document No.", Rec."Document No.");
        RouteTripLine.SetRange("Source Line No.", Rec."Line No.");
        if RouteTripLine.FindFirst() then begin
            AssignedTripNo := RouteTripLine."Trip No.";
            SequenceNo := RouteTripLine."Sequence No.";
            LineStatus := Format(RouteTripLine."Line Status");
        end;

        case true of
            LineStatus <> '':
                PlanningStatus := LineStatus;
            AssignedTripNo <> '':
                PlanningStatus := 'Assigned';
            else
                PlanningStatus := 'Pending';
        end;
    end;
}
