-- SQL for Everyone: From Zero to Confident
-- Chapter 8: Subqueries and CTEs
-- Lesson 8.1: Subqueries in WHERE
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/subqueries-in-where/

-- Query products
SELECT ROUND(AVG(price), 2) AS average_price FROM products;

-- A subquery on products
SELECT name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price DESC
LIMIT 4;

-- A subquery on products
SELECT COUNT(*) AS above_average
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- A subquery on products
SELECT name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);

-- A subquery on customers
SELECT COUNT(*) AS store_customers
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders WHERE channel = 'store');

-- A subquery on products
SELECT name, price
FROM products
WHERE price > ALL (SELECT price FROM products WHERE category = 'Coffee')
ORDER BY price
LIMIT 3;

-- A subquery that returns several rows cannot be compared with >
SELECT name FROM products
WHERE price > (SELECT price FROM products);
