/*
====================================
Creating tables in silver  schema
====================================
Script Purpose: 
    Creates tables in the  silver schema for CRM and ERP systems.
    Tables include customer information, product information, sales details, 
    and ERP-related data. Script drops tables if they already exist.
====================================
*/

-- =====================================================
-- CRM Customer Information Table
-- =====================================================
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;

CREATE TABLE silver.crm_cust_info(
    cst_id INT NOT NULL,                          -- Customer ID (Primary Key candidate)
    cst_key NVARCHAR(50) NOT NULL,                -- Customer external key/code
    cst_firstname NVARCHAR(50) NOT NULL,          -- Customer first name
    cst_lastname NVARCHAR(50) NOT NULL,           -- Customer last name
    cst_martial_status NVARCHAR(50),              -- Marital status (optional)
    cst_gndr NVARCHAR(50),                        -- Gender (optional)
    cst_created_date DATE NOT NULL,                -- Date customer record was created
    dwh_creation_time datetime2 default getdate()
);

-- =====================================================
-- CRM Product Information Table
-- =====================================================
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;

CREATE TABLE silver.crm_prd_info(
    prd_id INT NOT NULL,                          -- Product ID (Primary Key candidate)
    prd_key NVARCHAR(50) NOT NULL,                -- Product external key/SKU
    prd_nm NVARCHAR(50) NOT NULL,                 -- Product name
    prd_cost DECIMAL(10, 2),                      -- Product cost (changed from INT for financial accuracy)
    prd_line NVARCHAR(50),                        -- Product line/category
    prd_start_dt DATETIME NOT NULL,               -- Product availability start date
    prd_end_dt DATETIME            ,               -- Product availability end date (optional)
    dwh_creation_time datetime2 default getdate()
);

-- =====================================================
-- CRM Sales Details Table
-- =====================================================
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;

CREATE TABLE silver.crm_sales_details(
    sls_order_num VARCHAR(50) NOT NULL,           -- Sales order number (Corrected typo: orrder_num → order_num)
    sls_prd_key NVARCHAR(50) NOT NULL,            -- Product key (Foreign Key candidate)
    sls_cust_id INT NOT NULL,                     -- Customer ID (Foreign Key candidate)
    sls_order_dt DATE NOT NULL,                   -- Order date (changed from INT to DATE for clarity)
    sls_ship_dt DATE,                             -- Ship date (changed from INT to DATE; optional)
    sls_due_dt DATE,                              -- Due date (changed from INT to DATE; optional)
    sls_sales DECIMAL(10, 2) NOT NULL,            -- Sales amount (changed from INT for financial accuracy)
    sls_quantity INT NOT NULL,                    -- Quantity ordered
    sls_price DECIMAL(10, 2) NOT NULL,             -- Unit price (changed from INT for financial accuracy)
dwh_creation_time datetime2 default getdate()
);

-- =====================================================
-- ERP Customer Data Table (System: AZ12)
-- =====================================================
IF OBJECT_ID('silver.erp_CUST_AZ12', 'U') IS NOT NULL
    DROP TABLE silver.erp_CUST_AZ12;

CREATE TABLE silver.erp_CUST_AZ12(
    CID VARCHAR(50) NOT NULL,                     -- Customer ID from ERP system
    BDATE DATE NOT NULL,                          -- Birth date
    GEN VARCHAR(50)                         ,     -- Gender
dwh_creation_time datetime2 default getdate()
);

-- =====================================================
-- ERP Location Data Table (System: A101)
-- =====================================================
IF OBJECT_ID('silver.erp_LOC_A101', 'U') IS NOT NULL
    DROP TABLE silver.erp_LOC_A101;

CREATE TABLE silver.erp_LOC_A101(
    CID VARCHAR(50) NOT NULL,                     -- Customer ID reference
    CNTRY VARCHAR(50) NOT NULL,                    -- Country code or name
dwh_creation_time datetime2 default getdate()
);

-- =====================================================
-- ERP Product Category Table (System: PX_CAT_G1V2)
-- =====================================================
IF OBJECT_ID('silver.erp_PX_CAT_G1V2', 'U') IS NOT NULL
    DROP TABLE silver.erp_PX_CAT_G1V2;

CREATE TABLE silver.erp_PX_CAT_G1V2(
    ID VARCHAR(50) NOT NULL,                      -- Product/Category ID
    CAT VARCHAR(50) NOT NULL,                     -- Category
    SUBCAT VARCHAR(50),                           -- Subcategory
    MAINTENANCE VARCHAR(50)    ,                   -- Maintenance flag or level
dwh_creation_time datetime2 default getdate()
);
