/* ---------------------------------------------------------------------------
   First we configure any required Warehouse(s), Role(s), User(s) as ACCOUNTADMIN
----------------------------------------------------------------------------*/

USE ROLE ACCOUNTADMIN;

-- Create Warehouse for ELT work
CREATE OR REPLACE WAREHOUSE ELT_WH
  WITH WAREHOUSE_SIZE = 'X-SMALL'
  AUTO_SUSPEND = 120
  AUTO_RESUME = true
  INITIALLY_SUSPENDED = TRUE;

-- Create Warehouse for Power BI work
CREATE OR REPLACE WAREHOUSE POWERBI_WH
  WITH WAREHOUSE_SIZE = 'MEDIUM'
  AUTO_SUSPEND = 120
  AUTO_RESUME = true
  INITIALLY_SUSPENDED = TRUE;
  
-- Create a Power BI Role

CREATE OR REPLACE ROLE POWERBI_ROLE COMMENT='Power BI Role';
GRANT ALL ON WAREHOUSE POWERBI_WH TO ROLE POWERBI_ROLE;
GRANT ROLE POWERBI_ROLE TO ROLE SYSADMIN;

-- Create a Power BI User
CREATE OR REPLACE USER POWERBI PASSWORD='PBISF123' 
    DEFAULT_ROLE=POWERBI_ROLE 
    DEFAULT_WAREHOUSE=POWERBI_WH
    DEFAULT_NAMESPACE=LAB_DW.PUBLIC
    COMMENT='Power BI User';

GRANT ROLE POWERBI_ROLE TO USER POWERBI;

-- Also grant all rights on the Warehouses to the SYSADMIN role
GRANT ALL ON WAREHOUSE ELT_WH TO ROLE SYSADMIN;
GRANT ALL ON WAREHOUSE POWERBI_WH TO ROLE SYSADMIN;


