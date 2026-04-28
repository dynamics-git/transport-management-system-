codeunit 50640 "TMS KPI Management"
{
    procedure GetKpiSummary(): Text
    var
        Trip: Record "TMS Route Trip Header";
        TotalTrips: Integer;
        CompletedTrips: Integer;
        TotalWeight: Decimal;
    begin
        Trip.SetRange(Status, Trip.Status::Closed);
        CompletedTrips := Trip.Count();
        Trip.Reset();
        TotalTrips := Trip.Count();
        Trip.CalcSums("Total Weight");
        TotalWeight := Trip."Total Weight";
        exit(StrSubstNo('{"totalTrips":%1,"completedTrips":%2,"totalWeight":%3}', TotalTrips, CompletedTrips, TotalWeight));
    end;
}
