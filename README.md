PROJECT OVERVIEW:

This project focuses on designing and implementing an end-to-end Retail Data Warehouse to support analytical reporting and business intelligence.
The solution separates OLTP and OLAP workloads and uses dimensional modeling to enable fast and scalable analysis.


OBJECTIVES:
Build a structured Data Warehouse architecture

Design Star Schema for analytical reporting

Implement ETL pipelines using Python and SQL

Track historical changes using Slowly Changing Dimensions (SCD)

Generate business insights using optimized SQL queries


ARCHITECTURE:
The data warehouse is designed with the following layers:

STAGING LAYER:
Stores raw data extracted from OLTP systems and CSV files

No transformations applied

Used for auditing and reprocessing

ODS (Operational Data Store):

Cleansed and standardized data

Handles duplicates, null values, and basic transformations

DATA MART LAYER:

Dimensional model using Star Schema

Optimized for analytical queries and reporting.


DATA MODELING (STAR SCHEMA)
FACT TABLE

fact_sales

Measures: quantity_sold, sales_amount

Foreign keys from all dimension tables

DIMENSION TABLES:

dim_customer

dim_product

dim_store

dim_date

All dimension tables use surrogate keys to improve performance and maintain historical data.

ETL PROCESS:
EXTRACT: Data loaded from OLTP/CSV sources using Python

TRANSFORM:

Data cleaning

duplication

Validation

LOAD:

Raw data → Staging

Cleaned data → ODS

Final data → Fact & Dimension tables

ETL was implemented using Python and SQL.


SLOWLY CHANGED DIMENSIONS (SCD)

SCD Type 1: Used for overwriting incorrect data

SCD Type 2: Used to track historical changes in customer and product attributes

This ensures accurate historical analysis.


ANALYSTICS & INSIGHT:
Using optimized SQL queries, the following insights were generated:

Total and monthly revenue trends

Top-selling products

Region-wise and store-wise sales performance

Customer purchase behavior analysis




