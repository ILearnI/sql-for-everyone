-- SQL for Everyone: From Zero to Confident
-- Chapter 9: Window Functions
-- Lesson 9.7: Named Windows and Distribution Functions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/named-windows-and-distribution-functions/

-- Window function row_number, rank, sum
SELECT name, price,
       ROW_NUMBER() OVER w AS rn,
       RANK()       OVER w AS rk,
       ROUND(SUM(price) OVER w, 2) AS running
FROM products
WHERE category = 'Pantry'
WINDOW w AS (ORDER BY price)
ORDER BY price
LIMIT 3;

-- Window function row_number, sum
SELECT category, name, price,
       ROW_NUMBER() OVER ranked AS rn,
       ROUND(100 * price / SUM(price) OVER cat, 1) AS pct_of_category
FROM products
WINDOW cat AS (PARTITION BY category),
       ranked AS (cat ORDER BY price DESC)
ORDER BY category, rn
LIMIT 3;

-- Window function percent_rank, cume_dist
SELECT name, price,
       ROUND(PERCENT_RANK() OVER w::numeric, 2) AS percent_rank,
       ROUND(CUME_DIST() OVER w::numeric, 2) AS cume_dist
FROM products
WHERE category = 'Pantry'
WINDOW w AS (ORDER BY price)
ORDER BY price;

-- Window function cume_dist
SELECT COUNT(*) AS cheapest_tenth
FROM (SELECT CUME_DIST() OVER (ORDER BY price) AS cd FROM products) t
WHERE cd <= 0.1;
