----Cumulative Analysis----
-----Calculate the total sales per month and running total of sales over time----


select
* , 
SUM(total_sales) over( order by order_date) as running_total_sales,
avg(avg_price) over( order by order_date) as moving_average_price
from
(
	select 
	DATETRUNC(YEAR,order_date) as order_date, 
	sum(sales_amount) as total_sales,
	avg(price) as avg_price
	from [gold.fact_sales]
	where order_date is not null
	group by DATETRUNC(YEAR , order_date)
	
)t