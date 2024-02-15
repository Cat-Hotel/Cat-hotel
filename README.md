# Cat-hotel
### Detailed Instructions for Setting Up AWS RDS, SQL Server, and Flyway

**Assumptions:**
1. You have already forked the repository.
2. You are using Visual Studio Code (VSCode).
3. You are familiar with obtaining access keys and secret keys from AWS.
4. You have basic knowledge of AWS services and SQL Server.

#### Setting Up Terraform for AWS RDS

1. Install Terraform by following the instructions (https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started).
2. Open your terminal and navigate to the Terraform directory in your project by running `cd Terraform`.
3. Create a file named `secrets.tfvars` and add the necessary variables such as `db_username` and `db_password`.

   ![image](https://github.com/Cat-Hotel/Cat-hotel/assets/159034648/5be850c2-8452-4ca5-888a-7e801198fd16)

4. Initialize Terraform by running `terraform init` in the terminal.
5. Apply the Terraform configuration using the command `terraform apply -var-file="secrets.tfvars"`. This ensures that sensitive variables are not exposed over the internet.

#### Setting Up SQL Server

1. Wait for Terraform to provision the AWS RDS instance. The setup time may vary depending on the instance type.
2. Once the RDS instance is created successfully, go to the AWS Management Console to capture the endpoint and port of the RDS instance.
3. Open SQL Server Management Studio (SSMS) or any SQL client of your choice.
4. Connect to the SQL Server using the following credentials:
   - **Server name:** Endpoint from AWS
   - **Authentication:** SQL Server Authentication
   - **Login:** Username created in `secrets.tfvars`
   - **Password:** Password created in `secrets.tfvars`
5. Execute the SQL script below to create a database named `CatHotel`:

   ```sql
   USE master;
   GO

   IF DB_ID (N'CatHotel') IS NOT NULL
       ALTER DATABASE CatHotel SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

   IF DB_ID (N'CatHotel') IS NOT NULL
       DROP DATABASE CatHotel;
   GO

   CREATE DATABASE CatHotel;
   GO
### Setting Up Flyway for Database Migration

1. Download and install Flyway Desktop from https://www.red-gate.com/products/flyway/community/download/\
   
![image](https://github.com/Cat-Hotel/Cat-hotel/assets/159034648/2afad51b-766d-4aa1-8f8f-7955e511a7dd)

2.  Open your project.
3. Locate the `flyway.toml` file within the `Flyway/FlywayCatHotel/` directory and open it in Visual Studio Code (VSCode).
4. In Flyway Desktop:
   
   ![image](https://github.com/Cat-Hotel/Cat-hotel/assets/159034648/c41be03b-c4a7-4a5a-8ac3-5530306e4c47)
   
   - Click on the "+" icon to add a new configuration.
     
   ![image](https://github.com/Cat-Hotel/Cat-hotel/assets/159034648/dbf6171c-f15a-4623-ad92-62b55c3a0bab)

   - Enter the following details:
     - **ID:** CatHotelDB
     - **Display name:** Anything you prefer
     - **Driver:** Microsoft SQL Server
     - **Server:** Endpoint from AWS
     - **Port:** Port from AWS
     - **Database Name:** CatHotel
     - Check "Encrypt" and "Trust Server Certificate"
     - **Authentication:** SQL Server Authentication
     - **Username:** Same as in `secrets.tfvars`
     - **Password:** Same as in `secrets.tfvars`
   - Click the "Test Connection" button and wait for a green indicator.
   - Copy the JDBC URL and click "Test" and then "Save".
     
     ![image](https://github.com/Cat-Hotel/Cat-hotel/assets/159034648/88f0ab23-4d3f-4aa2-9ad4-d05a81895f80)
     
5. Go to your GitHub repository and navigate to "Actions".
6. Go to the repository secrets and add three new secrets:
   - `DB_BUILD_PASSWORD`: Same as in `secrets.tfvars`
   - `DB_BUILD_USERNAME`: Same as in `secrets.tfvars`
   - `DB_BUILD_URL`: JDBC URL obtained from Flyway.
