-- SQL for Everyone: From Zero to Confident
-- Chapter 20: SQL Interview Preparation
-- Lesson 20.7: Mock Interview: Three Problems Live
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/mock-interview-three-problems-live/

-- Problem 1: monthly revenue, best months first
SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled' GROUP BY 1 ORDER BY revenue DESC LIMIT 1;

-- Problem 2: the top customer in each country
WITH t AS (
  SELECT c.country, c.customer_id, SUM(oi.quantity * oi.unit_price) AS total
  FROM customers c JOIN orders o ON o.customer_id = c.customer_id JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status <> 'cancelled' GROUP BY c.country, c.customer_id
), r AS (SELECT *, RANK() OVER (PARTITION BY country ORDER BY total DESC) AS rnk FROM t)
SELECT country, customer_id, total FROM r WHERE rnk = 1 ORDER BY total DESC LIMIT 4;

-- Problem 3: revenue against its 3-month average
WITH m AS (
  SELECT date_trunc('month', o.order_date)::date AS month, SUM(oi.quantity * oi.unit_price) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id WHERE o.status <> 'cancelled' GROUP BY 1
)
SELECT month, ROUND(revenue) AS revenue, ROUND(AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)) AS moving_avg_3m
FROM m ORDER BY month DESC LIMIT 3;
