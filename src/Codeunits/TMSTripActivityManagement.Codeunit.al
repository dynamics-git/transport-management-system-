codeunit 50643 "TMS Trip Activity Management"
{
    procedure LogActivity(TripNo: Code[20]; ActivityType: Code[30]; ActivityLabel: Text[100]; ActivityAt: DateTime; PortalUserId: Code[100]; BCUserId: Code[50]; SourceTable: Text[50]; OldValue: Text[100]; NewValue: Text[100]; Details: Text[250])
    var
        Activity: Record "TMS Trip Activity";
    begin
        if TripNo = '' then
            exit;

        Activity.Init();
        Activity."Trip No." := TripNo;
        Activity."Activity Type" := ActivityType;
        Activity."Activity Label" := ActivityLabel;
        Activity."Activity At" := ActivityAt;
        Activity."Portal User ID" := PortalUserId;
        Activity."BC User ID" := BCUserId;
        Activity."Source Table" := SourceTable;
        Activity."Old Value" := OldValue;
        Activity."New Value" := NewValue;
        Activity.Details := Details;
        Activity.Insert(true);
    end;
}
