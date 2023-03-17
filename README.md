# Customer Insights with Snowflake and PowerBI
The main objective of this project is to get access all the relevant from a single source and turn data into insights through Microsoft PowerBI integration.
The User have an access to first party data seemlessly in Snowflake Leverage the Data Marketplace to query live POS data from 3rd Party providers set up self-serve analytics via Visualization tools.

Going in detailed, this project will walk through the steps to Create staging environment, databases, tables, views, users, roles and a datawarehouse, load data into database 
using Snowflake account engineer and model data. Optinally for BI consumption, connect Snowflake account to PowerBI to author reports, vizualize data and perform optimization 
techniques to speedup reports/dashboards responsiveness.

#### Prerequisites:
1. Use Snowflake free 30-day trail enterprise environment.
2. Access to Azure account with the ability to launch a Azure Cloud Shell, and create an Azure Storage Container. The data is loaded from this container to snowflake warehouse.
3. Having installed Azure Storage Explorer, PowerBI and DAX Studio.

The setup of Azure blob data container and snowflake enterprise environment in explained in detailed in the following url 
https://quickstarts.snowflake.com/guide/attaining_consumer_insights_with_snowflake_and_microsoft_power_bi

#### POINTER:
The file "Migrating_Data_to_Azure_Cloud_Platform.sql" provides a detailed explonation of how an Azure storage container is created and how the data is populated using Azure cloud shell.
