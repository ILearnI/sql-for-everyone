-- SQL for Everyone: From Zero to Confident
-- Chapter 2: Querying Data
-- Lesson 2.5: LIMIT and OFFSET
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/limit-and-offset/

-- The five most expensive products
SELECT name, price FROM products ORDER BY price DESC LIMIT 5;

-- Page 1: the first 8 products by name
SELECT product_id, name FROM products ORDER BY name LIMIT 8;

-- Page 2: skip 8, then take 8
SELECT product_id, name FROM products ORDER BY name LIMIT 8 OFFSET 8;

-- The five biggest order lines
SELECT order_id, product_id, quantity * unit_price AS line_value
FROM order_items
ORDER BY line_value DESC
LIMIT 5;
