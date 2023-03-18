# Resource Cleanup
This is the final phase in the project once we are done with the visualization, it is one of the best practice to drop all the used resources, here in our project
we made use of Azure blob container and snowflake could database resources. It is advised to delete the resources after completion.

Execute the following SQL commands in the snowflake worksheet.


/* ---------------------------------------------------------------------------
   Clean up and Reset dropping warehouses and objects
----------------------------------------------------------------------------*/

USE ROLE SYSADMIN;
DROP DATABASE IF EXISTS LAB_DB;
USE ROLE ACCOUNTADMIN;
DROP WAREHOUSE IF EXISTS ELT_WH;
DROP WAREHOUSE IF EXISTS POWERBI_WH;

Go to Azure and delete the container.
