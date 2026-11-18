-- SQL for Everyone: From Zero to Confident
-- Chapter 3: Filtering Data
-- Lesson 3.2: AND, OR and NOT
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/and-or-and-not/

-- AND: both conditions must be true
SELECT name, price FROM products WHERE category = 'Tea' AND price < 8;

-- OR: either condition is enough
SELECT name, category, price FROM products WHERE category = 'Tea' OR price < 4;

-- NOT reverses a condition
SELECT DISTINCT category FROM products WHERE NOT category = 'Tea';

-- AND runs before OR: Tea, or Coffee over 10
SELECT name, category, price
FROM products
WHERE category = 'Tea' OR category = 'Coffee' AND price > 10;

-- Parentheses make OR run first
SELECT name, category, price
FROM products
WHERE (category = 'Tea' OR category = 'Coffee') AND price > 10;

-- Cancelled or refunded orders
SELECT order_id, order_date, status FROM orders WHERE status = 'cancelled' OR status = 'refunded' LIMIT 5;
