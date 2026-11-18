-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.2: INNER JOIN
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/inner-join/

-- customer_id is in both tables, so the name is ambiguous
SELECT customer_id, first_name FROM orders JOIN customers ON orders.customer_id = customers.customer_id LIMIT 1;

-- Join orders and customers
SELECT o.order_id, o.order_date::date AS day, c.first_name, c.city
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_id
LIMIT 4;

-- Join orders and customers
SELECT o.order_id, c.first_name
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE c.country = 'Japan'
ORDER BY o.order_id
LIMIT 3;

-- Join orders and customers
SELECT c.city, COUNT(*) AS orders
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY orders DESC
LIMIT 3;

-- A query with EXISTS
SELECT COUNT(*) AS customers_with_orders
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id);

-- Query customers
SELECT COUNT(*) AS customers FROM customers;
