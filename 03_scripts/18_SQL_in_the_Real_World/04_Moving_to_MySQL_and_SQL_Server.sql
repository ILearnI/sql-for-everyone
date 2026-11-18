-- SQL for Everyone: From Zero to Confident
-- Chapter 18: SQL in the Real World
-- Lesson 18.4: Moving to MySQL and SQL Server
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/moving-to-mysql-and-sql-server/

-- SQL Server: TOP (fails here on purpose)
SELECT TOP 3 name FROM products ORDER BY price DESC;

-- PostgreSQL and MySQL: LIMIT
SELECT name FROM products ORDER BY price DESC LIMIT 3;

-- MySQL: IFNULL (fails here on purpose)
SELECT IFNULL(email, 'none') FROM customers LIMIT 1;

-- The standard: COALESCE
SELECT COALESCE(email, 'none') AS email FROM customers WHERE email IS NULL LIMIT 1;

-- SQL Server: + joins text (fails here on purpose)
SELECT first_name + ' ' + last_name FROM customers LIMIT 1;

-- The standard and PostgreSQL way: ||
SELECT first_name || ' ' || last_name AS full_name FROM customers ORDER BY customer_id LIMIT 1;

-- SQL Server: DATEADD (fails here on purpose)
SELECT DATEADD(day, 7, DATE '2025-01-01');

-- PostgreSQL: add days to a date
SELECT DATE '2025-01-01' + 7 AS plus_7_days;

-- Subtract two dates
SELECT DATE '2025-03-01' - DATE '2025-01-01' AS days_between;

-- Integer division, case-sensitive text and ILIKE
SELECT 5 / 2 AS integer_division, 5 / 2.0 AS decimal_division, 'abc' = 'ABC' AS case_equal, 'abc' ILIKE 'ABC' AS ilike_equal;

-- Double quotes are names, not text (fails on purpose)
SELECT name FROM products WHERE name = "Burr Grinder";
