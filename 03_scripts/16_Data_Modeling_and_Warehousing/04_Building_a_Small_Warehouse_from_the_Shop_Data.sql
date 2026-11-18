-- SQL for Everyone: From Zero to Confident
-- Chapter 16: Data Modeling and Warehousing
-- Lesson 16.4: Building a Small Warehouse from the Shop Data
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/building-a-small-warehouse-from-the-shop-data/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Generate the date dimension
CREATE TABLE dim_date AS
SELECT to_char(d, 'YYYYMMDD')::int AS date_key, d::date AS full_date,
       EXTRACT(year FROM d)::int AS year, EXTRACT(quarter FROM d)::int AS quarter, EXTRACT(month FROM d)::int AS month,
       to_char(d, 'FMMonth') AS month_name, to_char(d, 'Dy') AS weekday, EXTRACT(isodow FROM d) IN (6, 7) AS is_weekend
FROM generate_series(DATE '2024-01-01', DATE '2026-12-31', INTERVAL '1 day') d;
ALTER TABLE dim_date ADD PRIMARY KEY (date_key);

-- Check the date dimension
SELECT COUNT(*) AS days, MIN(full_date) AS first_day, MAX(full_date) AS last_day, COUNT(*) FILTER (WHERE is_weekend) AS weekend_days FROM dim_date;

-- The customer dimension with a surrogate key
CREATE TABLE dim_customer AS
SELECT ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key, customer_id, first_name || ' ' || last_name AS name, city, country FROM customers;
CREATE TABLE dim_product AS
SELECT ROW_NUMBER() OVER (ORDER BY product_id) AS product_key, product_id, name, category FROM products;
ALTER TABLE dim_customer ADD PRIMARY KEY (customer_key);
ALTER TABLE dim_product ADD PRIMARY KEY (product_key);

-- The fact table
CREATE TABLE fact_sales AS
SELECT oi.order_item_id AS sales_key, dc.customer_key, dp.product_key, to_char(o.order_date, 'YYYYMMDD')::int AS date_key,
       o.channel, o.status, oi.quantity, oi.unit_price, oi.quantity * oi.unit_price AS revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN dim_customer dc ON dc.customer_id = o.customer_id
JOIN dim_product dp ON dp.product_id = oi.product_id;

-- Add primary and foreign keys
ALTER TABLE fact_sales ADD PRIMARY KEY (sales_key),
  ADD FOREIGN KEY (customer_key) REFERENCES dim_customer,
  ADD FOREIGN KEY (product_key) REFERENCES dim_product,
  ADD FOREIGN KEY (date_key) REFERENCES dim_date;

-- Revenue by year, quarter and category
SELECT d.year, d.quarter, p.category, ROUND(SUM(f.revenue)) AS revenue
FROM fact_sales f JOIN dim_date d ON d.date_key = f.date_key JOIN dim_product p ON p.product_key = f.product_key
WHERE f.status = 'completed'
GROUP BY d.year, d.quarter, p.category ORDER BY revenue DESC LIMIT 3;

-- Weekend against weekday revenue
SELECT d.is_weekend, ROUND(SUM(f.revenue)) AS revenue, COUNT(DISTINCT d.full_date) AS days, ROUND(SUM(f.revenue) / COUNT(DISTINCT d.full_date)) AS per_day
FROM fact_sales f JOIN dim_date d ON d.date_key = f.date_key
WHERE f.status = 'completed' GROUP BY d.is_weekend;

-- A sale for an unknown customer: refused by the foreign key
INSERT INTO fact_sales VALUES (999999, 99999, 1, 20250101, 'web', 'completed', 1, 1, 1);

-- Reconcile the warehouse with the source
SELECT (SELECT COUNT(*) FROM fact_sales) AS fact_rows, (SELECT COUNT(*) FROM order_items) AS source_rows,
       (SELECT ROUND(SUM(revenue)) FROM fact_sales) AS fact_total, (SELECT ROUND(SUM(quantity * unit_price)) FROM order_items) AS source_total;
