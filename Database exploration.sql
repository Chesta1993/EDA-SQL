
--------DATABASE EXPLORATION-----
-----Explore All Objects In The Database

select * from INFORMATION_SCHEMA.TABLES

----Explore All columns In Databse

select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME ='gold.dim_customers'