
-----------DATE EXPLORATION-------

---Find The Date of the first and last order
----How many years of sales are available


select
	min(order_date) as First_OrderDate,
    max(order_date) as Last_OrderDate,
	DATEDIFF(MONTH,min(order_date),max(order_date)) as Order_range_months
from [gold.fact_sales];


---Find the youngest and oldest customer

select 
	min(birthdate) as oldest_birthdate,
	DATEDIFF(YEAR , MIN(birthdate),getdate()) as oldest_age,
	max(birthdate) as youngest_birthdate,
	DATEDIFF(YEAR , Max(birthdate),getdate()) as youngest_age
from [gold.dim_customers];
