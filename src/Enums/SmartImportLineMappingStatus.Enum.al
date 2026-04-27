enum 50602 "Smart Import Line Map Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Pending) { Caption = 'Pending'; }
    value(1; Mapped) { Caption = 'Mapped'; }
    value(2; NeedsReview) { Caption = 'Needs Review'; }
    value(3; Invalid) { Caption = 'Invalid'; }
}
