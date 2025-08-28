

With my_cte AS (
Select 
Extract (Year From order_date) as order_year,
DATE_TRUNC('month', order_date)::Date AS order_month_date,
To_char(order_date,'mon') as order_month,
SUM(sales_amount) as total_sales,
	

COUNT(DISTINCT customer_key) AS total_customer,
Sum(quantity) as total_Quantity
From gold.fact_sales
Where order_date is not Null 
Group by order_year, order_month, order_month_date
Order by order_year, order_month

)
Select order_year,order_month,total_sales,total_customer,total_Quantity from my_cte
Order by order_month_date



