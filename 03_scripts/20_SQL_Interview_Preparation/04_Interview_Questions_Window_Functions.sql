-- SQL for Everyone: From Zero to Confident
-- Chapter 20: SQL Interview Preparation
-- Lesson 20.4: Interview Questions: Window Functions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/interview-questions-window-functions/

-- Top 2 prices per category (DENSE_RANK)
SELECT category, name, price FROM (
  SELECT category, name, price, DENSE_RANK() OVER (PARTITION BY category ORDER BY price DESC) AS r FROM products
) t WHERE r <= 2 ORDER BY category, price DESC LIMIT 6;

-- Running total of orders per day
SELECT day, orders, SUM(orders) OVER (ORDER BY day) AS running_total
FROM (SELECT order_date::date AS day, COUNT(*) AS orders FROM orders GROUP BY 1) t
ORDER BY day LIMIT 5;

-- Consecutive days: gaps and islands
WITH d AS (SELECT DISTINCT customer_id, order_date::date AS od FROM orders),
g AS (SELECT customer_id, od, od - (ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY od))::int AS grp FROM d)
SELECT customer_id, MIN(od) AS first_day, MAX(od) AS last_day, COUNT(*) AS days
FROM g GROUP BY customer_id, grp HAVING COUNT(*) >= 3 ORDER BY days DESC, customer_id LIMIT 3;

-- How many customers have a 3-day streak?
WITH d AS (SELECT DISTINCT customer_id, order_date::date AS od FROM orders),
g AS (SELECT customer_id, od - (ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY od))::int AS grp FROM d)
SELECT COUNT(DISTINCT customer_id) AS customers_with_a_streak FROM (SELECT customer_id FROM g GROUP BY customer_id, grp HAVING COUNT(*) >= 3) t;

-- Year-over-year change with LAG
WITH m AS (SELECT date_trunc('month', order_date)::date AS month, COUNT(*) AS n FROM orders GROUP BY 1),
y AS (SELECT month, n, LAG(n, 12) OVER (ORDER BY month) AS last_year FROM m)
SELECT month, n, last_year, ROUND(100.0 * (n - last_year) / last_year, 1) AS yoy_pct
FROM y WHERE month >= '2025-10-01' ORDER BY month;

-- The latest order of each customer (ROW_NUMBER)
SELECT customer_id, order_id, order_date::date AS last_order FROM (
  SELECT customer_id, order_id, order_date, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn FROM orders
) t WHERE rn = 1 ORDER BY customer_id LIMIT 3;
