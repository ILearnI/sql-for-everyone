-- SQL for Everyone: From Zero to Confident
-- Chapter 13: Project: Brewhouse Sales Analysis
-- Lesson 13.3: Part 2: Customers
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/part-2-customers/

-- New and returning customers by month
WITH o AS (
  SELECT date_trunc('month', order_date)::date AS month,
         ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date, order_id) AS nth
  FROM orders WHERE status = 'completed'
)
SELECT month, COUNT(*) FILTER (WHERE nth = 1) AS first_orders, COUNT(*) FILTER (WHERE nth > 1) AS returning_orders
FROM o GROUP BY month ORDER BY month DESC LIMIT 3;

-- The top customers by spend
SELECT c.first_name, c.last_name, ROUND(SUM(oi.quantity * oi.unit_price)) AS spent, COUNT(DISTINCT o.order_id) AS orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY spent DESC
LIMIT 3;

-- Customers with no order for 90 days
SELECT COUNT(*) AS quiet_customers
FROM (
  SELECT customer_id FROM orders WHERE status = 'completed'
  GROUP BY customer_id
  HAVING MAX(order_date) < DATE '2025-12-31' - INTERVAL '90 days'
) q;

-- Customers grouped into spend tiers
WITH t AS (
  SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS spent
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status = 'completed' GROUP BY o.customer_id
)
SELECT CASE WHEN spent >= 1000 THEN 'gold' WHEN spent >= 300 THEN 'silver' ELSE 'bronze' END AS tier,
       COUNT(*) AS customers, ROUND(SUM(spent)) AS revenue,
       ROUND(100.0 * SUM(spent) / SUM(SUM(spent)) OVER (), 1) AS pct_of_revenue
FROM t GROUP BY 1 ORDER BY revenue DESC;

-- How many bought once, and how many came back
WITH c AS (SELECT customer_id, COUNT(*) AS n FROM orders WHERE status = 'completed' GROUP BY customer_id)
SELECT COUNT(*) FILTER (WHERE n = 1) AS bought_once, COUNT(*) FILTER (WHERE n > 1) AS repeat_customers, COUNT(*) AS buyers FROM c;
