
----Measure Exploration-----

---Find Total sales
select sum(sales_amount) as Total_sales from [gold.fact_sales];

---Find how many items are sold
select sum(quantity) as Total_quantity from [gold.fact_sales];


---Find the average selling price
select avg(price) as Avg_price from	[gold.fact_sales];

---Find the total no of orders
select count(order_number) as Total_orders from [gold.fact_sales];
select count(distinct order_number) as DistinctTotal_orders from [gold.fact_sales];

---Find the total no of products
select count(product_name) as total_products from [gold.dim_products];
select count(distinct product_name) as total_products from [gold.dim_products];

---Find the total no of customers
select count(customer_key) as total_customers from [gold.dim_customers];
select count(distinct customer_key) as total_customers from [gold.dim_customers];

---Find the total no of customers that have placed the order
select count(distinct customer_key) as total_customers from [gold.fact_sales];


------Generate a report that shows all key matrics of the business

select 'Total Sales' as measure_name, sum(sales_amount) as measure_value from [gold.fact_sales]
union all
select 'Total Quantity' , sum(quantity) from [gold.fact_sales]
union all
select 'Average Price' , avg(price) from [gold.fact_sales]
union all
select 'Total Nr. Orders' , count(distinct order_number) from [gold.fact_sales]
union all
select 'Total Nr. Products' , count(product_name)  from [gold.dim_products]
union all
select 'Total Nr. Customers' , count(customer_key)  from [gold.dim_customers]
union all
select 'Nr. Of customers placed order', count(distinct customer_key) from [gold.fact_sales]






