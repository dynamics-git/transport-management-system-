permissionset 50100 "Rebate Mgmt - Basic"
{
    Assignable = true;
    Caption = 'Rebate Management - Basic';

    Permissions =
        tabledata "Rebate Setup Master" = RIMD,
        tabledata "Rebate Setup Line" = RIMD,
        tabledata "Rebate Transaction" = RIMD,
        tabledata "Rebate Transaction Line" = RIMD,
        table "Rebate Setup Master" = X,
        table "Rebate Setup Line" = X,
        table "Rebate Transaction" = X,
        table "Rebate Transaction Line" = X;
}
