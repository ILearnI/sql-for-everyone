-- SQL for Everyone: From Zero to Confident
-- Chapter 12: Working with Real Data
-- Lesson 12.3: Normalisation in Plain English
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/normalisation-in-plain-english/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- A flat table made from four joined tables
CREATE TABLE flat_orders AS
SELECT o.order_id, c.first_name || ' ' || c.last_name AS customer, c.email, c.city,
       p.name AS product, p.category, oi.quantity, oi.unit_price
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.order_id BETWEEN 1 AND 6;

-- Look at the flat rows: the customer repeats
SELECT order_id, customer, city, product FROM flat_orders ORDER BY order_id, product LIMIT 4;

-- Rows, customers and products: how much repeats?
SELECT COUNT(*) AS rows, COUNT(DISTINCT email) AS customers, COUNT(DISTINCT product) AS products FROM flat_orders;

-- Split into a customers table and a products table
CREATE TABLE customers_n AS SELECT DISTINCT email, customer AS name, city FROM flat_orders;
CREATE TABLE products_n AS SELECT DISTINCT product AS name, category FROM flat_orders;
CREATE TABLE order_items_n AS SELECT order_id, email, product, quantity, unit_price FROM flat_orders;
SELECT (SELECT COUNT(*) FROM customers_n) AS customers, (SELECT COUNT(*) FROM products_n) AS products, (SELECT COUNT(*) FROM order_items_n) AS order_lines;

-- Change a city in the flat table: many rows to update
UPDATE flat_orders SET city = 'Portland'
WHERE order_id = 1 AND product = 'Chai Spice Blend';
SELECT customer, city, COUNT(*) AS rows FROM flat_orders WHERE customer = 'Mateo Ibrahim' GROUP BY 1, 2 ORDER BY 2;

-- Change it in the customers table: one row
UPDATE customers_n SET city = 'Portland' WHERE email = 'mateo.ibrahim80@gmail.com';
SELECT c.name, c.city, COUNT(*) AS order_lines
FROM order_items_n oi JOIN customers_n c ON c.email = oi.email
WHERE c.name = 'Mateo Ibrahim'
GROUP BY 1, 2;
