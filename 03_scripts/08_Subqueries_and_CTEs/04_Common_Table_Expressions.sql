-- SQL for Everyone: From Zero to Confident
-- Chapter 8: Subqueries and CTEs
-- Lesson 8.4: Common Table Expressions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/common-table-expressions/

-- Join orders and order_items and per_customer, A CTE
WITH per_customer AS (
  SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS spent
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.customer_id
)
SELECT c.first_name, ROUND(pc.spent) AS spent
FROM per_customer pc
JOIN customers c ON c.customer_id = pc.customer_id
WHERE pc.spent > (SELECT AVG(spent) FROM per_customer)
ORDER BY pc.spent DESC
LIMIT 3;

-- Join orders and order_items and per_customer, A CTE
WITH per_customer AS (
  SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS spent
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.customer_id
)
SELECT COUNT(*) AS above_average
FROM per_customer
WHERE spent > (SELECT AVG(spent) FROM per_customer);

-- A CTE
WITH monthly AS (
  SELECT date_trunc('month', order_date)::date AS month, COUNT(*) AS orders
  FROM orders
  GROUP BY 1
)
SELECT month, orders
FROM monthly
ORDER BY orders DESC
LIMIT 3;

-- A CTE
WITH store_orders AS (
  SELECT * FROM orders WHERE channel = 'store'
)
SELECT COUNT(*) AS store_orders FROM store_orders;
