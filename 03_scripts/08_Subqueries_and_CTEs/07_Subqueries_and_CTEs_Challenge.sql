-- SQL for Everyone: From Zero to Confident
-- Chapter 8: Subqueries and CTEs
-- Lesson 8.7: Subqueries and CTEs Challenge
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/subqueries-and-ctes-challenge/

-- A subquery on products
SELECT name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price
LIMIT 2;

-- Join orders and order_items and per_customer, A CTE
WITH per_customer AS (
  SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS spent
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.customer_id
)
SELECT COUNT(*) AS above_average_customers
FROM per_customer
WHERE spent > (SELECT AVG(spent) FROM per_customer);

-- A query with NOT EXISTS
SELECT c.first_name, c.last_name
FROM customers c
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id)
ORDER BY c.customer_id
LIMIT 2;

-- A recursive query
WITH RECURSIVE chain AS (
  SELECT employee_id, 1 AS depth FROM employees WHERE manager_id IS NULL
  UNION ALL
  SELECT e.employee_id, c.depth + 1
  FROM employees e JOIN chain c ON e.manager_id = c.employee_id
)
SELECT MAX(depth) AS levels FROM chain;
