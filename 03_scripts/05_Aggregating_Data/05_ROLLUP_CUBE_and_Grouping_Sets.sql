-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.5: ROLLUP, CUBE and Grouping Sets
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/rollup-cube-and-grouping-sets/

-- ROLLUP: subtotals per year and a grand total
SELECT EXTRACT(year FROM order_date)::int AS yr, channel, COUNT(*) AS orders
FROM orders
GROUP BY ROLLUP (EXTRACT(year FROM order_date), channel)
ORDER BY 1, 2;

-- GROUPING tells a total row from a real NULL
SELECT COALESCE(category, 'ALL') AS category, COUNT(*) AS products, GROUPING(category) AS is_total
FROM products
GROUP BY ROLLUP (category)
ORDER BY is_total, category;

-- CUBE: every combination of channel and status
SELECT channel, status, COUNT(*) AS orders
FROM orders
GROUP BY CUBE (channel, status)
ORDER BY 1, 2;

-- GROUPING SETS: choose the groupings yourself
SELECT channel, status, COUNT(*) AS orders
FROM orders
GROUP BY GROUPING SETS ((channel), (status), ())
ORDER BY 1, 2;
