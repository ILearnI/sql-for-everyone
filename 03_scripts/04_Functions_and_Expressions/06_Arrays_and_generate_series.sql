-- SQL for Everyone: From Zero to Confident
-- Chapter 4: Functions and Expressions
-- Lesson 4.6: Arrays and generate_series
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/arrays-and-generate-series/

-- An array and its second item (arrays start at 1)
SELECT ARRAY['tea', 'coffee', 'pantry'] AS tags, (ARRAY['tea', 'coffee', 'pantry'])[2] AS second;

-- = ANY compares with a list
SELECT name FROM products WHERE category = ANY (ARRAY['Tea', 'Coffee']) LIMIT 3;

-- UNNEST turns an array into rows
SELECT UNNEST(ARRAY['mon', 'tue', 'wed']) AS day;

-- ARRAY_AGG turns rows into an array
SELECT ARRAY_AGG(name ORDER BY name) AS cheap_teas
FROM products WHERE category = 'Tea' AND price < 6;

-- generate_series with a step
SELECT generate_series(1, 10, 3) AS n;

-- A week of dates, with a weekend flag
SELECT d::date AS day, EXTRACT(dow FROM d) IN (0, 6) AS weekend
FROM generate_series(DATE '2025-01-01', DATE '2025-01-07', INTERVAL '1 day') AS d;

-- Count the weekend days of 2025
SELECT COUNT(*) AS weekend_days
FROM generate_series(DATE '2025-01-01', DATE '2025-12-31', INTERVAL '1 day') AS d
WHERE EXTRACT(dow FROM d) IN (0, 6);
