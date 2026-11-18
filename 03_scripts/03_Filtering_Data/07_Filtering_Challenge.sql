-- SQL for Everyone: From Zero to Confident
-- Chapter 3: Filtering Data
-- Lesson 3.7: Filtering Challenge
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/filtering-challenge/

-- Tea products over 6, cheapest first
SELECT name, price FROM products
WHERE category = 'Tea' AND price > 6
ORDER BY price;

-- Cancelled or refunded orders in 2025
SELECT order_id, order_date, status FROM orders
WHERE status IN ('cancelled', 'refunded')
  AND order_date >= '2025-01-01'
  AND order_date <  '2026-01-01'
LIMIT 8;

-- Orders of the first quarter of 2025, newest first
SELECT order_id, order_date FROM orders
WHERE order_date >= '2025-01-01'
  AND order_date <  '2025-04-01'
ORDER BY order_date DESC
LIMIT 5;

-- Customers with a Gmail address
SELECT first_name, email FROM customers
WHERE email ILIKE '%@gmail.com'
LIMIT 5;

-- Customers with no email
SELECT first_name, last_name FROM customers
WHERE email IS NULL
LIMIT 6;

-- Cold Brew products with a numeric size
SELECT name FROM products
WHERE name ~ '^Cold Brew [0-9]+$';
