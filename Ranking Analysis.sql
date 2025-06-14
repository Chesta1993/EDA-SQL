
---------RANKING ANALYSIS------
----Which 5 products generate the highest revenue?
select top 5  
p.subcategory , 
sum(f.sales_amount) as total_revenue
from [gold.fact_sales] f
left join [gold.dim_products] p
on f.product_key = p.product_key
group by p.subcategory
order by total_revenue desc;


select 
*
from 
(   select 
	p.product_name , 
	sum(f.sales_amount) as total_revenue,
	ROW_NUMBER() over(order by sum(f.sales_amount) desc) as Rank_products
	from [gold.fact_sales] f
	left join [gold.dim_products] p
	on f.product_key = p.product_key
	group by p.product_name
)t
where Rank_products <=5;

----What are the 5 worst performing products in terms of sales?
select top 5  
p.product_name , 
sum(f.sales_amount) as total_revenue
from [gold.fact_sales] f
left join [gold.dim_products] p
on f.product_key = p.product_key
group by p.product_name
order by total_revenue ;

---Find the top 10 customers who have genrated the highest revenue
select top 10  
c.customer_key, 
c.first_name,
c.last_name,
sum(f.sales_amount) as total_revenue
from [gold.fact_sales] f
left join [gold.dim_customers] c
on f.customer_key = c.customer_key
group by c.customer_key, 
         c.first_name,
         c.last_name
order by total_revenue desc;

----The 3 customers with the fewest orders placed
select  top 3
c.customer_key, 
c.first_name,
c.last_name,
COUNT(distinct order_number) as total_orders_placed
from [gold.fact_sales] f
left join [gold.dim_customers] c
on c.customer_key = f.customer_key
group by c.customer_key, 
         c.first_name,
         c.last_name
order by total_orders_placed ;
