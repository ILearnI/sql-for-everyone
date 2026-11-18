-- SQL for Everyone: From Zero to Confident
-- Chapter 9: Window Functions
-- Lesson 9.9: Window Functions Challenge
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/window-functions-challenge/

-- Window function rank, Join customers and orders and order_items
SELECT first_name, last_name, ROUND(spent) AS spent, RANK() OVER (ORDER BY spent DESC) AS rank
FROM (
  SELECT c.first_name, c.last_name, SUM(oi.quantity * oi.unit_price) AS spent
  FROM customers c
  JOIN orders o ON o.customer_id = c.customer_id
  JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status = 'completed'
  GROUP BY c.customer_id, c.first_name, c.last_name
) t
ORDER BY spent DESC
LIMIT 3;

-- Window function row_number
SELECT category, name, price
FROM (
  SELECT category, name, price,
         ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) AS rn
  FROM products
) t
WHERE rn = 1
ORDER BY category;

-- Window function lag, Join orders and order_items and m
WITH m AS (
  SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY 1
)
SELECT month, revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month), 1) AS pct_change
FROM m
ORDER BY pct_change DESC NULLS LAST
LIMIT 1;

-- Window function lag, Join orders and order_items and m
WITH m AS (
  SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY 1
), x AS (
  SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev FROM m
)
SELECT COUNT(*) FILTER (WHERE revenue > prev) AS growth_months,
       COUNT(*) FILTER (WHERE revenue < prev) AS drop_months
FROM x;
