# Rebate Management Demo Preparation Script

Write-Host "=== Rebate Management Demo Preparation ===" -ForegroundColor Green
Write-Host ""

# Check Business Central connection
Write-Host "Checking Business Central connection..." -ForegroundColor Yellow
$bcService = Get-Service -Name "*BC*" -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq "Running" }
if (-not $bcService) {
    Write-Host "✗ Business Central service not running. Please start it first." -ForegroundColor Red
    exit 1
}
Write-Host "✓ Business Central service is running" -ForegroundColor Green

Write-Host ""
Write-Host "=== DEMO SETUP INSTRUCTIONS ===" -ForegroundColor Cyan
Write-Host ""

Write-Host "Step 1: Open Business Central Client" -ForegroundColor Yellow
Write-Host "Navigate to: https://[your-bc-server]/BC/" -ForegroundColor White
Write-Host ""

Write-Host "Step 2: Create Sample Rebate Setup" -ForegroundColor Yellow
Write-Host "1. Search for 'Rebate Setup List' in the search bar" -ForegroundColor White
Write-Host "2. Click 'New' to create a new setup" -ForegroundColor White
Write-Host "3. Fill in the following details:" -ForegroundColor White
Write-Host "   - Setup ID: DEMO-001" -ForegroundColor Cyan
Write-Host "   - Description: Demo Rebate Setup for MCP" -ForegroundColor Cyan
Write-Host "   - From Date: Today" -ForegroundColor Cyan
Write-Host "   - To Date: 1 year from today" -ForegroundColor Cyan
Write-Host "   - Item No.: MCP (create this item if it doesn't exist)" -ForegroundColor Cyan
Write-Host "   - Entity Type: Customer" -ForegroundColor Cyan
Write-Host "   - Entity ID: [leave blank for all customers]" -ForegroundColor Cyan
Write-Host "   - Rebate Type: Recurring" -ForegroundColor Cyan
Write-Host "   - Priority: 1" -ForegroundColor Cyan
Write-Host "4. In the lines section, add these components:" -ForegroundColor White
Write-Host "   - Market Rebate: 5%" -ForegroundColor Cyan
Write-Host "   - EPI: 2%" -ForegroundColor Cyan
Write-Host "   - PPI: 1.5%" -ForegroundColor Cyan
Write-Host "   - VI: 3% (Min. Quantity: 100)" -ForegroundColor Cyan
Write-Host "   - Additional Rebate: 1%" -ForegroundColor Cyan
Write-Host "   - Special Rebate: 0.5%" -ForegroundColor Cyan
Write-Host "5. Set Status to 'Approved'" -ForegroundColor White
Write-Host ""

Write-Host "Step 3: Create Sample Rebate Transaction" -ForegroundColor Yellow
Write-Host "1. Search for 'Rebate Transaction List'" -ForegroundColor White
Write-Host "2. Click 'New' to create a transaction" -ForegroundColor White
Write-Host "3. Fill in the following details:" -ForegroundColor White
Write-Host "   - Transaction ID: DEMO-TRX-001" -ForegroundColor Cyan
Write-Host "   - Document Type: Purchase Order" -ForegroundColor Cyan
Write-Host "   - Document No.: PO-001 (create this PO if needed)" -ForegroundColor Cyan
Write-Host "   - Line No.: 10000" -ForegroundColor Cyan
Write-Host "   - Posting Date: Today" -ForegroundColor Cyan
Write-Host "   - Item No.: MCP" -ForegroundColor Cyan
Write-Host "   - Quantity: 150" -ForegroundColor Cyan
Write-Host "   - Unit Price: 100.00" -ForegroundColor Cyan
Write-Host "   - Entity Type: Customer" -ForegroundColor Cyan
Write-Host "   - Entity ID: CUST001 (create this customer if needed)" -ForegroundColor Cyan
Write-Host ""

Write-Host "Step 4: Demonstrate Rebate Calculation" -ForegroundColor Yellow
Write-Host "1. Click 'Suggest Rebate' - system finds the matching setup" -ForegroundColor White
Write-Host "2. Review the calculated components in the subpage:" -ForegroundColor White
Write-Host "   - Market Rebate: 750.00 RM (5% of 15,000)" -ForegroundColor Cyan
Write-Host "   - EPI: 300.00 RM (2% of 15,000)" -ForegroundColor Cyan
Write-Host "   - PPI: 225.00 RM (1.5% of 15,000)" -ForegroundColor Cyan
Write-Host "   - VI: 450.00 RM (3% of 15,000 - qualifies for volume)" -ForegroundColor Cyan
Write-Host "   - Additional Rebate: 150.00 RM (1% of 15,000)" -ForegroundColor Cyan
Write-Host "   - Special Rebate: 75.00 RM (0.5% of 15,000)" -ForegroundColor Cyan
Write-Host "   - Total Rebate: 1,950.00 RM" -ForegroundColor Green
Write-Host "3. Add 'Proposed Adjustment': +50.00 RM" -ForegroundColor White
Write-Host "4. Final Rebate becomes: 2,000.00 RM" -ForegroundColor Green
Write-Host ""

Write-Host "Step 5: Demonstrate Workflow" -ForegroundColor Yellow
Write-Host "1. Click 'Approve' to approve the rebate" -ForegroundColor White
Write-Host "2. Click 'Apply Rebate' to apply to the purchase order" -ForegroundColor White
Write-Host "3. Status changes to 'Applied'" -ForegroundColor Green
Write-Host ""

Write-Host "=== BUSINESS VALUE DEMONSTRATION POINTS ===" -ForegroundColor Magenta
Write-Host ""
Write-Host "1. AUTOMATION: 'One-click rebate suggestion saves time'" -ForegroundColor White
Write-Host "2. FLEXIBILITY: 'Multiple rebate components for complex scenarios'" -ForegroundColor White
Write-Host "3. TRANSPARENCY: 'Component breakdown shows exactly how rebate is calculated'" -ForegroundColor White
Write-Host "4. CONTROL: 'Approval workflow prevents unauthorized rebates'" -ForegroundColor White
Write-Host "5. SCALABILITY: 'Priority-based matching handles multiple rules'" -ForegroundColor White
Write-Host "6. AUDITABILITY: 'Complete transaction history and adjustments'" -ForegroundColor White
Write-Host ""

Write-Host "=== DEMO SCRIPT READY ===" -ForegroundColor Green
Write-Host "Use this script to guide your client through the demonstration." -ForegroundColor Yellow
Write-Host "Total demo time: 15-20 minutes" -ForegroundColor Cyan
Write-Host ""

# Create a quick reference card
Write-Host "Creating quick reference card..." -ForegroundColor Yellow
$referenceCard = @"
REBATE MANAGEMENT DEMO - QUICK REFERENCE

SETUP:
- Setup ID: DEMO-001
- Item: MCP
- Components: MR(5%), EPI(2%), PPI(1.5%), VI(3%), Add(1%), Special(0.5%)

TRANSACTION:
- ID: DEMO-TRX-001
- Quantity: 150 units
- Unit Price: 100 RM
- Total: 15,000 RM

EXPECTED RESULTS:
- Total Rebate: 1,950 RM (13% of transaction)
- VI qualifies: Yes (150 > 100)
- Final Rebate: 2,000 RM (with +50 adjustment)

KEY FEATURES TO DEMONSTRATE:
1. Automatic matching
2. Component calculations
3. Manual adjustments
4. Approval workflow
5. Application to documents
"@

$referenceCard | Out-File -FilePath "Demo-QuickReference.txt" -Encoding UTF8
Write-Host "✓ Quick reference card created: Demo-QuickReference.txt" -ForegroundColor Green

Write-Host ""
Write-Host "Demo preparation complete! Ready to impress your client!" -ForegroundColor Green