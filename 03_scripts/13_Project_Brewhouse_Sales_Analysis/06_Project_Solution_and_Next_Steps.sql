-- SQL for Everyone: From Zero to Confident
-- Chapter 13: Project: Brewhouse Sales Analysis
-- Lesson 13.6: Project Solution and Next Steps
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/project-solution-and-next-steps/

-- Joining the items repeats the orders: the count is wrong
SELECT COUNT(*) AS wrong_orders, COUNT(DISTINCT o.order_id) AS right_orders
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed';

-- The same mistake makes the average wrong
SELECT ROUND(AVG(oi.quantity * oi.unit_price), 2) AS wrong_average_order
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed';

-- The right average order: sum per order first
SELECT ROUND(AVG(order_total), 2) AS right_average_order
FROM (SELECT SUM(oi.quantity * oi.unit_price) AS order_total
      FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
      WHERE o.status = 'completed' GROUP BY o.order_id) t;

-- BETWEEN with dates misses the end of the last day
SELECT COUNT(*) AS with_between FROM orders
WHERE status = 'completed' AND order_date BETWEEN '2025-12-01' AND '2025-12-31';

-- A half-open range counts the whole month
SELECT COUNT(*) AS with_half_open_range FROM orders
WHERE status = 'completed' AND order_date >= '2025-12-01' AND order_date < '2026-01-01';

-- Monthly revenue: the final report query
WITH m AS (
  SELECT date_trunc('month', o.order_date)::date AS month, SUM(oi.quantity * oi.unit_price) AS revenue
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status = 'completed' GROUP BY 1
)
SELECT ROUND(SUM(revenue)) AS sum_of_months FROM m;

-- The total in one step, to check
SELECT ROUND(SUM(oi.quantity * oi.unit_price)) AS total_in_one_step
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed';
