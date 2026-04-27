enum 50600 "Smart Import Target Doc Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; PurchaseRequisition) { Caption = 'Purchase Requisition'; }
    value(1; PurchaseInvoice) { Caption = 'Purchase Invoice'; }
    value(2; PurchaseOrder) { Caption = 'Purchase Order'; }
    value(3; VendorQuotation) { Caption = 'Vendor Quotation'; }
    value(4; EmployeeClaim) { Caption = 'Employee Claim'; }
}
