-- Load dim_customers
TRUNCATE TABLE gold.dim_customers;

COPY gold.dim_customers
FROM 'D:\Sql portfolio project\datasets\csv-files\gold.dim_customers.csv'
DELIMITER ','
CSV HEADER;

-- Load dim_products
TRUNCATE TABLE gold.dim_products;

COPY gold.dim_products
FROM 'D:\Sql portfolio project\datasets\csv-files\gold.dim_products.csv'
DELIMITER ','
CSV HEADER;

-- Load fact_sales
TRUNCATE TABLE gold.fact_sales;

COPY gold.fact_sales
FROM 'D:\Sql portfolio project\datasets\csv-files\gold.fact_sales.csv'
DELIMITER ','
CSV HEADER;
