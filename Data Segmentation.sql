-----Data Segmentation---------
/* Segement the products into cost ranges
and count how many products fall into each segment*/

with product_category as(
select 
product_key,
product_name,
cost,
case
	when cost < 100 then 'Below 100'
	when cost between 100 and 500 then '100-500'
	when cost between 500 and 1000 then '500-1000'
	else 'Above 1000'
end cost_range
from [gold.dim_products])

select 
cost_range,
COUNT(product_key) as total_products
from product_category
group by cost_range
order by total_products desc



/*Group customers into three segments based on their spending bahaviour
--VIP : customers with atleast 12 months of history and spending more than 5,000
--Regular : customers with atleast 12 months of history but spending  5,000 or less
--New : customers with a lifespan of less than 12 months
And find the total no of customers by each group
*/

with customer_spending as(
select 
c.customer_key , 
sum(f.sales_amount) as total_spendings,
min(order_date) as first_order,
max(order_date) as last_order,
DATEDIFF(MONTH , MIN(order_date),MAX(order_date)) as lifespan
from [gold.fact_sales] f
left join [gold.dim_customers] c
on f.customer_key = c.customer_key
group by c.customer_key)


select 
customer_segment,
COUNT(customer_key) as Total_customers
from
(
	select 
	customer_key,
	total_spendings,
	lifespan,
	case when lifespan >= 12 and total_spendings > 5000 then 'VIP'
		 when lifespan >= 12 and total_spendings <= 5000 then 'Regular'
		 else 'New'
	end customer_segment
	from customer_spending)t 
group by customer_segment
order by Total_customers desc;
