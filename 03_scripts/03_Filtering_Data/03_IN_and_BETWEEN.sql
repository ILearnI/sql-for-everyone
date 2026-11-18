-- SQL for Everyone: From Zero to Confident
-- Chapter 3: Filtering Data
-- Lesson 3.3: IN and BETWEEN
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/in-and-between/

-- IN: a list of values
SELECT name, category FROM products WHERE category IN ('Tea', 'Coffee') LIMIT 6;

-- NOT IN: everything outside the list
SELECT DISTINCT category FROM products WHERE category NOT IN ('Tea', 'Coffee');

-- BETWEEN includes both ends
SELECT name, price FROM products WHERE price BETWEEN 5 AND 6;

-- BETWEEN with the same date twice only finds orders at midnight
SELECT order_id, order_date FROM orders
WHERE order_date BETWEEN '2025-03-31' AND '2025-03-31';

-- A safer way: from the start of the day up to the start of the next
SELECT order_id, order_date FROM orders
WHERE order_date >= '2025-03-31' AND order_date < '2025-04-01'
LIMIT 5;

-- IN with order ids
SELECT order_id, status, channel FROM orders WHERE order_id IN (2, 6, 20);
