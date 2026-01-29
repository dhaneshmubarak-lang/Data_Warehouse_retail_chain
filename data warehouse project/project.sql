create database retail_dw;
use retail_dw;
show databases;

create table stg_customer(customer_id int,customer_name varchar(100),gender varchar(100),city varchar(100));
select * from stg_customer;
select count(*) from stg_customer;
select * from stg_customer limit 10;


create table stg_product(product_id int,product_name varchar(100),category varchar(100),price int);
select * from stg_product;
select count(*) from stg_product;


create table stg_stores(store_id int,store_name varchar(100),city varchar(50),region varchar(100));
select count(*) from stg_stores;
select * from stg_stores;

drop table stg_sales;
create table stg_sales(sales_id int,customer_id int,product_id int,store_id int,
sale_date date,quantity int);
select * from stg_sales;
select count(*) from stg_sales;


create table ods_customer(customer_id int,customer_name varchar(100),gender varchar(100),city varchar(100));

insert into ods_customer select distinct customer_id,customer_name,gender,city from stg_customer
where customer_id is not null;
select * from ods_customer;
select distinct(gender) from stg_customer;

create table ods_product(product_id int,product_name varchar(100),category varchar(50),price int);

insert into ods_product select distinct product_id,product_name,category,price from stg_product
where product_id is not null;
select * from ods_product;

create table ods_stores(store_id int,store_name varchar(100),city varchar(50),region varchar(100));

insert into ods_stores select distinct store_id,store_name,city,region from stg_stores where store_id is not null;
select * from ods_stores;

create table ods_sales(sales_id int,customer_id int,product_id int,store_id int,sale_date date,quantity int);
insert into ods_sales 
select distinct sale_id,customer_id,product_id,store_id,sale_date,quantity from stg_sales where sale_id is not null;
select * from ods_sales;


create table dim_customer(customer_key int auto_increment primary key,customer_id int,customer_name varchar(100),
gender varchar(100),city varchar(100));

insert into dim_customer(customer_id,customer_name,gender,city)
select
customer_id,customer_name,gender,city 
from ods_customer;
select * from dim_customer;

create table dim_product(product_key int auto_increment primary key,
product_id int,product_name varchar(100),category varchar(100),price int);

insert into dim_product(product_id,product_name,category,price)
select
product_id,product_name,category,price from ods_product;

select * from dim_product;

drop table dim_stores;
create table dim_stores(store_key int auto_increment primary key ,store_id int,store_name varchar(100),city varchar(50),region varchar(100));
insert into dim_stores(store_id,store_name,city,region)
select store_id,store_name,city,region from ods_stores;

select count(*) dim_stores;
select * from dim_stores;



create table dim_sales(sales_id int,customer_id int,product_id int,store_id int,sale_date date,quantity int);
insert into dim_sales(sales_id,customer_id,product_id,store_id,sale_date,quantity)
select sales_id,customer_id,product_id,store_id,sale_date,quantity from ods_sales;

create table dim_date (date_key int auto_increment primary key,full_date date,day int,month int,year int,quarter int);
insert into dim_date (full_date, day, month, year, quarter) select distinct sale_date,day(sale_date),month(sale_date),
year(sale_date),quarter(sale_date) from ods_sales;
select * from dim_date;

select * from dim_sales;
drop table fact_sales;
create table fact_sales(sales_key int auto_increment primary key,date_key int,product_key int,customer_key int,
store_key int,quantity_sold int);

insert into fact_sales(date_key, product_key,customer_key,store_key,quantity_sold)
select d.date_key,p.product_key,c.customer_key,s.store_key,o.quantity
from ods_sales o
join dim_date d on o.sale_date = d.full_date
join dim_product p on o.product_id = p.product_id
join dim_customer c on o.customer_id = c.customer_id
join dim_stores s on o.store_id = s.store_id;
select * from fact_sales;

select count(*) from fact_sales;

select sum(sales_amount) as total_revenue from fact_sales;

select p.product_name,sum(f.quantity_sold) AS total_quantity
from fact_sales f
join dim_product p on f.product_key = p.product_key
group by p.product_name
order by total_quantity desc
limit 5;

select o.sales_id,o.customer_id,o.product_id,o.store_id,o.sale_date,o.quantity,p.price,
    (coalesce (o.quantity, 1) * p.price) AS sales_amount
from ods_sales o
join dim_product p
    on o.product_id = p.product_id
order by o.sales_id;

select product_id, price from dim_product;

