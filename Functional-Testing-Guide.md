# 🔬 REBATE MANAGEMENT SYSTEM - FUNCTIONAL TESTING GUIDE

## 📋 TEST ENVIRONMENT SETUP

### Prerequisites
- Business Central extension installed and synced
- User has "Rebate Mgmt - Full" permissions assigned
- Access to create items, customers, and purchase orders

---

## 🎯 TEST DATA CREATION

### **Step 1: Create Test Item**
1. Search for "Items" in Business Central
2. Click "New" to create item
3. Enter these details:
   - **No.**: `MCP`
   - **Description**: `Test Product MCP`
   - **Base Unit of Measure**: `PCS`
   - **Unit Price**: `100.00`
4. Save the item

### **Step 2: Create Test Customer**
1. Search for "Customers" in Business Central
2. Click "New" to create customer
3. Enter these details:
   - **No.**: `CUST001`
   - **Name**: `ABC Manufacturing Sdn Bhd`
   - **Address**: `123 Test Street`
   - **City**: `Kuala Lumpur`
   - **Payment Terms Code**: `30D` (30 days)
4. Save the customer

### **Step 3: Create Test Vendor (Optional)**
1. Search for "Vendors" in Business Central
2. Click "New" to create vendor
3. Enter these details:
   - **No.**: `VEND001`
   - **Name**: `XYZ Suppliers Sdn Bhd`
   - **Address**: `456 Vendor Road`
   - **City**: `Petaling Jaya`
4. Save the vendor

---

## 🧪 FUNCTIONAL TEST SCENARIOS

## **TEST SCENARIO 1: BASIC REBATE SETUP CREATION**

### **Test Case ID**: TC001
### **Objective**: Verify rebate setup creation and approval workflow
### **Priority**: High

### **Test Steps**:
1. Navigate to **Rebate Setup List**
2. Click **New** button
3. Fill in the Rebate Setup Card:

| Field | Value |
|-------|-------|
| Setup ID | `DEMO-001` |
| Description | `Demo Rebate Setup for MCP` |
| Rebate Type | `Recurring` |
| Priority | `1` |
| Status | `Draft` (auto-filled) |
| From Date | `01/01/2026` |
| To Date | `31/12/2026` |
| Item No. | `MCP` |
| Item Description | `Test Product MCP` (auto-filled) |
| Entity Type | `Customer` |
| Entity ID | `CUST001` |
| Entity Name | `ABC Manufacturing Sdn Bhd` (auto-filled) |

4. In **Rebate Setup Lines** section, add these components:

| Component Type | Rebate % | Min. Quantity | Max. Quantity |
|----------------|----------|---------------|---------------|
| Market Rebate | `5.00` | `0` | `0` |
| EPI | `2.00` | `0` | `0` |
| PPI | `1.50` | `0` | `0` |
| VI | `3.00` | `100` | `999999` |
| Additional Rebate | `1.00` | `0` | `0` |
| Special Rebate | `0.50` | `0` | `0` |

5. Click **Approve Setup** button
6. Verify status changes to **Approved**

### **Expected Results**:
- ✅ Setup created successfully
- ✅ All fields saved correctly
- ✅ 6 rebate components added
- ✅ Status changes to "Approved"
- ✅ Setup appears in Rebate Setup List

---

## **TEST SCENARIO 2: REBATE TRANSACTION PROCESSING**

### **Test Case ID**: TC002
### **Objective**: Test complete rebate transaction workflow
### **Priority**: High

### **Preconditions**:
- Test item MCP exists
- Test customer CUST001 exists
- Rebate setup DEMO-001 is approved

### **Test Steps**:

#### **Step 2.1: Create Rebate Transaction**
1. Navigate to **Rebate Transaction List**
2. Click **New** button
3. Fill in the Rebate Transaction Card:

| Field | Value |
|-------|-------|
| Transaction ID | `DEMO-TRX-001` |
| Document Type | `Purchase Order` |
| Document No. | `PO-001` (can be any reference) |
| Line No. | `10000` |
| Posting Date | Today's date |
| Item No. | `MCP` |
| Item Description | `Test Product MCP` (auto-filled) |
| Quantity | `150` |
| Unit Price | `100.00` |
| Line Amount | `15,000.00` (auto-calculated) |
| Entity Type | `Customer` |
| Entity ID | `CUST001` |
| Entity Name | `ABC Manufacturing Sdn Bhd` (auto-filled) |

#### **Step 2.2: Test Rebate Suggestion**
4. Click **Suggest Rebate** button
5. Verify system finds and applies setup DEMO-001
6. Check that rebate components are calculated:

| Component | Expected Amount | Calculation |
|-----------|-----------------|-------------|
| Market Rebate | `750.00` | 15,000 × 5% |
| EPI | `300.00` | 15,000 × 2% |
| PPI | `225.00` | 15,000 × 1.5% |
| VI | `450.00` | 15,000 × 3% (qty ≥ 100) |
| Additional Rebate | `150.00` | 15,000 × 1% |
| Special Rebate | `75.00` | 15,000 × 0.5% |
| **Total Rebate** | `1,950.00` | Sum of all components |

#### **Step 2.3: Test Manual Adjustment**
7. Enter **Proposed Adjustment**: `50.00`
8. Verify **Final Rebate** updates to `2,000.00`

#### **Step 2.4: Test Approval Workflow**
9. Click **Approve** button
10. Verify status changes to **Approved**
11. Click **Apply Rebate** button
12. Verify status changes to **Applied**

### **Expected Results**:
- ✅ Transaction created successfully
- ✅ Rebate setup automatically matched
- ✅ All components calculated correctly
- ✅ Manual adjustment works
- ✅ Approval workflow functions
- ✅ Application completes successfully

---

## **TEST SCENARIO 3: VOLUME INCENTIVE THRESHOLDS**

### **Test Case ID**: TC003
### **Objective**: Verify quantity-based rebate calculations
### **Priority**: Medium

### **Test Steps**:
1. Create new transaction with **Quantity**: `50` (below VI threshold)
2. Click **Suggest Rebate**
3. Verify VI component shows `0.00` (below 100 unit threshold)
4. Total Rebate should be `1,500.00` (1,950 - 450)

### **Expected Results**:
- ✅ VI component correctly excluded for low quantity
- ✅ Total rebate adjusted accordingly

---

## **TEST SCENARIO 4: MULTIPLE SETUP PRIORITY**

### **Test Case ID**: TC004
### **Objective**: Test priority-based setup selection
### **Priority**: Medium

### **Preconditions**:
- Create second setup DEMO-002 with Priority = 2 (lower priority)

### **Test Steps**:
1. Create transaction that matches both setups
2. Click **Suggest Rebate**
3. Verify system selects DEMO-001 (higher priority = lower number)

### **Expected Results**:
- ✅ Higher priority setup selected
- ✅ Correct rebate calculation applied

---

## **TEST SCENARIO 5: DATE VALIDITY TESTING**

### **Test Case ID**: TC005
### **Objective**: Verify date-based setup validity
### **Priority**: Medium

### **Test Steps**:
1. Create transaction with date outside setup validity period
2. Click **Suggest Rebate**
3. Verify no rebate setup is matched

### **Expected Results**:
- ✅ Setup not applied for out-of-range dates
- ✅ System handles invalid dates gracefully

---

## **TEST SCENARIO 6: COMPONENT BREAKDOWN VERIFICATION**

### **Test Case ID**: TC006
### **Objective**: Verify detailed component calculations
### **Priority**: High

### **Test Steps**:
1. After rebate suggestion, click on transaction line to view components
2. Verify each component shows:
   - Component type
   - Rebate percentage
   - Base amount (15,000)
   - Calculated rebate amount
   - Setup reference

### **Expected Results**:
- ✅ All 6 components visible
- ✅ Correct calculations displayed
- ✅ Setup reference maintained

---

## 🎬 DEMO SCRIPT FOR CLIENT PRESENTATION

## **Demo Flow (15-20 minutes)**

### **Opening (2 min)**
"Good [morning/afternoon], [Client Name] team. Today I'll demonstrate our comprehensive Rebate Management solution that transforms how you handle rebates in Business Central."

### **Setup Demonstration (4 min)**
1. Show Rebate Setup List
2. Create DEMO-001 setup
3. Explain each component and business rules
4. Demonstrate approval workflow

*"This flexible setup allows you to model any rebate structure your business requires."*

### **Transaction Processing (6 min)**
1. Create rebate transaction
2. Demonstrate automatic matching
3. Show component breakdown calculation
4. Add manual adjustment
5. Walk through approval and application

*"Watch how the system eliminates manual calculations and provides complete transparency."*

### **Business Value Discussion (4 min)**
1. Show audit trail capabilities
2. Demonstrate volume incentive logic
3. Explain priority-based matching
4. Discuss reporting possibilities

*"This solution delivers 80% faster rebate processing with 100% accuracy."*

### **Q&A and Next Steps (4 min)**
Address questions and discuss implementation timeline.

---

## 📊 TEST EXECUTION CHECKLIST

- [ ] Test Item MCP created
- [ ] Test Customer CUST001 created
- [ ] Rebate Setup DEMO-001 created and approved
- [ ] Rebate Transaction DEMO-TRX-001 processed successfully
- [ ] All components calculated correctly (1,950 RM total)
- [ ] Manual adjustment works (+50 RM = 2,000 RM final)
- [ ] Approval and application workflow complete
- [ ] Volume incentive threshold testing passed
- [ ] Date validity testing passed
- [ ] Component breakdown verification passed

---

## 🔧 TROUBLESHOOTING

### **If pages don't appear:**
- Check user permissions
- Verify extension is installed and synced
- Restart Business Central client

### **If rebate not suggested:**
- Verify transaction date within setup validity
- Check item/entity matches setup criteria
- Ensure setup status is "Approved"

### **If calculations wrong:**
- Double-check component percentages
- Verify quantity thresholds
- Review manual adjustments

### **If approval fails:**
- Check user permissions
- Verify transaction is in "Suggested" status
- Ensure all required fields are filled

---

## 📞 SUPPORT CONTACTS

For technical issues during testing:
- Check permission assignments
- Verify extension sync status
- Review Business Central event logs
- Contact development team for assistance

---

**Ready to test and demonstrate! Follow this guide step-by-step for successful rebate management testing.** ✅