-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.3: LEFT JOIN
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/left-join/

-- LEFT JOIN of customers and orders
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE c.customer_id IN (1, 10)
ORDER BY c.customer_id, o.order_id
LIMIT 6;

-- Join customers and orders
SELECT COUNT(*) AS inner_rows FROM customers c JOIN orders o ON o.customer_id = c.customer_id;

-- LEFT JOIN of customers and orders
SELECT COUNT(*) AS left_rows FROM customers c LEFT JOIN orders o ON o.customer_id = c.customer_id;

-- LEFT JOIN of customers and orders
SELECT c.customer_id, c.first_name, c.last_name, c.country
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id
LIMIT 4;

-- LEFT JOIN of customers and orders
SELECT c.country, COUNT(*) AS never_ordered
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL
GROUP BY c.country
ORDER BY never_ordered DESC
LIMIT 3;

-- LEFT JOIN of customers and orders
SELECT c.first_name, COUNT(*) AS wrong, COUNT(o.order_id) AS right_count
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE c.customer_id = 10
GROUP BY c.customer_id, c.first_name;
