-- Which 5 products Generating the Highest Revenue?

SELECT 
p.product_name,
SUM(f.sales_amount) AS total_revenue,
RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue Desc
LIMIT 5;

-- What are the 5 worst-performing products(last 5 ranked prducts) in terms of sales?
SELECT 
p.product_name,
SUM(f.sales_amount) AS total_revenue,
RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue 
LIMIT 5;

-- Find the top 10 customers who have generated the highest revenue
SELECT 
c.customer_key,
Concat(c.first_name,' ',c.last_name) as customer_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
customer_name
ORDER BY total_revenue DESC
LIMIT 10;

-- The 3 customers with the fewest orders placed
SELECT
c.customer_key,
Concat(c.first_name,' ',c.last_name) as customer_name,
COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
customer_name
ORDER BY total_orders 
LIMIT 3;

-- The 3 customers with the highest orders placed
SELECT
c.customer_key,
Concat(c.first_name,' ',c.last_name) as customer_name,
COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
customer_name
ORDER BY total_orders DESC
LIMIT 3;