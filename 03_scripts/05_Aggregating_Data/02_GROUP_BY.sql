-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.2: GROUP BY
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/group-by/

-- One row per category
SELECT category, COUNT(*) AS products, ROUND(AVG(price), 2) AS avg_price
FROM products
GROUP BY category
ORDER BY products DESC;

-- Orders per channel
SELECT channel, COUNT(*) AS orders FROM orders GROUP BY channel ORDER BY orders DESC;

-- Orders per status
SELECT status, COUNT(*) AS orders FROM orders GROUP BY status ORDER BY orders DESC;

-- The four countries with the most customers
SELECT country, COUNT(*) AS customers
FROM customers
GROUP BY country
ORDER BY customers DESC
LIMIT 4;

-- SUM per group
SELECT category, SUM(price) AS total_price FROM products GROUP BY category ORDER BY 2 DESC;

-- Fails on purpose: name is not in GROUP BY
SELECT category, name, COUNT(*) FROM products GROUP BY category;
