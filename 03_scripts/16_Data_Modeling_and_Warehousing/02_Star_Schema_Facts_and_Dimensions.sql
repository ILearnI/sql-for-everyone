-- SQL for Everyone: From Zero to Confident
-- Chapter 16: Data Modeling and Warehousing
-- Lesson 16.2: Star Schema: Facts and Dimensions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/star-schema-facts-and-dimensions/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- The grain: one row per order line
SELECT COUNT(*) AS grain_rows_one_per_order_line FROM order_items;

-- A dimension table for products
CREATE TABLE dim_product AS
SELECT product_id AS product_key, name AS product, category, is_active FROM products;

-- The fact table: one row per order line, with keys
CREATE TABLE fact_sales AS
SELECT oi.order_item_id AS sales_key, o.customer_id AS customer_key, oi.product_id AS product_key,
       o.order_date::date AS date_key, o.channel, o.status,
       oi.quantity, oi.unit_price, oi.quantity * oi.unit_price AS revenue
FROM order_items oi JOIN orders o ON o.order_id = oi.order_id;

-- A star query: the facts joined to a dimension
SELECT d.category, f.channel, ROUND(SUM(f.revenue)) AS revenue
FROM fact_sales f JOIN dim_product d ON d.product_key = f.product_key
WHERE f.status = 'completed'
GROUP BY d.category, f.channel
ORDER BY revenue DESC LIMIT 4;

-- Check: the fact total equals the source total
SELECT (SELECT ROUND(SUM(revenue)) FROM fact_sales) AS star_total,
       (SELECT ROUND(SUM(quantity * unit_price)) FROM order_items) AS source_total;
