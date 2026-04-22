permissionset 50501 "Rebate Mgmt - Full"
{
    Assignable = true;
    Caption = 'Rebate Management - Full';
    IncludedPermissionSets = "Rebate Mgmt - Basic";

    Permissions =
        page "Rebate Setup List" = X,
        page "Rebate Setup Card" = X,
        page "Rebate Setup Subpage" = X,
        page "Rebate Transaction List" = X,
        page "Rebate Transaction Card" = X,
        page "Rebate Transaction Subpage" = X,
        page "Rebate Setup FactBox" = X,
        page "Sample Amount" = X,
        codeunit "Rebate Calculation Engine" = X,
        codeunit "Rebate Matching Engine" = X,
        codeunit "Rebate Application Manager" = X,
        codeunit "Rebate Demo Data" = X;
}
