-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.1: Why Joins?
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/why-joins/

-- Query orders
SELECT order_id, customer_id, status FROM orders ORDER BY order_id LIMIT 3;

-- Query customers
SELECT customer_id, first_name, last_name, city FROM customers WHERE customer_id = 374;

-- Join orders and customers
SELECT o.order_id, o.status, c.first_name, c.last_name, c.city
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_id
LIMIT 3;

-- Join orders and customers
SELECT COUNT(*) AS joined_rows FROM orders o JOIN customers c ON c.customer_id = o.customer_id;

-- Query orders
SELECT COUNT(*) AS orders FROM orders;
