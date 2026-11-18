-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.7: Pivoting Data
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/pivoting-data/

-- Long form: one row per quarter and channel
SELECT EXTRACT(quarter FROM order_date)::int AS q, channel, COUNT(*) AS orders
FROM orders
WHERE order_date >= '2025-01-01'
GROUP BY 1, 2
ORDER BY 2, 1
LIMIT 6;

-- Pivot with FILTER: quarters become columns
SELECT channel,
       COUNT(*) FILTER (WHERE EXTRACT(quarter FROM order_date) = 1) AS q1,
       COUNT(*) FILTER (WHERE EXTRACT(quarter FROM order_date) = 2) AS q2,
       COUNT(*) FILTER (WHERE EXTRACT(quarter FROM order_date) = 3) AS q3,
       COUNT(*) FILTER (WHERE EXTRACT(quarter FROM order_date) = 4) AS q4
FROM orders
WHERE order_date >= '2025-01-01'
GROUP BY channel
ORDER BY channel;

-- Needs an extension: not available in the browser playground, run it in your own PostgreSQL
CREATE EXTENSION IF NOT EXISTS tablefunc;

-- Needs an extension: not available in the browser playground, run it in your own PostgreSQL
SELECT * FROM crosstab(
  'SELECT channel, EXTRACT(quarter FROM order_date)::int, COUNT(*)::int
   FROM orders WHERE order_date >= ''2025-01-01'' GROUP BY 1, 2 ORDER BY 1, 2',
  'SELECT generate_series(1, 4)'
) AS ct(channel text, q1 int, q2 int, q3 int, q4 int);
