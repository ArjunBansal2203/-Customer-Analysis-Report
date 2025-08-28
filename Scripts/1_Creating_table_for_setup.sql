-- 2. Create the 'gold' schema
CREATE SCHEMA gold;

-- 3. Create tables
CREATE TABLE gold.dim_customers (
	customer_key INTEGER,
	customer_id INTEGER,
	customer_number VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	country VARCHAR(50),
	marital_status VARCHAR(50),
	gender VARCHAR(50),
	birthdate DATE,
	create_date DATE
);

CREATE TABLE gold.dim_products (
	product_key INTEGER,
	product_id INTEGER,
	product_number VARCHAR(50),
	product_name VARCHAR(50),
	category_id VARCHAR(50),
	category VARCHAR(50),
	subcategory VARCHAR(50),
	maintenance VARCHAR(50),
	cost INTEGER,
	product_line VARCHAR(50),
	start_date DATE
);

CREATE TABLE gold.fact_sales (
	order_number VARCHAR(50),
	product_key INTEGER,
	customer_key INTEGER,
	order_date DATE,
	shipping_date DATE,
	due_date DATE,
	sales_amount INTEGER,
	quantity SMALLINT,
	price INTEGER
);
