-- SQL for Everyone: From Zero to Confident
-- Chapter 10: Views and Reusable SQL
-- Lesson 10.2: Materialized Views
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/materialized-views/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the materialized view monthly_revenue
CREATE MATERIALIZED VIEW monthly_revenue AS
SELECT date_trunc('month', o.order_date)::date AS month,
       ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY 1;

-- Query monthly_revenue
SELECT * FROM monthly_revenue ORDER BY month DESC LIMIT 2;

-- Update rows in order_items
UPDATE order_items SET quantity = quantity + 100
WHERE order_item_id = (
  SELECT MAX(oi.order_item_id) FROM order_items oi
  JOIN orders o ON o.order_id = oi.order_id
  WHERE o.order_date >= '2025-12-01');

-- Join monthly_revenue and orders and order_items, UNION ALL of two queries
SELECT 'stored copy' AS source, revenue FROM monthly_revenue WHERE month = '2025-12-01'
UNION ALL
SELECT 'live query', ROUND(SUM(oi.quantity * oi.unit_price))
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_date >= '2025-12-01';

-- Refresh the materialized view monthly_revenue
REFRESH MATERIALIZED VIEW monthly_revenue;

-- Query monthly_revenue
SELECT * FROM monthly_revenue ORDER BY month DESC LIMIT 1;

-- Create an index on monthly_revenue
CREATE UNIQUE INDEX ON monthly_revenue (month);
REFRESH MATERIALIZED VIEW CONCURRENTLY monthly_revenue;

-- A psql command
\dm
