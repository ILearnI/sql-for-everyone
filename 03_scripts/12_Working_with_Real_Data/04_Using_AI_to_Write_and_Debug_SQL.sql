-- SQL for Everyone: From Zero to Confident
-- Chapter 12: Working with Real Data
-- Lesson 12.4: Using AI to Write and Debug SQL
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/using-ai-to-write-and-debug-sql/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- DATEDIFF is not PostgreSQL: this fails on purpose
SELECT DATEDIFF('day', MIN(order_date), MAX(order_date)) FROM orders;

-- The PostgreSQL way: subtract the dates
SELECT MAX(order_date)::date - MIN(order_date)::date AS days_covered FROM orders;

-- A column that does not exist (total): this fails on purpose
SELECT total FROM orders LIMIT 1;

-- The average order line, not the average order
SELECT ROUND(AVG(quantity * unit_price), 2) AS average_order_line FROM order_items;

-- The average order value: sum per order, then average
SELECT ROUND(AVG(t), 2) AS average_order
FROM (SELECT SUM(quantity * unit_price) AS t FROM order_items GROUP BY order_id) x;

-- Revenue of the completed orders
SELECT ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue_completed
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed';

-- A destructive UPDATE, tried inside a transaction
BEGIN;
UPDATE products SET price = 0 WHERE category = 'Tea';
SELECT COUNT(*) AS free_tea_inside FROM products WHERE price = 0;
ROLLBACK;

-- After the ROLLBACK nothing has changed
SELECT COUNT(*) AS free_tea_after FROM products WHERE price = 0;
