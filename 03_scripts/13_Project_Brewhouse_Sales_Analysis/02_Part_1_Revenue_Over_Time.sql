-- SQL for Everyone: From Zero to Confident
-- Chapter 13: Project: Brewhouse Sales Analysis
-- Lesson 13.2: Part 1: Revenue Over Time
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/part-1-revenue-over-time/

-- Monthly revenue of completed orders
WITH m AS (
  SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status = 'completed'
  GROUP BY 1
)
SELECT month, revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER w) / LAG(revenue) OVER w, 1) AS pct_change,
       SUM(revenue) OVER (ORDER BY month) AS running_total
FROM m
WINDOW w AS (ORDER BY month)
ORDER BY month
LIMIT 4;

-- Month-over-month change
WITH m AS (
  SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status = 'completed'
  GROUP BY 1
)
(SELECT 'best' AS kind, month, revenue FROM m ORDER BY revenue DESC LIMIT 1)
UNION ALL
(SELECT 'worst', month, revenue FROM m ORDER BY revenue LIMIT 1);

-- Yearly revenue and growth
WITH y AS (
  SELECT EXTRACT(year FROM o.order_date)::int AS yr, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status = 'completed'
  GROUP BY 1
)
SELECT yr, revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY yr)) / LAG(revenue) OVER (ORDER BY yr), 1) AS growth_pct
FROM y ORDER BY yr;

-- Revenue by channel, with its share
SELECT channel, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue,
       ROUND(100.0 * SUM(oi.quantity * oi.unit_price) / SUM(SUM(oi.quantity * oi.unit_price)) OVER (), 1) AS pct
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY channel
ORDER BY revenue DESC;

-- Average order value
SELECT ROUND(AVG(order_total), 2) AS average_order_value
FROM (
  SELECT SUM(oi.quantity * oi.unit_price) AS order_total
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status = 'completed'
  GROUP BY o.order_id
) t;
