/*-----------------------------------------------------------------------------------------
If the previous session is not retained execute the first three sql commands
--------------------------------------------------------------------------------------------*/
-- USE ROLE system admin to run the script
USE ROLE SYSADMIN;

USE WAREHOUSE ELT_WH;
-- Switch default context to the LAB_DB and PUBLIC schema
USE LAB_DB.PUBLIC;

/* ---------------------------------------------------------------------------------------
   Create a stage environment and load data to stage environement from Azure Blob Container
-------------------------------------------------------------------------------------------*/

-- Create the External Data Stage pointing to the Azure Blob Container
-- REPLACE <YOURACCOUNT> with the Azure Blob Storage account name from Module 3.1
--              EXAMPLE Azure Blob Storage URL: url='azure://mystorageaccount.blob.core.windows.net/lab-data'
-- REPLACE <YOURSASTOKEN> with the SAS Token you generated in Module 3.3. 
--              EXAMPLE Azure SAS Token: azure_sas_token='?sp=racwdl&st=2021-08-12T23:07:31Z&se=2022-08-13T07:07:31Z&spr=https&sv=2020-08-04&sr=c&sig=MI%2BdVxquZR5helrns39j7%2BpfzxY%2FZt9YDSHOrjySug%3D

CREATE OR REPLACE STAGE LAB_DATA_STAGE 
    url='azure://pbisf12345lab.blob.core.windows.net/lab-data'
    credentials=(azure_sas_token='sp=racwdl&st=2023-03-15T04:16:15Z&se=2023-03-15T12:16:15Z&spr=https&sv=2021-12-02&sr=c&sig=EudQoZ8jHg7XqVfsU8vMcR3MDykkfAaUs6TLIkz%2BNM8%3D');

-- Check that we can see the files in the External Data Stage using a LIST command    
LIST @LAB_DATA_STAGE;

/* ---------------------------------------------------------------------------
   Create a file format that understands our CSV specification and copy data
    from the Azure External Data Stage into the tables we created earlier
----------------------------------------------------------------------------*/

-- Create file format for the CSV files. 
-- These CSV files have no header, and the also require 'NULL' to be treated as null value
CREATE OR REPLACE FILE FORMAT CSVNOHEADER
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 0
    NULL_IF = ('NULL');
    
--  Load all the small tables and check samples
COPY INTO CATEGORY FROM @LAB_DATA_STAGE/category/ FILE_FORMAT = (FORMAT_NAME = CSVNOHEADER);
SELECT * FROM CATEGORY LIMIT 100;

COPY INTO CHANNELS FROM @LAB_DATA_STAGE/channels/ FILE_FORMAT = (FORMAT_NAME = CSVNOHEADER);
SELECT * FROM CHANNELS LIMIT 100;

COPY INTO DEPARTMENT from @LAB_DATA_STAGE/department/ FILE_FORMAT = (FORMAT_NAME = CSVNOHEADER);
SELECT * FROM DEPARTMENT LIMIT 100;

COPY INTO ITEMS from @LAB_DATA_STAGE/items/ FILE_FORMAT = (FORMAT_NAME = CSVNOHEADER);
SELECT * FROM ITEMS LIMIT 100;
SELECT COUNT(*) FROM ITEMS;

COPY INTO LOCATIONS from @LAB_DATA_STAGE/locations/ FILE_FORMAT = (FORMAT_NAME = CSVNOHEADER);
SELECT * FROM LOCATIONS LIMIT 100;
SELECT COUNT(*) FROM LOCATIONS;

COPY INTO STATES from @LAB_DATA_STAGE/states/ FILE_FORMAT = (FORMAT_NAME = CSVNOHEADER);
SELECT * FROM STATES LIMIT 100;

-- load the larger tables
-- check the files we have in the Sales Orders Items data
LIST @LAB_DATA_STAGE/items_in_sales_orders/;

-- there are 200 files, around 100MB each, which is around 20GB of compressed data
-- we will first load just one file and see how long it takes using the X-SMALL cluster
COPY INTO ITEMS_IN_SALES_ORDERS from @LAB_DATA_STAGE/items_in_sales_orders/items_in_sales_orders_0_0_0.csv.gz FILE_FORMAT = (FORMAT_NAME = CSVNOHEADER);

-- the above took ~20 seconds to load ~9 million rows.  we still have 199 more Sales Orders Items files to load, but that would  
-- take somewhere around 10-12 minutes if we kept the warehouse at X-SMALL.  Instead let's scale the warehouse to an XL

-- resize warehouse to X-LARGE
ALTER WAREHOUSE ELT_WH SET WAREHOUSE_SIZE = 'X-LARGE';

-- now copy the rest of the files in
COPY INTO ITEMS_IN_SALES_ORDERS from @LAB_DATA_STAGE/items_in_sales_orders/ FILE_FORMAT = (FORMAT_NAME = CSVNOHEADER);

-- that was much faster to load the remaning files! ~45 seconds instead of 10 minutes.
-- scaling up the warehouse like this is great for speeding up large ETL jobs

-- let's also copy the Sales Orders data in using the larger warehouse
COPY INTO SALES_ORDERS from @lab_data_stage/sales_orders/ FILE_FORMAT = (FORMAT_NAME = CSVNOHEADER);

-- we no longer need an XL warehouse, so let's stop paying for the extra 15 nodes by scaling back down to an XS
ALTER WAREHOUSE ELT_WH SET WAREHOUSE_SIZE = 'X-SMALL';

-- check the samples for the sales orders tables
SELECT * FROM SALES_ORDERS LIMIT 100;
SELECT COUNT(*) AS SALES_ORDERS_COUNT FROM SALES_ORDERS;

-- we have nearly 200 Million Sales Orders

SELECT * FROM ITEMS_IN_SALES_ORDERS LIMIT 100;
SELECT COUNT(*) AS ITEMS_IN_SALES_ORDERS_COUNT FROM ITEMS_IN_SALES_ORDERS;

-- we have nearly 1.8 Billion Sales Orders Items

