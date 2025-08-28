-- Analyze the yearly performance of products by comparing their sales to both the average sales 
-- performance of the product and the previous year's sales
With yearly_product_sales as (
Select 
Extract( Year FROM f.order_date) as order_year,
p.product_name,
Cast (Sum(f.sales_amount)as int) as current_sales
From gold.fact_sales as f
Left Join gold.dim_products as p
ON f.product_key = p.product_key
Where order_date is not NULL
Group by order_year,p.product_name
)
Select order_year,product_name,current_sales,
Cast(AVG(current_sales) OVER (Partition BY product_name) as int)as avg_sales,

CAST(Current_sales - AVG(current_sales) OVER (Partition BY product_name) as int)as diff_avg,
Case When Current_sales - AVG(current_sales) OVER (Partition BY product_name) >0 then 'Above average'
	 When Current_sales - AVG(current_sales) OVER (Partition BY product_name) < 0 then 'Below average'
	 else 'avg'
End avg_change,
LAG(current_sales) OVER (Partition by Product_name Order by order_year) as previous_sales,

current_sales - LAG(current_sales) OVER (Partition by Product_name Order by order_year) as previous_year_diff,
Case When Current_sales - LAG(current_sales) OVER (Partition by Product_name Order by order_year) >0 then 'Increase'
	 When Current_sales - LAG(current_sales) OVER (Partition by Product_name Order by order_year) < 0 then 'decrease'
	 else 'No Change'
End previous_change
From yearly_product_sales
ORDER BY product_name,order_year