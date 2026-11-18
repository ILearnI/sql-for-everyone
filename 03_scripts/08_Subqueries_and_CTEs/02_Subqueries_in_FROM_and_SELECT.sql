-- SQL for Everyone: From Zero to Confident
-- Chapter 8: Subqueries and CTEs
-- Lesson 8.2: Subqueries in FROM and SELECT
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/subqueries-in-from-and-select/

-- Join orders and order_items and customers
SELECT c.first_name, t.spent
FROM (
  SELECT o.customer_id, ROUND(SUM(oi.quantity * oi.unit_price)) AS spent
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.customer_id
) AS t
JOIN customers c ON c.customer_id = t.customer_id
ORDER BY t.spent DESC
LIMIT 3;

-- Join orders and order_items
SELECT ROUND(AVG(spent), 2) AS average_customer_spend
FROM (
  SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS spent
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.customer_id
) AS t;

-- Join products
SELECT p.name, p.price, c.avg_cat
FROM products p
JOIN (SELECT category, ROUND(AVG(price), 2) AS avg_cat FROM products GROUP BY category) c
  ON c.category = p.category
WHERE p.price > c.avg_cat
ORDER BY p.price DESC
LIMIT 3;

-- A subquery on products
SELECT name, price,
       (SELECT ROUND(AVG(price), 2) FROM products) AS avg_price,
       ROUND(price - (SELECT AVG(price) FROM products), 2) AS diff
FROM products
ORDER BY price DESC
LIMIT 3;

-- A subquery on orders
SELECT c.first_name,
       (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) AS orders
FROM customers c
ORDER BY orders DESC, c.customer_id
LIMIT 3;
