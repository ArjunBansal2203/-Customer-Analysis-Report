/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/



Create view gold.report_customers as 
-- Base Query: Retrieves core columns from tables
With base_query as (
Select 
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
customer_number,
concat(c.first_name,' ',c.last_name) as customer_name,
c.country,
c.birthdate,
EXTRACT(YEAR FROM AGE( current_date,c.birthdate)) as age
   
from gold.fact_sales as f
Left JOIN gold.dim_customers as c
on c.customer_key = f.customer_key 
Where order_date is not Null
),
-- Customer Aggregation: summarizes key metrics at the current level
customer_aggregation as (
Select 
customer_key,
customer_name,
customer_number,
age,
Count(Distinct order_number) as total_orders,
Sum(sales_amount) as total_sales,
Sum(quantity) as total_qualtity,
Count(Distinct product_key) as total_products,
EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12 +
    EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS months_diff,
MAX(order_date) As Last_order


From base_query
Group by customer_key,customer_name,customer_number,age
)
Select
customer_key,
customer_name,
customer_number,
age,
Case when age <20 then 'under age'
	 when age Between 20 AND 29 then '20-29'
	 when age Between 30 AND 39 then '30-39'
	 when age Between 40 AND 49 then '40-49'
	 else '50 and above'
End as age_group,
Case When total_sales >5000 AND months_diff >= 12 then 'VIP'
	 When total_sales <= 5000 AND months_diff >= 12 then 'Regular'
	 else 'new'
End as Grouping_customers,
total_orders,
total_sales,
total_qualtity,
total_products,
months_diff,
Last_order,
EXTRACT(YEAR FROM AGE( current_date,Last_order)) as recency,
Case When total_orders = 0 then 0
else total_sales / total_orders
End as avg_order_val,
--Computing average order value (AVD)

Case When months_diff = 0 then total_sales
else total_sales /months_diff
END as avg_monthy_spend
From customer_aggregation
-- Group by Grouping_customers

