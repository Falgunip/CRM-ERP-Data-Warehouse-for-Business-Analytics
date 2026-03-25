/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


Use Master;
GO

-- Drop and recreate the 'DataWarehouse database
IF EXISTS (
          SELECT 1 
          FROM sys.databases 
          WHERE name = 'DataWarehouse'
)
BEGIN 
    ALTER DATABASE DataWarehouse 
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse'database again
CREATE DATABASE DataWarehouse;
GO

-- Swith to new DB
Use DataWarehouse;
GO

-- Create Schemas safely
IF NOT EXISTS (SELECT * 
               FROM sys.schemas
               WHERE name = 'bronze')
EXEC('CREATE SCHEMA bronze');
GO

IF NOT EXISTS (SELECT * 
               FROM sys.schemas
               WHERE name = 'silver')
EXEC('CREATE SCHEMA silver');
GO

IF NOT EXISTS (SELECT * 
               FROM sys.schemas
               WHERE name = 'gold')
EXEC('CREATE SCHEMA gold');
GO
