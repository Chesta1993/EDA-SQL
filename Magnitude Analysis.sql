------------MAGNITUDE ANALYSIS-------
---find total customers by country
select country ,count(customer_key) as total_customers 
from [gold.dim_customers]
group by country
order by total_customers desc;

---find total customers by gender
select gender ,count(customer_key) as total_customers 
from [gold.dim_customers]
group by gender
order by total_customers desc;

---find total products by category
select category ,count(product_key) as total_products
from [gold.dim_products]
group by category
order by total_products desc;

---What is the average cost in each category?
select 
	category ,
	avg(cost) as avg_cost
from [gold.dim_products]
group by category
order by avg_cost desc;

---What is the total revenue generated for each category?
select p.category , SUM(f.sales_amount) as Total_revenue
from [gold.fact_sales] f
left join [gold.dim_products] p
on p.product_key=f.product_key
group by p.category
order by 2 desc;

---Find the total revenue genrated for each customer
select 
c.customer_key,
c.first_name, 
c.last_name, 
SUM(f.sales_amount) as Total_revenue
from [gold.fact_sales] f
left join [gold.dim_customers] c
on f.customer_key=c.customer_key
group by c.customer_key ,
         c.first_name , 
         c.last_name 
order by Total_revenue desc;

---What is the distribution of sold items across countries?
select 
c.country,
sum(f.quantity) as total_sold_items
from [gold.fact_sales] f
left join [gold.dim_customers] c
on f.customer_key = c.customer_key
group by c.country
order by total_sold_items desc;
