----Change-over-Time analysis----
----Trend Analysis------

---Analyze sales performance over time---
----Year wise--------
select 
year(order_date) as order_year,
month(order_date) as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold.fact_sales]
where order_date is not null
group by year(order_date), month(order_date)
order by order_year , order_month

---------------------------------------------------
select 
datetrunc(month, order_date) as order_date,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold.fact_sales]
where order_date is not null
group by datetrunc(month , order_date)
order by order_date

-------------------------------------------
select 
FORMAT(order_date, 'yyyy-MMM') as order_date,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold.fact_sales]
where order_date is not null
group by FORMAT(order_date , 'yyyy-MMM')
order by order_date
