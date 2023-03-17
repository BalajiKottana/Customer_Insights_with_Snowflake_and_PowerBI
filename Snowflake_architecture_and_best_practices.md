# Snowflake Architecture and Best Practices
Snowflake is a Data Cloud which is powered by an advance Data Platform provided as a self managed service. Snowflake 
enables data storage, processing, and analytic solutions that are faster, easier to use, and far more flexible than traditional offerings.

### Snowflake Architectures
Snowflake architectures is a hybrid of traditional shared disk and shared nothing database architectures. This architecture provides a layered abstraction between
Data Storage, Query Processing and Cloud Services. This architecutre also comes with the concept of Virtual Warhouse, where the load on one warehouse does not 
affect the performance of other warehouse. Most importantly, Data Storage and Query Prcessing can happen parallel in time. 

![image](https://user-images.githubusercontent.com/122858293/225995071-903e5e56-071a-4df1-9be1-403399e8c642.png)

(Picture shared from the snowflake architecture documentations)

### Snowflake Interface
In order to provide data abstraction and security with in the users of this enterprise architecutre, snowflake contains different user roles such as ACCOUNTADMIN, 
SYSADMIN, USERADMIN, SECURITYADMIN and other user defined roles to access the virtual warehouse. In practical environments, a user will be assigned a subset of roles 
and may not have ACCOUNTADMIN or SYSTEMADMIN to create Warehouses, Databases, Schemas, Tables, Views, and Create and Grant roles, for the implementation of this 
project, it is advised to use the 30 day free trail of Snowflake data cloud. After logging into the snowflake web-based cloud environment, one can see databases under
DATA menu, interactive visualizations under Dashboard menu and Marketplace menu contains datasets that the user can get access to on request. As an ACCOUNTADMIN and SYSADMIN,
in this project we will confine to Worksheets menu where user can execute queries and interact with data store through warehouse.

### Data Lifecycle
All user data in Snowflake is logically represented as tables that can be queried and modified through standard SQL interfaces. Each table belongs to a schema which 
in turn belongs to a database.

![image](https://user-images.githubusercontent.com/122858293/225990874-858e6fe5-5290-40dd-9b72-743b57864f00.png)

(Refered from snowflake documentation of data-lifecycle)

### Best Practices
In this project,I have followed some of the best practices suggested by snowflake. 
1. Create saperate warehouse such as ELT_WH (for data loading from Azure data store which was created earlier) and POWERBI_WH (for interaction with visualization tools)
 by this saperation we can prallelly access the data as well as perform data ingestion. In conventional warehouses this operations are often performed in interleaved fashion.
2. Create saperate roles and users, and map approrpiate roles to users.
3. Dynamically resize the warehouse as per requirement with an execution of a single command. This practice modulates the cost as per usage of the warehouse. 
4. Clean all the resources at the end of the data-cycle.

##### Prerequisites:
To explore in detailed about snowflake, please refer to the following URL:  
https://docs.snowflake.com/en/user-guide/intro-key-concepts

#### POINTER:
The file "Snowflake_Worksheet.sql" describes how the schemas are Warehouse and schemas are created, how the data is populated into the snowflake envirnment and finally creation of views reqired for data visualization.
