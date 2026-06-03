permissionset 50649 "TMS Management"
{
    Assignable = true;
    Caption = 'TMS Management';

    Permissions =
        tabledata "Freight Charges" = RIMD,
        tabledata "TMS Transporter" = RIMD,
        tabledata "TMS Truck" = RIMD,
        tabledata "TMS Route Trip Header" = RIMD,
        tabledata "TMS Route Trip Line" = RIMD,
        tabledata "TMS Trip Activity" = RIMD,
        tabledata "TMS Weighbridge Entry" = RIMD,
        tabledata "TMS POD Entry" = RIMD,
        table "Freight Charges" = X,
        table "TMS Transporter" = X,
        table "TMS Truck" = X,
        table "TMS Route Trip Header" = X,
        table "TMS Route Trip Line" = X,
        table "TMS Trip Activity" = X,
        table "TMS Weighbridge Entry" = X,
        table "TMS POD Entry" = X,
        page "Freight Charges API" = X,
        page "TMS Transporter API" = X,
        page "TMS Truck API" = X,
        page "TMS Route Trip Header API" = X,
        page "TMS Route Trip Line API" = X,
        page "TMS Trip Activity API" = X,
        page "TMS Weighbridge Entry API" = X,
        page "TMS POD Entry API" = X,
        page "TMS Location API" = X,
        page "Route Order Candidates API" = X,
        query "TMS Route Order" = X,
        codeunit "TMS KPI Management" = X,
        codeunit "TMS Hub Summary Management" = X,
        codeunit "TMS Trip Management" = X,
        codeunit "TMS Trip Activity Management" = X;
}
