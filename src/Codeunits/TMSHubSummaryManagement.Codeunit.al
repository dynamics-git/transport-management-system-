codeunit 50541 "TMS Hub Summary Management"
{
    procedure GetHubSummaries(): Text
    var
        Trip: Record "TMS Route Trip Header";
        Hub: Record Location;
        Summary: Text;
    begin
        Hub.SetRange("Use As In-Transit", false); // Assuming hubs are locations not in-transit
        if Hub.FindSet() then
            repeat
                Trip.SetRange("Hub Location Code", Hub.Code);
                Trip.CalcSums("Total Weight", "Total Bags");
                Summary += StrSubstNo('{"hub":"%1","totalTrips":%2,"totalWeight":%3,"totalBags":%4},', Hub.Code, Trip.Count(), Trip."Total Weight", Trip."Total Bags");
            until Hub.Next() = 0;
        Summary := '[' + DelChr(Summary, '>', ',') + ']';
        exit(Summary);
    end;
}