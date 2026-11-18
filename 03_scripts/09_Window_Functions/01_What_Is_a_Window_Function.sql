-- SQL for Everyone: From Zero to Confident
-- Chapter 9: Window Functions
-- Lesson 9.1: What Is a Window Function?
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/what-is-a-window-function/

-- Group products
SELECT category, ROUND(AVG(price), 2) AS avg_price
FROM products
GROUP BY category
ORDER BY category;

-- Window function avg
SELECT name, price, ROUND(AVG(price) OVER (), 2) AS avg_price
FROM products
ORDER BY price
LIMIT 4;

-- Window function avg
SELECT name, price,
       ROUND(price - AVG(price) OVER (), 2) AS vs_average
FROM products
ORDER BY price DESC
LIMIT 3;

-- Window function sum
SELECT name, price,
       ROUND(100 * price / SUM(price) OVER (), 1) AS pct_of_total
FROM products
ORDER BY price DESC
LIMIT 3;

-- Window functions are not allowed in WHERE
SELECT name FROM products
WHERE price > AVG(price) OVER ();
