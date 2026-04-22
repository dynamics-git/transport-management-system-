page 50551 "Sales Order Header API"
{
    PageType = API;
    Caption = 'Sales Order Header', Locked = true;
    ChangeTrackingAllowed = true;
    APIPublisher = 'tecsa';
    APIGroup = 'procure';
    APIVersion = 'v1.0';
    EntityName = 'salesOrderHeader';
    EntitySetName = 'salesOrderHeaders';
    ODataKeyFields = "SystemId";
    SourceTable = "Sales Header";
    DelayedInsert = true;
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Id; Rec."SystemId")
                {
                    ApplicationArea = All;
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(Number; Rec."No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'No.', Locked = true;
                }
                field(DocumentType; Rec."Document Type")
                {
                    ApplicationArea = Suite;
                    Caption = 'Document Type', Locked = true;
                }
                field(SellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to Customer No.', Locked = true;
                }
                field(SellToCustomerName; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to Customer Name', Locked = true;
                }
                field(BillToCustomerNo; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bill-to Customer No.', Locked = true;
                }
                field(SellToAddress; Rec."Sell-to Address")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to Address', Locked = true;
                }
                field(SellToAddress2; Rec."Sell-to Address 2")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to Address 2', Locked = true;
                }
                field(SellToCity; Rec."Sell-to City")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to City', Locked = true;
                }
                field(SellToCounty; Rec."Sell-to County")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to County', Locked = true;
                }
                field(SellToPostCode; Rec."Sell-to Post Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to Post Code', Locked = true;
                }
                field(SellToCountryRegionCode; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to Country/Region Code', Locked = true;
                }
                field(SellToContactNo; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to Contact No.', Locked = true;
                }
                field(SellToContact; Rec."Sell-to Contact")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sell-to Contact', Locked = true;
                }
                field(BillToAddress; Rec."Bill-to Address")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bill-to Address', Locked = true;
                }
                field(BillToAddress2; Rec."Bill-to Address 2")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bill-to Address 2', Locked = true;
                }
                field(BillToCity; Rec."Bill-to City")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bill-to City', Locked = true;
                }
                field(BillToCounty; Rec."Bill-to County")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bill-to County', Locked = true;
                }
                field(BillToPostCode; Rec."Bill-to Post Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bill-to Post Code', Locked = true;
                }
                field(BillToCountryRegionCode; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bill-to Country/Region Code', Locked = true;
                }
                field(ShipToCode; Rec."Ship-to Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ship-to Code', Locked = true;
                }
                field(ShipToName; Rec."Ship-to Name")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ship-to Name', Locked = true;
                }
                field(ShipToAddress; Rec."Ship-to Address")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ship-to Address', Locked = true;
                }
                field(ShipToAddress2; Rec."Ship-to Address 2")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ship-to Address 2', Locked = true;
                }
                field(ShipToCity; Rec."Ship-to City")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ship-to City', Locked = true;
                }
                field(ShipToCounty; Rec."Ship-to County")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ship-to County', Locked = true;
                }
                field(ShipToPostCode; Rec."Ship-to Post Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ship-to Post Code', Locked = true;
                }
                field(ShipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ship-to Country/Region Code', Locked = true;
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Document Date', Locked = true;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posting Date', Locked = true;
                }
                field(DueDate; Rec."Due Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Due Date', Locked = true;
                }
                field(OrderDate; Rec."Order Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Order Date', Locked = true;
                }
                field(ShipmentDate; Rec."Shipment Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Shipment Date', Locked = true;
                }
                field(ExternalDocumentNo; Rec."External Document No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'External Document No.', Locked = true;
                }
                field(SalespersonCode; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Salesperson Code', Locked = true;
                }
                field(CampaignNo; Rec."Campaign No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Campaign No.', Locked = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Suite;
                    Caption = 'Status', Locked = true;
                }
                field(JobQueueStatus; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Caption = 'Job Queue Status', Locked = true;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Shortcut Dimension 1 Code', Locked = true;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Shortcut Dimension 2 Code', Locked = true;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Currency Code', Locked = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Suite;
                    Caption = 'Amount', Locked = true;
                }
                field(AmountIncludingVAT; Rec."Amount Including VAT")
                {
                    ApplicationArea = Suite;
                    Caption = 'Amount Including VAT', Locked = true;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Suite;
                    Caption = 'Responsibility Center', Locked = true;
                }
                field(AssignedUserID; Rec."Assigned User ID")
                {
                    ApplicationArea = Suite;
                    Caption = 'Assigned User ID', Locked = true;
                }

                part(SalesLines; "Sales Order Line API")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Lines', Locked = true;
                    EntityName = 'salesOrderLine';
                    EntitySetName = 'salesOrderLines';
                    SubPageLink = "SystemId" = FIELD(SystemId);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Post;

                trigger OnAction()
                begin
                    PostSalesOrder();
                end;
            }
            action(Release)
            {
                ApplicationArea = All;
                Caption = 'Release';
                Image = ReleaseDoc;

                trigger OnAction()
                begin
                    ReleaseSalesOrder();
                end;
            }
        }
    }

    [ServiceEnabled]
    [Scope('Cloud')]
    procedure PostSalesOrder()
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        if Rec.Status <> Rec.Status::Released then
            Error('Sales order must be released before posting');
        SalesPost.Run(Rec);
    end;

    [ServiceEnabled]
    [Scope('Cloud')]
    procedure ReleaseSalesOrder()
    var
        ReleaseSalesDoc: Codeunit "Release Sales Document";
    begin
        ReleaseSalesDoc.Run(Rec);
    end;
}
