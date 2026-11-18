-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.12: Join Fan-Out: Why Totals Double
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/join-fan-out-why-totals-double/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Query orders
SELECT COUNT(*) AS orders FROM orders;

-- Join orders and order_items
SELECT COUNT(*) AS joined_rows FROM orders o JOIN order_items oi ON oi.order_id = o.order_id;

-- Join orders and order_items
SELECT o.order_id, oi.order_item_id
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_id = 1
ORDER BY oi.order_item_id;

-- Join customers and orders and order_items
SELECT c.city, COUNT(*) AS counted, COUNT(DISTINCT o.order_id) AS real_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.city
ORDER BY counted DESC
LIMIT 3;

-- Create the table order_fees from a query
CREATE TABLE order_fees AS SELECT order_id, 5.00::numeric AS fee FROM orders;

-- Query order_fees
SELECT ROUND(SUM(fee)) AS true_fees FROM order_fees;

-- Join order_fees and order_items
SELECT ROUND(SUM(f.fee)) AS inflated_fees
FROM order_fees f
JOIN order_items oi ON oi.order_id = f.order_id;

-- Join order_items and per_order and order_fees, A CTE
WITH per_order AS (
  SELECT order_id, SUM(quantity * unit_price) AS total
  FROM order_items GROUP BY order_id
)
SELECT ROUND(SUM(po.total)) AS revenue, ROUND(SUM(f.fee)) AS fees
FROM per_order po
JOIN order_fees f ON f.order_id = po.order_id;

-- Drop the table order_fees
DROP TABLE order_fees;
