-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.6: FILTER and Conditional Aggregation
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/filter-and-conditional-aggregation/

-- One FILTER per status
SELECT COUNT(*) FILTER (WHERE status = 'completed') AS completed,
       COUNT(*) FILTER (WHERE status = 'cancelled') AS cancelled,
       COUNT(*) FILTER (WHERE status = 'refunded')  AS refunded
FROM orders;

-- FILTER gives the same result as SUM with CASE
SELECT SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_case,
       COUNT(*) FILTER (WHERE status = 'completed') AS completed_filter
FROM orders;

-- FILTER with GROUP BY: statuses per channel
SELECT channel,
       COUNT(*) FILTER (WHERE status = 'completed') AS completed,
       COUNT(*) FILTER (WHERE status = 'cancelled') AS cancelled,
       COUNT(*) FILTER (WHERE status = 'refunded')  AS refunded
FROM orders
GROUP BY channel
ORDER BY channel;

-- Completed and refunded orders per month
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
       COUNT(*) FILTER (WHERE status = 'completed') AS completed,
       COUNT(*) FILTER (WHERE status = 'refunded')  AS refunded,
       COUNT(*) AS total
FROM orders
GROUP BY 1 ORDER BY 1
LIMIT 4;

-- The percentage of orders that were not completed
SELECT ROUND(100.0 * COUNT(*) FILTER (WHERE status <> 'completed') / COUNT(*), 1) AS pct_problem
FROM orders;
