-- SQL for Everyone: From Zero to Confident
-- Chapter 2: Querying Data
-- Lesson 2.7: How a Query Runs
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/how-a-query-runs/

-- Fails on purpose: WHERE runs before the alias exists
SELECT name, price * 2 AS double_price
FROM products
WHERE double_price > 20;

-- The fix: repeat the expression in WHERE, and use the alias in ORDER BY
SELECT name, price * 2 AS double_price
FROM products
WHERE price * 2 > 20
ORDER BY double_price DESC
LIMIT 3;
