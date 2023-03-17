/*-----------------------------------------------------------------------------------------
If the previous session is not retained execute the first three sql commands
--------------------------------------------------------------------------------------------*/
-- USE ROLE system admin to run the script
USE ROLE SYSADMIN;

USE WAREHOUSE ELT_WH;

-- Switch default context to the LAB_DB and PUBLIC schema
USE LAB_DB.PUBLIC;

/*-----------------------------------------------------------------------------------------
Once the data is loaded into production tables, we now in this file create views required 
for visualization
------------------------------------------------------------------------------------------*/


