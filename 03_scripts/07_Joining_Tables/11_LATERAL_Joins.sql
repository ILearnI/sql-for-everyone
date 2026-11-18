-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.11: LATERAL Joins
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/lateral-joins/

-- LATERAL join on customers
SELECT c.customer_id, c.first_name, o.order_id, o.order_date::date AS day
FROM customers c
CROSS JOIN LATERAL (
  SELECT order_id, order_date FROM orders o
  WHERE o.customer_id = c.customer_id
  ORDER BY order_date DESC LIMIT 3
) o
WHERE c.customer_id IN (1, 2)
ORDER BY c.customer_id, o.order_date DESC;

-- LATERAL join on customers
SELECT COUNT(*) AS cross_lateral_rows
FROM customers c
CROSS JOIN LATERAL (
  SELECT order_id FROM orders o WHERE o.customer_id = c.customer_id
  ORDER BY order_date DESC LIMIT 3) o;

-- LATERAL join on customers
SELECT COUNT(*) AS left_lateral_rows
FROM customers c
LEFT JOIN LATERAL (
  SELECT order_id FROM orders o WHERE o.customer_id = c.customer_id
  ORDER BY order_date DESC LIMIT 3) o ON true;

-- LATERAL join on customers
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN LATERAL (
  SELECT order_id FROM orders o WHERE o.customer_id = c.customer_id
  ORDER BY order_date DESC LIMIT 1) o ON true
WHERE c.customer_id IN (1, 10)
ORDER BY c.customer_id;

-- LATERAL join on products
SELECT p.category, t.name, t.price
FROM (SELECT DISTINCT category FROM products) p
CROSS JOIN LATERAL (
  SELECT name, price FROM products x
  WHERE x.category = p.category ORDER BY price DESC LIMIT 2) t
ORDER BY p.category, t.price DESC
LIMIT 6;
