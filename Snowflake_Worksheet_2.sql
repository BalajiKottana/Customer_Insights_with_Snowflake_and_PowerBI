/* ---------------------------------------------------------------------------
   Next we create the Database as SYSADMIN and grant usage to POWERBI_ROLE
----------------------------------------------------------------------------*/

USE ROLE SYSADMIN;

-- Create the database
CREATE DATABASE IF NOT EXISTS LAB_DB;

GRANT USAGE ON DATABASE LAB_DB TO ROLE POWERBI_ROLE;

-- Ensure we are using the ELT warehouse for data loading so we don't affect Power BI users
USE WAREHOUSE ELT_WH;

-- Switch default context to the LAB_DB and PUBLIC schema
USE LAB_DB.PUBLIC;

-- Create the Category table
create or replace TABLE CATEGORY (
	CATEGORY_ID NUMBER(38,0),
	CATEGORY_NAME VARCHAR(50)
);

-- Create the Channels table
create or replace TABLE CHANNELS (
	CHANNEL_ID NUMBER(38,0),
	CHANNEL_NAME VARCHAR(50)
);

-- Create the Department table
create or replace TABLE DEPARTMENT (
	DEPARTMENT_ID NUMBER(38,0),
	DEPARTMENT_NAME VARCHAR(50)
);

-- Create the Items table
create or replace TABLE ITEMS (
	ITEM_ID NUMBER(38,0),
	ITEM_NAME VARCHAR(250),
	ITEM_PRICE FLOAT,
	DEPARTMENT_ID NUMBER(38,0),
	CATEGORY_ID NUMBER(38,0),
	TMP_ITEM_ID NUMBER(38,0)
);

-- Create the Sales Orders table
create or replace TABLE SALES_ORDERS (
	SALES_ORDER_ID NUMBER(38,0),
	CHANNEL_CODE NUMBER(38,0),
	CUSTOMER_ID NUMBER(38,0),
	PAYMENT_ID NUMBER(38,0),
	EMPLOYEE_ID NUMBER(38,0),
	LOCATION_ID NUMBER(38,0),
	SALES_DATE TIMESTAMP_NTZ(9),
	TMP_ORDER_ID FLOAT,
	TMP_ORDER_DOW NUMBER(38,0),
	TMP_USER_ID NUMBER(38,0)
);

-- Create the Sales Orders Items table
create or replace TABLE ITEMS_IN_SALES_ORDERS (
	SALES_ORDER_ID NUMBER(38,0),
	ITEM_ID NUMBER(38,0),
	ORDER_ID NUMBER(38,0),
	PROMOTION_ID NUMBER(38,0),
	QUANTITY FLOAT,
	REORDERED NUMBER(38,0),
	TMP_ORDER_ID FLOAT,
	TMP_PRODUCT_ID NUMBER(38,0)
);

-- Create the Locations table
-- This table will also contain Geospatial data in the GEO column
create or replace TABLE LOCATIONS (
	LOCATION_ID NUMBER(38,0),
	NAME VARCHAR(100),
	GEO2 VARCHAR(250),
	GEO GEOGRAPHY,
	LAT FLOAT,
	LONG FLOAT,
	COUNTRY VARCHAR(200),
	REGION VARCHAR(100),
	MUNICIPALITY VARCHAR(200),
	LONGITUDE FLOAT,
	LATITUDE FLOAT
);

-- Create the States table
create or replace TABLE STATES (
	STATE_CODE NUMBER(38,0),
	STATE_NAME VARCHAR(250),
	REGION VARCHAR(250),
	STATE_GEO VARCHAR(16777216)
);

/* ---------------------------------------------------------------------------
   GRANT READ ACCESS TO ALL TABLES IN LAB_DB TO POWERBI_ROLE
----------------------------------------------------------------------------*/
GRANT USAGE ON SCHEMA LAB_DB.PUBLIC TO ROLE POWERBI_ROLE;
GRANT SELECT ON ALL TABLES IN SCHEMA LAB_DB.PUBLIC TO ROLE POWERBI_ROLE;
