-- SQL for Everyone: From Zero to Confident
-- Chapter 9: Window Functions
-- Lesson 9.5: LAG and LEAD
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/lag-and-lead/

-- Window function lag, lead, Join orders and order_items and m
WITH m AS (
  SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY 1
)
SELECT month, revenue,
       LAG(revenue)  OVER (ORDER BY month) AS prev_month,
       LEAD(revenue) OVER (ORDER BY month) AS next_month
FROM m ORDER BY month LIMIT 4;

-- Window function lag, Join orders and order_items and m
WITH m AS (
  SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY 1
), x AS (
  SELECT month, revenue,
         ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month), 1) AS pct_change
  FROM m
)
SELECT month, revenue, pct_change FROM x
WHERE pct_change IS NOT NULL
ORDER BY pct_change DESC LIMIT 2;

-- Window function lag, Join orders and order_items and m
WITH m AS (
  SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY 1
), x AS (
  SELECT month, revenue,
         ROUND(100.0 * (revenue - LAG(revenue, 12) OVER (ORDER BY month)) / LAG(revenue, 12) OVER (ORDER BY month), 1) AS vs_last_year
  FROM m
)
SELECT month, revenue, vs_last_year FROM x
WHERE month IN ('2025-01-01', '2025-12-01')
ORDER BY month;

-- Window function lag
SELECT order_id, order_date::date AS day,
       order_date::date - LAG(order_date::date) OVER (ORDER BY order_date) AS days_since_previous
FROM orders
WHERE customer_id = 1
ORDER BY order_date
LIMIT 3;
