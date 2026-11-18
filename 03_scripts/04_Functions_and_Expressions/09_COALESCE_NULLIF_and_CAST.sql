-- SQL for Everyone: From Zero to Confident
-- Chapter 4: Functions and Expressions
-- Lesson 4.9: COALESCE, NULLIF and CAST
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/coalesce-nullif-and-cast/

-- COALESCE replaces NULL with a default
SELECT first_name, COALESCE(email, 'no email') AS email FROM customers WHERE email IS NULL LIMIT 3;

-- COALESCE around a function result
SELECT first_name, COALESCE(SPLIT_PART(email, '@', 2), 'unknown') AS domain
FROM customers WHERE email IS NULL LIMIT 2;

-- COALESCE returns the first value that is not NULL
SELECT COALESCE(NULL, NULL, 'third') AS first_non_null;

-- Division by zero fails
SELECT 10 / 0;

-- NULLIF turns the zero into NULL, so the division is safe
SELECT 10 / NULLIF(0, 0) AS safe_division;

-- A safe margin percentage
SELECT name, ROUND((price - cost) / NULLIF(price, 0) * 100, 1) AS margin_pct
FROM products ORDER BY margin_pct DESC LIMIT 3;

-- CAST and :: change a type
SELECT CAST('42' AS integer) + 8 AS a, '2025-03-31'::date + 1 AS b, CAST(3.99 AS integer) AS c;

-- A failed cast: read the error
SELECT 'abc'::integer;
