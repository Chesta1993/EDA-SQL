/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
-- =============================================================================
-- Create Report: gold.report_products
-- =============================================================================
create view report_products as
----1) Base Query
with base_query as(
select 
	f.order_number,
	f.order_date,
	f.customer_key,
	f.sales_amount,
	f.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
from [gold.fact_sales] f
left join [gold.dim_products] p
on f.product_key = p.product_key
where order_date is not null -----only consider valid sales data
)

/*---------------------------------------------------------------------------
2) Product Aggregations: Summarizes key metrics at the product level
---------------------------------------------------------------------------*/
,product_aggregation as(
select 
product_key,
product_name,
category,
subcategory,
cost,
DATEDIFF(month , min(order_date),max(order_date)) as lifespan,
MAX(order_date) as last_sales_date,
COUNT(distinct order_number) as total_orders,
COUNT(distinct customer_key) as total_customers,
sum(sales_amount) as total_sales,
sum(quantity) as total_quantity_sold,
round(avg(cast (sales_amount as float)/nullif(quantity,0)),1) as avg_selling_price
from base_query
group by product_key,
		 product_name,
		 category,
		 subcategory,
		 cost)
---3) Final Query : combine all product results into one output
select 
product_key,
product_name,
category,
subcategory,
cost,
last_sales_date,
DATEDIFF(month,last_sales_date,GETDATE()) as recency_in_months,
case
	when total_sales > 50000 then 'High Performer'
	when total_sales >= 10000 then 'Mid Performer'
	else 'Low Performer'
end as product_segment,
lifespan,
total_orders,
total_sales,
total_quantity_sold,
total_customers,
avg_selling_price,
------average order revenue(AOR)
case 
	 when total_orders = 0 then 0
	 else total_sales/total_orders 
end as avg_order_revenue,
------average monthly revenue
case 
	 when lifespan = 0 then total_sales
     else total_sales/lifespan
end as avg_monthly_revenue
from product_aggregation