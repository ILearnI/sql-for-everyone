-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.3: Grouping by Several Columns
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/grouping-by-several-columns/

-- Group by channel and status
SELECT channel, status, COUNT(*) AS orders
FROM orders
GROUP BY channel, status
ORDER BY channel, orders DESC;

-- Group by an expression: the year
SELECT EXTRACT(year FROM order_date) AS yr, COUNT(*) AS orders
FROM orders
GROUP BY EXTRACT(year FROM order_date)
ORDER BY yr;

-- Group by month with DATE_TRUNC
SELECT DATE_TRUNC('month', order_date)::date AS month, COUNT(*) AS orders
FROM orders
GROUP BY 1
ORDER BY 1
LIMIT 6;

-- Group by position: month and channel
SELECT TO_CHAR(order_date, 'YYYY-MM') AS ym, channel, COUNT(*) AS orders
FROM orders
GROUP BY 1, 2
ORDER BY 1, 2
LIMIT 6;

-- Customers and emails per country
SELECT country, COUNT(*) AS customers, COUNT(email) AS with_email
FROM customers
GROUP BY country
ORDER BY customers DESC
LIMIT 4;
