-- Segment products into cost ranges and count how many 
-- products fall into each segment
With product_cost_segmentation as (
Select 
product_key,
product_name,
cost  ,
Case When cost < 100 then 'Below 100'
	When cost BETWEEN 100 AND 500 then '100-500'
	when cost between 500 and 1000 then '500-1000'
	else 'Above 1000'
End Cost_range
From gold.dim_products
)
Select
cost_range, Count(product_name)as total_products
From product_cost_segmentation
Group by cost_range
Order by total_products DESC