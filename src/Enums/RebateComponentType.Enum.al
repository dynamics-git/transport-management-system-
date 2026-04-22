enum 50003 "Rebate Component Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "Market Rebate") { Caption = 'Market Rebate'; }
    value(1; EPI) { Caption = 'EPI (Early Payment Incentive)'; }
    value(2; PPI) { Caption = 'PPI (Prompt Payment Incentive)'; }
    value(3; VI) { Caption = 'VI (Volume Incentive)'; }
    value(4; "Additional Rebate") { Caption = 'Additional Rebate'; }
    value(5; "Special Rebate") { Caption = 'Special Rebate'; }
}