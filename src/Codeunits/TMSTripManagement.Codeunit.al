codeunit 50542 "TMS Trip Management"
{
    procedure CreateTrip(TripNo: Code[20]; PlannedDate: Date; HubLocationCode: Code[10]; LoadType: Enum "TMS Load Type"; TransporterCode: Code[20]; TruckNo: Code[20])
    var
        Trip: Record "TMS Route Trip Header";
    begin
        Trip."Trip No." := TripNo;
        Trip."Planned Date" := PlannedDate;
        Trip."Hub Location Code" := HubLocationCode;
        Trip."Load Type" := LoadType;
        Trip."Transporter Code" := TransporterCode;
        Trip."Truck No." := TruckNo;
        Trip.Status := Trip.Status::Planned;
        Trip."Created By" := UserId;
        Trip."Created At" := CurrentDateTime;
        Trip.Insert();
    end;

    procedure UpdateTripStatus(TripNo: Code[20]; NewStatus: Enum "TMS Trip Status")
    var
        Trip: Record "TMS Route Trip Header";
    begin
        Trip.Get(TripNo);
        Trip.Status := NewStatus;
        Trip.Modify();
    end;

    procedure AssignOrderToTrip(TripNo: Code[20]; SourceDocType: Enum "TMS Source Document Type"; SourceDocNo: Code[20]; SourceLineNo: Integer)
    var
        TripLine: Record "TMS Route Trip Line";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
    begin
        SalesLine.Get(SalesLine."Document Type"::Order, SourceDocNo, SourceLineNo);
        TripLine.SetRange("Trip No.", TripNo);
        if TripLine.FindLast() then
            LineNo := TripLine."Line No." + 10000
        else
            LineNo := 10000;
        TripLine."Trip No." := TripNo;
        TripLine."Line No." := LineNo;
        TripLine."Source Document Type" := SourceDocType;
        TripLine."Source Document No." := SourceDocNo;
        TripLine."Source Line No." := SourceLineNo;
        TripLine."Customer No." := SalesLine."Sell-to Customer No.";
        // TripLine."Ship-to Code" := SalesLine."Ship-to Code"; // Commented out due to field not found error
        TripLine."Weight Tonne" := SalesLine."Quantity";
        TripLine."Bag Count" := SalesLine."Quantity";
        TripLine."Line Status" := TripLine."Line Status"::Planned;
        TripLine.Insert();
    end;

    procedure RemoveTripLine(TripNo: Code[20]; LineNo: Integer)
    var
        TripLine: Record "TMS Route Trip Line";
    begin
        TripLine.Get(TripNo, LineNo);
        TripLine.Delete();
    end;

    procedure RecordWeighbridge(EntryNo: Code[20]; TripNo: Code[20]; TareWeight: Decimal; GrossWeight: Decimal)
    var
        Weighbridge: Record "TMS Weighbridge Entry";
        Trip: Record "TMS Route Trip Header";
        Truck: Record "TMS Truck";
    begin
        Weighbridge."Entry No." := EntryNo;
        Weighbridge."Trip No." := TripNo;
        Weighbridge."Tare Weight" := TareWeight;
        Weighbridge."Gross Weight" := GrossWeight;
        Weighbridge."Net Weight" := GrossWeight - TareWeight;
        Trip.Get(TripNo);
        Truck.Get(Trip."Truck No.");
        Weighbridge."Overload" := Weighbridge."Net Weight" > Truck."Capacity Tonne";
        Weighbridge."Recorded By" := UserId;
        Weighbridge."Recorded At" := CurrentDateTime;
        Weighbridge.Insert();
    end;

    procedure SavePod(EntryNo: Code[20]; TripNo: Code[20]; PodDate: DateTime; ReceivedBy: Code[50]; PhotoPath: Text; Remarks: Text)
    var
        Pod: Record "TMS POD Entry";
    begin
        Pod."Entry No." := EntryNo;
        Pod."Trip No." := TripNo;
        Pod."POD Date" := PodDate;
        Pod."Received By" := ReceivedBy;
        Pod."Photo Path" := PhotoPath;
        Pod."Remarks" := Remarks;
        Pod.Insert();
    end;
}