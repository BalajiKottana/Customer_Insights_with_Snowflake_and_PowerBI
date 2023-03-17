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

--Create Item View
CREATE VIEW items_v COMMENT='ITEM View' AS
    select d.department_name as department_name, c.category_name as category_name,item_id,item_name, item_price  
    from 
    items a 
        inner join department d on a.department_id=d.department_id
        inner join category c on a.category_id=c.category_id;
 -- Create Location View
 Create view location_v comment='Location View' as
    select 
        location_id,country,latitude,longitude,municipality, L.region,s.state_geo,s.state_name
    from locations l 
            inner join states s on l.REGION=S.REGION;
  
 --Create Sales_Orders View
create view sales_orders_v comment='Sales_Order_View' as
    select channel_code,iso.item_id,so.location_id,iso.order_id,iso.quantity,so.sales_date
    from sales_orders so inner join items_in_sales_orders iso on so.sales_order_id=iso.sales_order_id
    
--Create Sales_Order View aggregation
 create view sales_orders_v_agg comment='Sales_Order_View_Aggregation' as
    select channel_code as channel_id,item_id,location_id,sum(quantity) as total_quantity
    from sales_orders_v group by channel_code,item_id,location_id  
 
 /*
 Pointer:
 After this point we will connect Snowflake Cloud to PowerBI desktop, please nvaigate to Snowflake_integration_with_Power_BI.md file.
 */ 
 
 
 
 


