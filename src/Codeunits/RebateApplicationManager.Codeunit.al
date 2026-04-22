codeunit 50502 "Rebate Application Manager"
{
    TableNo = "Rebate Transaction";

    trigger OnRun()
    begin
        ApplyRebate(Rec);
    end;

    procedure ApplyRebate(var RebateTransaction: Record "Rebate Transaction")
    begin
        // Validate before applying
        ValidateRebateApplication(RebateTransaction);

        // Apply rebate based on document type
        case RebateTransaction."Document Type" of
            RebateTransaction."Document Type"::"Purchase Order":
                ApplyToPurchaseOrder(RebateTransaction);
            RebateTransaction."Document Type"::"Sales Order":
                ApplyToSalesOrder(RebateTransaction);
            RebateTransaction."Document Type"::"Purchase Invoice":
                ApplyToPurchaseInvoice(RebateTransaction);
            RebateTransaction."Document Type"::"Sales Invoice":
                ApplyToSalesInvoice(RebateTransaction);
            RebateTransaction."Document Type"::Custom:
                ApplyToCustomDocument(RebateTransaction);
        end;

        // Update transaction status
        RebateTransaction.Status := RebateTransaction.Status::Applied;
        RebateTransaction."Applied Date" := CurrentDateTime;
        RebateTransaction."Applied By" := UserId;
        RebateTransaction.Modify();
    end;

    local procedure ValidateRebateApplication(RebateTransaction: Record "Rebate Transaction")
    begin
        if RebateTransaction.Status <> RebateTransaction.Status::Approved then
            Error('Rebate transaction must be approved before applying');

        if RebateTransaction."Final Rebate" = 0 then
            Error('Cannot apply rebate transaction with zero final rebate amount');

        if RebateTransaction."Document No." = '' then
            Error('Document No. is required for rebate application');
    end;

    local procedure ApplyToPurchaseOrder(var RebateTransaction: Record "Rebate Transaction")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        // Find the purchase line
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", RebateTransaction."Document No.");
        PurchaseLine.SetRange("Line No.", RebateTransaction."Line No.");
        PurchaseLine.SetRange("No.", RebateTransaction."Item No.");

        if PurchaseLine.FindFirst() then begin
            // Apply rebate as a line discount or create a separate rebate line
            // For demo purposes, we'll add a comment or custom field
            // In production, this would integrate with GL posting or discount mechanisms

            Message('Rebate of %1 RM/MT applied to Purchase Order %2, Line %3',
                RebateTransaction."Final Rebate",
                RebateTransaction."Document No.",
                RebateTransaction."Line No.");
        end else
            Error('Purchase Order line not found');
    end;

    local procedure ApplyToSalesOrder(var RebateTransaction: Record "Rebate Transaction")
    var
        SalesLine: Record "Sales Line";
    begin
        // Find the sales line
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", RebateTransaction."Document No.");
        SalesLine.SetRange("Line No.", RebateTransaction."Line No.");
        SalesLine.SetRange("No.", RebateTransaction."Item No.");

        if SalesLine.FindFirst() then begin
            // Apply rebate as a line discount or create a separate rebate line
            Message('Rebate of %1 RM/MT applied to Sales Order %2, Line %3',
                RebateTransaction."Final Rebate",
                RebateTransaction."Document No.",
                RebateTransaction."Line No.");
        end else
            Error('Sales Order line not found');
    end;

    local procedure ApplyToPurchaseInvoice(var RebateTransaction: Record "Rebate Transaction")
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        // Find the purchase invoice line
        PurchInvLine.SetRange("Document No.", RebateTransaction."Document No.");
        PurchInvLine.SetRange("Line No.", RebateTransaction."Line No.");
        PurchInvLine.SetRange("No.", RebateTransaction."Item No.");

        if PurchInvLine.FindFirst() then begin
            Message('Rebate of %1 RM/MT applied to Purchase Invoice %2, Line %3',
                RebateTransaction."Final Rebate",
                RebateTransaction."Document No.",
                RebateTransaction."Line No.");
        end else
            Error('Purchase Invoice line not found');
    end;

    local procedure ApplyToSalesInvoice(var RebateTransaction: Record "Rebate Transaction")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        // Find the sales invoice line
        SalesInvoiceLine.SetRange("Document No.", RebateTransaction."Document No.");
        SalesInvoiceLine.SetRange("Line No.", RebateTransaction."Line No.");
        SalesInvoiceLine.SetRange("No.", RebateTransaction."Item No.");

        if SalesInvoiceLine.FindFirst() then begin
            Message('Rebate of %1 RM/MT applied to Sales Invoice %2, Line %3',
                RebateTransaction."Final Rebate",
                RebateTransaction."Document No.",
                RebateTransaction."Line No.");
        end else
            Error('Sales Invoice line not found');
    end;

    local procedure ApplyToCustomDocument(var RebateTransaction: Record "Rebate Transaction")
    begin
        // For custom documents, just log the application
        Message('Rebate of %1 RM/MT applied to Custom Document %2',
            RebateTransaction."Final Rebate",
            RebateTransaction."Document No.");
    end;

    procedure ApproveRebate(var RebateTransaction: Record "Rebate Transaction")
    begin
        if RebateTransaction.Status <> RebateTransaction.Status::Suggested then
            Error('Only suggested rebates can be approved');

        RebateTransaction.Status := RebateTransaction.Status::Approved;
        RebateTransaction.Modify();
    end;

    procedure RejectRebate(var RebateTransaction: Record "Rebate Transaction"; Reason: Text[250])
    begin
        if RebateTransaction.Status <> RebateTransaction.Status::Suggested then
            Error('Only suggested rebates can be rejected');

        RebateTransaction.Status := RebateTransaction.Status::Cancelled;
        // In production, you might want to add a reason field
        RebateTransaction.Modify();
    end;

    local procedure CreateRebateTransactionFromPO(DocumentNo: Code[20]; LineNo: Integer)
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        RebateTransaction: Record "Rebate Transaction";
        RebateMatchingEngine: Codeunit "Rebate Matching Engine";
    begin
        if not PurchaseLine.Get(PurchaseLine."Document Type"::Order, DocumentNo, LineNo) then
            exit;

        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, DocumentNo);

        // Create rebate transaction
        RebateTransaction.Init();
        RebateTransaction."Transaction ID" := GetNextTransactionID();
        RebateTransaction."Document Type" := RebateTransaction."Document Type"::"Purchase Order";
        RebateTransaction."Document No." := DocumentNo;
        RebateTransaction."Line No." := LineNo;
        RebateTransaction."Posting Date" := PurchaseHeader."Posting Date";
        RebateTransaction."Item No." := PurchaseLine."No.";
        RebateTransaction.Quantity := PurchaseLine.Quantity;
        RebateTransaction."Unit Price" := PurchaseLine."Direct Unit Cost";
        RebateTransaction."Line Amount" := PurchaseLine."Line Amount";
        RebateTransaction.Insert();

        // Try to suggest rebate
        RebateMatchingEngine.SuggestRebateSetup(RebateTransaction);
    end;

    local procedure GetNextTransactionID(): Code[20]
    var
        RebateTransaction: Record "Rebate Transaction";
        NoSeries: Codeunit "No. Series";
    begin
        // For demo purposes, use a simple numbering
        RebateTransaction.SetCurrentKey("Transaction ID");
        if RebateTransaction.FindLast() then
            exit(IncStr(RebateTransaction."Transaction ID"))
        else
            exit('REB-000001');
    end;
}
