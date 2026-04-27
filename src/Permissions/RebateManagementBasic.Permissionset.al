permissionset 50500 "Rebate Mgmt - Basic"
{
    Assignable = true;
    Caption = 'Rebate Management - Basic';

    Permissions =
        tabledata "Rebate Setup Master" = RIMD,
        tabledata "Rebate Setup Line" = RIMD,
        tabledata "Rebate Transaction" = RIMD,
        tabledata "Rebate Transaction Line" = RIMD,
        tabledata "Smart Import Header" = RIMD,
        tabledata "Smart Import Field" = RIMD,
        tabledata "Smart Import Line" = RIMD,
        tabledata "Smart Import Log" = RIMD,
        tabledata "Smart Import Map Setup" = RIMD,
        table "Rebate Setup Master" = X,
        table "Rebate Setup Line" = X,
        table "Rebate Transaction" = X,
        table "Rebate Transaction Line" = X,
        table "Smart Import Header" = X,
        table "Smart Import Field" = X,
        table "Smart Import Line" = X,
        table "Smart Import Log" = X,
        table "Smart Import Map Setup" = X;
}
