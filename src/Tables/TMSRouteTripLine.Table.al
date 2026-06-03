table 50613 "TMS Route Trip Line"
{
    Caption = 'TMS Route Trip Line';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Trip No."; Code[20])
        {
            Caption = 'Trip No.';
            TableRelation = "TMS Route Trip Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Source Document Type"; Enum "TMS Source Document Type")
        {
            Caption = 'Source Document Type';
        }
        field(4; "Source Document No."; Code[20])
        {
            Caption = 'Source Document No.';
        }
        field(5; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(7; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Customer No."));
        }
        field(8; "Region"; Text[50])
        {
            Caption = 'Region';
        }
        field(9; "Weight Tonne"; Decimal)
        {
            Caption = 'Weight Tonne';
        }
        field(10; "Bag Count"; Integer)
        {
            Caption = 'Bag Count';
        }
        field(11; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
        }
        field(12; "Line Status"; Enum "TMS Trip Status")
        {
            Caption = 'Line Status';
        }
    }
    keys
    {
        key(PK; "Trip No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        ExistingLine: Record "TMS Route Trip Line";
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        LineWeight: Decimal;
    begin
        if "Line No." = 0 then begin
            ExistingLine.SetRange("Trip No.", "Trip No.");
            if ExistingLine.FindLast() then
                "Line No." := ExistingLine."Line No." + 10000
            else
                "Line No." := 10000;
        end;

        if ("Source Document Type" = "Source Document Type"::"Sales Order") and
           ("Source Document No." <> '') and
           ("Source Line No." <> 0) and
           SalesLine.Get(SalesLine."Document Type"::Order, "Source Document No.", "Source Line No.") then begin
            if "Customer No." = '' then
                "Customer No." := SalesLine."Sell-to Customer No.";

            if SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
                if "Ship-to Code" = '' then
                    "Ship-to Code" := SalesHeader."Ship-to Code";

            LineWeight := SalesLine."Net Weight";
            if LineWeight = 0 then
                LineWeight := SalesLine."Gross Weight";

            if "Weight Tonne" = 0 then begin
                if LineWeight <> 0 then
                    "Weight Tonne" := Round((SalesLine.Quantity * LineWeight) / 1000, 0.001, '=')
                else
                    "Weight Tonne" := SalesLine.Quantity;
            end;

            if "Bag Count" = 0 then
                "Bag Count" := Round(SalesLine.Quantity, 1, '=');
        end;

        if Format("Line Status") = '' then
            "Line Status" := "Line Status"::Planned;
    end;
}
