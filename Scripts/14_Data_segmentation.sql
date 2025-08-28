-- Grouping customes into new segments based on their spending behavior 4
-- -VIP: Customers with at least 12 months of history and spending more than €5,000. 
-- -Regular: Customers with at least 12 months of history and spending equal or less than €5,000. 
-- -New: Customers with lifespan of less than 12 months.
-- And find total no. of customers each group.
With customer_spending as (
Select
c.customer_key,
Sum(f.sales_amount) as total_spending,
  
Min (order_date )as first_order,
Max (order_date )as last_order,
EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12 +
    EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS months_diff
From gold.fact_sales as f
Left Join gold.dim_customers as c
on f.customer_key = c.customer_key
Group by c.customer_key
)
Select 

Case When total_spending >5000 AND months_diff >= 12 then 'VIP'
	 When total_spending <= 5000 AND months_diff >= 12 then 'Regular'
	 else 'new'
End Grouping_customers,
Count(customer_key) as number_of_customers
From customer_spending
Group by Grouping_customers
order by number_of_customers Desc