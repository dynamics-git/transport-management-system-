tableextension 50644 "TMS Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50640; "TMS Hub Code"; Code[20])
        {
            Caption = 'TMS Hub Code';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }

        field(50641; "TMS Region"; Text[50])
        {
            Caption = 'TMS Region';
            DataClassification = CustomerContent;
        }

        field(50642; "TMS Load Type"; Text[20])
        {
            Caption = 'TMS Load Type';
            DataClassification = CustomerContent;
        }
    }
}