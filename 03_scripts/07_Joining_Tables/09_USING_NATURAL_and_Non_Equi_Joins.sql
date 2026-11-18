-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.9: USING, NATURAL and Non-Equi Joins
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/using-natural-and-non-equi-joins/

-- Join orders and customers
SELECT o.order_id, c.first_name
FROM orders o
JOIN customers c USING (customer_id)
LIMIT 3;

-- NATURAL JOIN of customers and orders
SELECT * FROM customers NATURAL JOIN orders LIMIT 1;

-- Query price_bands
SELECT * FROM price_bands ORDER BY band_id;

-- Join products and price_bands
SELECT p.name, p.price, b.band_name
FROM products p
JOIN price_bands b ON p.price >= b.min_price AND p.price < b.max_price
ORDER BY p.price
LIMIT 4;

-- Join products and price_bands
SELECT b.band_name, COUNT(*) AS products
FROM products p
JOIN price_bands b ON p.price >= b.min_price AND p.price < b.max_price
GROUP BY b.band_id, b.band_name
ORDER BY b.band_id;

-- Join products
SELECT a.name AS product, b.name AS pricier, b.price
FROM products a
JOIN products b ON b.category = a.category AND b.price > a.price
WHERE a.product_id = 31
ORDER BY b.price
LIMIT 3;

-- Join customers and orders
SELECT COUNT(*) AS orders_in_first_30_days
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
 AND o.order_date >= c.signup_date
 AND o.order_date <  c.signup_date + INTERVAL '30 days';
