-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.10: Anti-Joins and Semi-Joins
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/anti-joins-and-semi-joins/

-- LEFT JOIN of customers and orders
SELECT COUNT(*) AS left_join_way
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- A query with NOT EXISTS
SELECT COUNT(*) AS not_exists_way
FROM customers c
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id);

-- A subquery on customers
SELECT COUNT(*) AS not_in_way
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- UNION ALL of two queries
SELECT COUNT(*) AS not_in_with_a_null
FROM customers
WHERE customer_id NOT IN (
  SELECT customer_id FROM orders
  UNION ALL SELECT NULL);

-- A query with EXISTS
SELECT COUNT(*) AS with_orders
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id);

-- Join customers and orders
SELECT COUNT(*) AS joined_rows
FROM customers c JOIN orders o USING (customer_id);

-- A query with EXISTS
SELECT COUNT(*) AS refunded_customers
FROM customers c
WHERE EXISTS (
  SELECT 1 FROM orders o
  WHERE o.customer_id = c.customer_id AND o.status = 'refunded');
