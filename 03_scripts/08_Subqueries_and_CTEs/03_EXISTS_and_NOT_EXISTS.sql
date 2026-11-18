-- SQL for Everyone: From Zero to Confident
-- Chapter 8: Subqueries and CTEs
-- Lesson 8.3: EXISTS and NOT EXISTS
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/exists-and-not-exists/

-- A query with EXISTS
SELECT COUNT(*) AS with_refund
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id AND o.status = 'refunded');

-- A query with NOT EXISTS
SELECT COUNT(*) AS no_completed_order
FROM customers c
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id AND o.status = 'completed');

-- A query with NOT EXISTS
SELECT COUNT(*) AS app_but_never_store
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id AND o.channel = 'app')
  AND NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id AND o.channel = 'store');

-- Join customers and products and orders, A query with NOT EXISTS
SELECT COUNT(*) AS bought_every_category
FROM customers c
WHERE NOT EXISTS (
  SELECT 1 FROM (SELECT DISTINCT category FROM products) cat
  WHERE NOT EXISTS (
    SELECT 1 FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    JOIN products p ON p.product_id = oi.product_id
    WHERE o.customer_id = c.customer_id AND p.category = cat.category));

-- A query with EXISTS
SELECT EXISTS (SELECT 1 FROM orders WHERE status = 'refunded') AS any_refund,
       EXISTS (SELECT 1 FROM orders WHERE order_id < 0) AS impossible;

-- A subquery on customers
SELECT COUNT(*) AS not_in_trap
FROM customers
WHERE customer_id NOT IN (SELECT NULL::int);
