-- SQL for Everyone: From Zero to Confident
-- Chapter 8: Subqueries and CTEs
-- Lesson 8.6: Correlated Subqueries
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/correlated-subqueries/

-- Join orders and order_items and oa, A CTE
WITH oa AS (
  SELECT o.order_id, o.customer_id, SUM(oi.quantity * oi.unit_price) AS total
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.order_id, o.customer_id
)
SELECT COUNT(*) AS above_own_average
FROM oa a
WHERE total > (SELECT AVG(total) FROM oa b WHERE b.customer_id = a.customer_id);

-- A subquery on products
SELECT name, price, category
FROM products p
WHERE price = (SELECT MAX(price) FROM products x WHERE x.category = p.category)
ORDER BY category;

-- A subquery on orders
SELECT c.first_name,
       (SELECT MAX(order_date)::date FROM orders o WHERE o.customer_id = c.customer_id) AS last_order
FROM customers c
WHERE c.customer_id IN (1, 2, 10)
ORDER BY c.customer_id;

-- A subquery on products
SELECT COUNT(*) AS above_category_average
FROM products p
WHERE price > (SELECT AVG(price) FROM products x WHERE x.category = p.category);
