/* Create Database and Schemas 
==================================
Script Purpose :
This script creates a new database named DATAWAREHOUSE and three schemas within it: bronze, silver, and gold. These schemas can be used to organize and manage data in a structured manner.
Warning:
running this script will create a new database and schemas. Ensure that you have the necessary permissions and that the database name does not conflict with existing databases.
==================================
*/

USE MASTER 
-- create a new database named DATAWAREHOUSE
CREATE DATABASE DATAWAREHOUSE 
USE DATAWAREHOUSE
--create three schemas: bronze, silver, and gold
CREATE schema bronze
go
create schema silver
go 
create schema gold
go
