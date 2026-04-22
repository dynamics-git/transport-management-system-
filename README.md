# Rebate Management Module

## Overview
A comprehensive rebate management system for Microsoft Dynamics 365 Business Central that calculates and applies rebates based on flexible setup rules.

## Features
- **Multi-component Rebates**: Market Rebate, EPI, PPI, VI, Additional, and Special Rebates
- **Flexible Setup**: Date-based validity, product-specific, entity-specific rules
- **Priority Matching**: Intelligent matching with fallback logic
- **Manual Adjustments**: Proposed adjustments for additional or reduced rebates
- **Workflow Management**: Draft → Suggested → Approved → Applied status flow
- **Audit Trail**: Complete tracking of calculations and applications

## AL Objects Created

### Enums (50000-50003)
- `Rebate Type` - Recurring/One-off
- `Rebate Status` - Draft/Suggested/Approved/Applied/Cancelled
- `Entity Type` - Customer/Vendor/Project Support/End User
- `Rebate Component Type` - Market Rebate, EPI, PPI, VI, Additional, Special

### Tables (50000-50003)
- `Rebate Setup Master` - Core setup rules
- `Rebate Setup Line` - Component breakdowns per setup
- `Rebate Transaction` - Rebate application instances
- `Rebate Transaction Line` - Component calculations per transaction

### Pages (50000-50011)
- `Rebate Setup List` - List of all rebate setups
- `Rebate Setup Card` - Detail view of single setup
- `Rebate Setup Subpage` - Component lines
- `Rebate Transaction List` - List of rebate transactions
- `Rebate Transaction Card` - Detail view of single transaction
- `Rebate Transaction Subpage` - Component breakdown
- `Rebate Setup FactBox` - Setup details
- `Sample Amount` - Demo calculation dialog

### Codeunits (50000-50003)
- `Rebate Calculation Engine` - Component calculations
- `Rebate Matching Engine` - Setup matching logic
- `Rebate Application Manager` - Workflow and application
- `Rebate Demo Data` - Sample data creation

### Permission Sets (50000-50001)
- `Rebate Mgmt - Basic` - Table access permissions (RIMD)
- `Rebate Mgmt - Full` - Complete access including pages and codeunits

## Setup Instructions

1. **Publish the Extension**
   ```powershell
   # In Business Central Administration Shell
   Publish-NAVApp -ServerInstance YourInstance -Path ".\RebateManagement.app"
   ```

2. **Install the Extension**
   ```powershell
   Install-NAVApp -ServerInstance YourInstance -Name "Rebate Management"
   ```

3. **Assign Permission Sets**
   ```powershell
   # Assign basic permissions to users
   New-NAVServerUserPermissionSet -ServerInstance YourInstance -UserName "username" -PermissionSetId "REBATE MGMT - BASIC"

   # Or assign full permissions for administrators
   New-NAVServerUserPermissionSet -ServerInstance YourInstance -UserName "admin" -PermissionSetId "REBATE MGMT - FULL"
   ```

4. **Sync the Extension**
   ```powershell
   Sync-NAVApp -ServerInstance YourInstance -Name "Rebate Management"
   ```

5. **Create Sample Data** (Optional)
   - Run the `Rebate Demo Data` codeunit
   - Or manually create rebate setups via the Rebate Setup List

## Demo Scenario

### Step 1: Create Rebate Setup
1. Navigate to **Rebate Setup List**
2. Click **New** to create a new setup
3. Fill in:
   - Setup ID: DEMO-001
   - Description: Demo Rebate for MCP
   - Validity: Today to 1 year from now
   - Item: MCP
   - Entity Type: Customer (leave ID blank for all)
   - Rebate Type: Recurring
   - Priority: 1
4. Add components in the lines:
   - Market Rebate: 5%
   - EPI: 2%
   - PPI: 1.5%
   - VI: 3% (min qty: 100)
   - Additional: 1%
   - Special: 0.5%
5. Set status to **Approved**

### Step 2: Create Rebate Transaction
1. Navigate to **Rebate Transaction List**
2. Click **New** to create a transaction
3. Fill in:
   - Transaction ID: DEMO-TRX-001
   - Document Type: Purchase Order
   - Document No: PO-001
   - Posting Date: Today
   - Item: MCP
   - Quantity: 150
   - Unit Price: 100.00
   - Entity Type: Customer
   - Entity ID: CUST001

### Step 3: Calculate Rebate
1. Click **Suggest Rebate** - system finds matching setup
2. Review calculated components (should show all 6 components)
3. Add **Proposed Adjustment** if needed (e.g., +10.00 or -5.00)
4. Click **Approve** to approve the rebate
5. Click **Apply Rebate** to apply to the source document

### Expected Results
- **Base Amount**: 15,000.00 RM (150 × 100)
- **Market Rebate**: 750.00 RM (5% of 15,000)
- **EPI**: 300.00 RM (2% of 15,000)
- **PPI**: 225.00 RM (1.5% of 15,000)
- **VI**: 450.00 RM (3% of 15,000 - qualifies for volume)
- **Additional**: 150.00 RM (1% of 15,000)
- **Special**: 75.00 RM (0.5% of 15,000)
- **Total Rebate**: 1,950.00 RM
- **Final Rebate**: 1,950.00 RM + any adjustment

## Business Value Demonstration

1. **Flexibility**: Show how different setups can apply to different customers/products
2. **Automation**: Demonstrate automatic matching and calculation
3. **Transparency**: Show component breakdown for auditability
4. **Control**: Illustrate approval workflow and manual adjustments
5. **Scalability**: Explain how the system handles multiple rules with priorities

## Technical Notes

- **Performance**: Uses proper indexing on key fields
- **Extensibility**: Enums and tables designed for easy extension
- **Validation**: Comprehensive field and business logic validation
- **Integration**: Ready for GL posting and document integration
- **Security**: Standard BC security model with table permissions

## Future Enhancements

- GL account integration for rebate posting
- Advanced matching rules (customer groups, item categories)
- Rebate accrual and settlement
- Reporting and analytics
- API endpoints for external integration
- Multi-currency support
- Advanced approval workflows