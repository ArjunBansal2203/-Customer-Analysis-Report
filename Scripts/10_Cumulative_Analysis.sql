-- Running Sales Time Analysis
-- This SQL script calculates running total of sales, prices and averages of them grouped by year.

With my_cte AS (
Select 
DATE_TRUNC('year', order_date)::Date AS order_year_date,

SUM(sales_amount)as total_Sales,
COUNT(DISTINCT customer_key) AS total_customer,
Sum(quantity) as total_Quantity,
Avg(price) as avg_p

From gold.fact_sales
Where order_date is not Null 
Group by  order_year_date

)
Select order_year_date,total_sales,
SUM(Total_sales) OVER (Order by order_year_date)as running_total_sales,
avg_p,AVG(avg_p) OVER (Order by order_year_date)as running_avg_price,total_customer,
total_Quantity from my_cte
Order by order_year_date




