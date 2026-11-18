-- SQL for Everyone: From Zero to Confident
-- Chapter 2: Querying Data
-- Lesson 2.4: ORDER BY
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/order-by/

-- The five cheapest products (ascending is the default)
SELECT name, price FROM products ORDER BY price LIMIT 5;

-- The five most expensive products
SELECT name, price FROM products ORDER BY price DESC LIMIT 5;

-- Sort by two columns
SELECT category, name, price
FROM products
ORDER BY category, price DESC
LIMIT 8;

-- Sort by an alias
SELECT name, price - cost AS margin
FROM products
ORDER BY margin DESC
LIMIT 5;

-- Descending order puts the NULL emails first
SELECT first_name, email FROM customers ORDER BY email DESC LIMIT 5;

-- NULLS LAST moves them to the end
SELECT first_name, email FROM customers ORDER BY email DESC NULLS LAST LIMIT 5;
