-- SQL for Everyone: From Zero to Confident
-- Chapter 16: Data Modeling and Warehousing
-- Lesson 16.5: Denormalisation and When to Break the Rules
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/denormalisation-and-when-to-break-the-rules/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- A wide table: everything joined into one
CREATE TABLE wide_sales AS
SELECT oi.order_item_id AS sales_key, o.order_date::date AS full_date,
       EXTRACT(year FROM o.order_date)::int AS year, EXTRACT(quarter FROM o.order_date)::int AS quarter, EXTRACT(month FROM o.order_date)::int AS month,
       c.first_name || ' ' || c.last_name AS customer, c.city, c.country,
       p.name AS product, p.category, o.channel, o.status,
       oi.quantity, oi.unit_price, oi.quantity * oi.unit_price AS revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = oi.product_id;

-- Its size against order_items
SELECT COUNT(*) AS rows, pg_size_pretty(pg_total_relation_size('wide_sales')) AS wide_table_size,
       pg_size_pretty(pg_total_relation_size('order_items')) AS order_items_size FROM wide_sales;

-- A report on the wide table: no joins
SELECT year, quarter, category, ROUND(SUM(revenue)) AS revenue
FROM wide_sales WHERE status = 'completed'
GROUP BY year, quarter, category ORDER BY revenue DESC LIMIT 3;

-- The cost: changing one row leaves the others unchanged
UPDATE wide_sales SET city = 'Portland'
WHERE customer = 'Ava Walker' AND sales_key = (SELECT MIN(sales_key) FROM wide_sales WHERE customer = 'Ava Walker');
SELECT city, COUNT(*) AS rows FROM wide_sales WHERE customer = 'Ava Walker' GROUP BY city ORDER BY rows DESC;

-- A summary table for dashboards
CREATE TABLE monthly_category_summary AS
SELECT year, month, category, ROUND(SUM(revenue)) AS revenue, COUNT(*) AS lines
FROM wide_sales WHERE status = 'completed' GROUP BY year, month, category;

-- How small the summary is
SELECT COUNT(*) AS summary_rows FROM monthly_category_summary;

-- A query on the summary
SELECT category, SUM(revenue) AS revenue_2025 FROM monthly_category_summary WHERE year = 2025 GROUP BY category ORDER BY revenue_2025 DESC LIMIT 2;
