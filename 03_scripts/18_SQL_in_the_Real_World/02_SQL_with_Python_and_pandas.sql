-- SQL for Everyone: From Zero to Confident
-- Chapter 18: SQL in the Real World
-- Lesson 18.2: SQL with Python and pandas
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/sql-with-python-and-pandas/

-- Daily revenue with a 7-day average: the newest days
WITH d AS (
  SELECT o.order_date::date AS day, SUM(oi.quantity * oi.unit_price) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status = 'completed' GROUP BY 1
)
SELECT COUNT(*) AS rows_in_the_dataframe, MIN(day) AS first_day, MAX(day) AS last_day, ROUND(AVG(revenue), 2) AS average_day
FROM d;

-- The query pandas would run
SELECT o.order_date::date AS day, ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY 1 ORDER BY 1 LIMIT 3;

-- The same average, checked in SQL
WITH d AS (
  SELECT o.order_date::date AS day, SUM(oi.quantity * oi.unit_price) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status = 'completed' GROUP BY 1
)
SELECT day, ROUND(revenue, 2) AS revenue,
       ROUND(AVG(revenue) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS avg_7d
FROM d ORDER BY day DESC LIMIT 3;

-- How many rows if we fetched everything?
SELECT COUNT(*) AS rows_if_we_fetched_everything FROM order_items;
