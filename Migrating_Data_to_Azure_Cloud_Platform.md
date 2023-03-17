# Migrating Data to Azure cloud storage 
In this phase describes the details of following steps to:
1. Create Azure storage account
2. Create a blob container in storage account
3. Generate Shared Access Signature to use as a credential when connecting to the storage account
4. Load files from Github to storage account using Azure Cloud Shell
5. (Optional)Connect Azure Storage Explorer to the storage account to browse files.

### 1. Create a Blob Storage Container
After loging to  Azure platform, navagate to Storage Accounts to create one storage account
![image](https://user-images.githubusercontent.com/122858293/225816283-7814050c-4e24-463b-b88a-d2f3f1694750.png)
![image](https://user-images.githubusercontent.com/122858293/225818297-ed65090a-c005-42e4-a253-477a0cfb1f7a.png)
![image](https://user-images.githubusercontent.com/122858293/225818408-c6cba780-0a25-4397-91a1-8c978aae6467.png)
![image](https://user-images.githubusercontent.com/122858293/225818557-9ad8d258-8a56-4d7f-8b77-cfdf0899dd5b.png)
Click on "Go to Resources"
### 2. Create a Blob Container
Go to container under Data Storage
![image](https://user-images.githubusercontent.com/122858293/225819163-120fb5f2-7dd6-447b-9381-ee9d64ba8f7f.png)

Click on +Create, provide the container name as "Lab-data" and click "Create" button.
![image](https://user-images.githubusercontent.com/122858293/225819694-7671ea47-c752-4d10-8ce5-2a29b7748eb8.png)
### 3. Generate SAS Token
For the container lab-data generate SAS key by clicking on "Generate SAS"
![image](https://user-images.githubusercontent.com/122858293/225820058-fcbbfd14-202f-4bd0-80db-9c3fbfba250c.png)

Ater clicking button, the following page opens
![image](https://user-images.githubusercontent.com/122858293/225820273-e58263f0-a61c-4d46-9262-e8fbe4a216cf.png)

Click on "SAS Token and URL" button.
![image](https://user-images.githubusercontent.com/122858293/225820442-9a203e2a-fcff-4542-a888-97001fbebff1.png)

Copy the generated SAS Key and URL for further use, which will be used for authenticating and loading data into this container.
![image](https://user-images.githubusercontent.com/122858293/225820595-b1d671b0-b12a-4006-8acc-19b30b21075d.png)
### 4. Load Azure cloud shell and run script to load files form github
The URL for the script file to run is provided in the prequisites of this page.

Open Azure cloud shell and upload the file into the cloud shell folder as shown below
![image](https://user-images.githubusercontent.com/122858293/225822169-76fae895-75fe-4fa2-a4b2-ddbf8a0a66a9.png)

Once the file is uploaded when we execute "ls -l" we can find the uploaded file in the cloud folder as shown below
![image](https://user-images.githubusercontent.com/122858293/225822466-515ce644-08c1-4258-8d30-bcba0996618c.png)

To open the file in the terminal use code followed by the file name as shown below.
![image](https://user-images.githubusercontent.com/122858293/225823214-394ed297-a1b6-4c97-960c-ae7ab8166b5f.png)

Open the script in visual studio and place the token and hostname saved previously and repeat step four (4). when user types code followed by file name the result will be as follows.
![image](https://user-images.githubusercontent.com/122858293/225823773-1aeeb04c-16a5-4087-b0ed-613a39c5ab94.png)

To Run the script type bash followed by filename as belown and the data from bithub repository gets populated into the blob container.
![image](https://user-images.githubusercontent.com/122858293/225824137-08dc769d-82f6-4e90-a6e9-5e015e63b277.png)
This will take around one hour to load the data into container. once this operation is done we can move further to load this data into Snowflake warehouse.
### 5. (Optional) Connect Azure Storage Explorer to the storage account to browse files
Azure Storage Explorer is a free tool that lets you manage cloud storage resources from your desktop
![image](https://user-images.githubusercontent.com/122858293/225825407-ca7b2d39-c428-49ee-b76f-49903bf466e7.png)
![image](https://user-images.githubusercontent.com/122858293/225825507-e6ebdccd-efd3-448a-93ea-91b1cd2e4a8f.png)
Enter the "Blob SAS URL" that was generated in 4.3 above. The Display name should default to "lab-data" (unless you changed the container name). Click "Next" and then "Connect" on the next screen.
![image](https://user-images.githubusercontent.com/122858293/225825639-fc972f9b-f043-44b6-b8be-10d9293f216d.png)
You should now see the files that were loaded into the storage account
![image](https://user-images.githubusercontent.com/122858293/225825730-496d318f-73fb-496a-9130-1ed525c0cb85.png)



Prerequisite:
Download this file to load the script file into Azure cloud shell and run.
https://raw.githubusercontent.com/sfc-gh-ccollier/sfquickstart-samples/main/samples/snowflake-powerbi-retail-vhol/scripts/lab-snowflake-powerbi-load-to-azure-blob.sh

