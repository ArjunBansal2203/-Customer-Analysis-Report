-- Which category contribite the most to overall sales?
With category_sales as (
Select 
p.category,
SUM(sales_amount) as total_sales
From gold.fact_sales as f
Left Join gold.dim_products as p
On p.product_key = f.product_key
Group by p.category
)
Select 
category,total_sales,
SUM(total_sales) Over() as overall_sales,

Concat(Round(total_sales / SUM(total_sales) Over() * 100,2),'%') as percentage_sales
From category_sales
Order by Total_sales Desc