-- SQL for Everyone: From Zero to Confident
-- Chapter 3: Filtering Data
-- Lesson 3.1: WHERE and Comparison Operators
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/where-and-comparison-operators/

-- Products that cost more than 10
SELECT name, price FROM products WHERE price > 10;

-- Text goes in single quotes: the Tea products
SELECT name, price FROM products WHERE category = 'Tea';

-- Greater than or equal to, sorted by price
SELECT name, price FROM products WHERE price >= 24 ORDER BY price;

-- A lowercase 'tea' finds nothing: text comparison is case-sensitive
SELECT name, price FROM products WHERE category = 'tea';

-- Filter customers by country
SELECT first_name, last_name, city FROM customers WHERE country = 'Japan' LIMIT 5;

-- Filter orders by a date
SELECT order_id, order_date, status FROM orders WHERE order_date >= '2025-12-31' LIMIT 5;
