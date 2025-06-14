----Performance analysis-----
----comparing current value with target value

------Analyze the yearly performance of products by comparing each product sales to both its average sale's performnace
------ and the previous year sales


with yearly_product_sales as
(
select 
year(f.order_date) order_year,
p.product_name,
sum(sales_amount) as Current_sales
from [gold.fact_sales] f
left join [gold.dim_products] p
on f.product_key = p.product_key
where order_date is not null
group by YEAR(order_date),
         p.product_name
)
select 
order_year,
product_name,
Current_sales,
AVG(current_sales) over(partition by product_name ) as avg_sales,
Current_sales - AVG(current_sales) over(partition by product_name ) as diff_avg,
case 
     when Current_sales - AVG(current_sales) over(partition by product_name ) >0 then 'Above Avg'
     when Current_sales - AVG(current_sales) over(partition by product_name ) < 0 then 'Below Avg'
	 else 'Avg'
end as avg_change,
--------Year-over-Year analysis-------------------------------------------------
lag(Current_sales) over(partition by product_name order by order_year) as py_sales,
Current_sales - lag(Current_sales) over(partition by product_name order by order_year) as diff_py,
case
    when Current_sales - lag(Current_sales) over(partition by product_name order by order_year) > 0 then 'Increase'
    when Current_sales - lag(Current_sales) over(partition by product_name order by order_year) < 0 then 'Decrease'
	else 'No change'
end as py_change
from yearly_product_sales
order by product_name , order_year