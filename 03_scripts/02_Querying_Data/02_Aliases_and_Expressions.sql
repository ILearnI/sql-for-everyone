-- SQL for Everyone: From Zero to Confident
-- Chapter 2: Querying Data
-- Lesson 2.2: Aliases and Expressions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/aliases-and-expressions/

-- AS gives a column a new name in the result
SELECT name, price AS unit_price FROM products LIMIT 5;

-- Arithmetic in the select list, with a named result
SELECT name, price, cost, price - cost AS margin
FROM products
LIMIT 5;

-- Join text with ||
SELECT first_name || ' ' || last_name AS full_name, city
FROM customers
LIMIT 5;

-- Calculate a price with tax
SELECT name, price * 1.2 AS price_with_tax FROM products LIMIT 5;

-- A query with no table: just an expression
SELECT 7 * 6 AS answer;

-- Integer division against decimal division
SELECT 10 / 4 AS integer_division, 10 / 4.0 AS decimal_division;
