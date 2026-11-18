-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.13: Joins Challenge
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/joins-challenge/

-- Join customers and orders and order_items
SELECT c.first_name, c.last_name, ROUND(SUM(oi.quantity * oi.unit_price)) AS spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY spent DESC
LIMIT 3;

-- A query with NOT EXISTS
SELECT COUNT(*) AS never_sold
FROM products p
WHERE NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.product_id = p.product_id);

-- Join orders and order_items
SELECT channel, COUNT(DISTINCT o.order_id) AS orders
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY channel
ORDER BY orders DESC;

-- A query with EXISTS
SELECT c.country, COUNT(*) AS customers_with_orders
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id)
GROUP BY c.country
ORDER BY customers_with_orders DESC
LIMIT 3;
