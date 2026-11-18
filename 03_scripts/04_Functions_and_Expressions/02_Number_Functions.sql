-- SQL for Everyone: From Zero to Confident
-- Chapter 4: Functions and Expressions
-- Lesson 4.2: Number Functions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/number-functions/

-- ROUND with 2 decimals: price with tax
SELECT name, price, ROUND(price * 1.2, 2) AS with_tax FROM products LIMIT 5;

-- ROUND with different decimals, including negative ones
SELECT ROUND(7.456, 1), ROUND(1234.5, -2), ROUND(2.5), ROUND(-2.5);

-- CEIL rounds up, FLOOR rounds down
SELECT name, price, CEIL(price) AS up, FLOOR(price) AS down FROM products LIMIT 5;

-- TRUNC cuts, ROUND rounds, ABS removes the sign
SELECT TRUNC(4.987, 2) AS trunc2, ROUND(4.987, 2) AS round2, ABS(-12.5) AS abs_val;

-- Integer division, decimal division and the remainder
SELECT 7 / 2 AS int_div, 7.0 / 2 AS dec_div, 7 % 2 AS remainder;

-- float8 and numeric: why money uses numeric
SELECT 0.1::float8 + 0.2::float8 AS float_sum, 0.1::numeric + 0.2::numeric AS numeric_sum;

-- Margin as a percentage of the price
SELECT name, ROUND((price - cost) / price * 100, 1) AS margin_pct
FROM products
ORDER BY margin_pct DESC
LIMIT 3;
