-- SQL for Everyone: From Zero to Confident
-- Chapter 9: Window Functions
-- Lesson 9.4: Running Totals and Frames
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/running-totals-and-frames/

-- Window function sum, Join orders and order_items and daily
WITH daily AS (
  SELECT o.order_date::date AS day, ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY 1
)
SELECT day, revenue,
       ROUND(SUM(revenue) OVER (ORDER BY day), 2) AS running_total
FROM daily ORDER BY day LIMIT 5;

-- Window function avg, Join orders and order_items and daily
WITH daily AS (
  SELECT o.order_date::date AS day, SUM(oi.quantity * oi.unit_price) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY 1
)
SELECT day, ROUND(revenue, 2) AS revenue,
       ROUND(AVG(revenue) OVER (ORDER BY day ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS avg_3_days
FROM daily ORDER BY day LIMIT 5;

-- Window function sum, avg, Join orders and order_items and monthly
WITH monthly AS (
  SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY 1
)
SELECT month, revenue,
       SUM(revenue) OVER (ORDER BY month) AS running_total,
       ROUND(AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)) AS avg_3_months
FROM monthly ORDER BY month LIMIT 5;

-- Window function sum, Join orders and order_items and monthly
WITH monthly AS (
  SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY 1
)
SELECT month, revenue, SUM(revenue) OVER (ORDER BY month) AS running_total
FROM monthly ORDER BY month DESC LIMIT 2;
