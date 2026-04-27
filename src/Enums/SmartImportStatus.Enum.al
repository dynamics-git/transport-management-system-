enum 50601 "Smart Import Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Uploaded) { Caption = 'Uploaded'; }
    value(1; Analyzing) { Caption = 'Analyzing'; }
    value(2; ReviewRequired) { Caption = 'Review Required'; }
    value(3; ReadyToCreate) { Caption = 'Ready To Create'; }
    value(4; Created) { Caption = 'Created'; }
    value(5; Rejected) { Caption = 'Rejected'; }
    value(6; Failed) { Caption = 'Failed'; }
}
