-- SQL for Everyone: From Zero to Confident
-- Chapter 4: Functions and Expressions
-- Lesson 4.8: CASE Expressions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/case-expressions/

-- Label each product with a price tier
SELECT name, price,
       CASE WHEN price < 5 THEN 'budget'
            WHEN price < 15 THEN 'standard'
            ELSE 'premium' END AS tier
FROM products ORDER BY product_id LIMIT 6;

-- Simple CASE on one column
SELECT CASE category WHEN 'Tea' THEN 'T' WHEN 'Coffee' THEN 'C' ELSE 'other' END AS code,
       COUNT(*) AS products
FROM products GROUP BY 1 ORDER BY 1;

-- CASE in ORDER BY: Tea first
SELECT name, price FROM products
ORDER BY CASE WHEN category = 'Tea' THEN 0 ELSE 1 END, price
LIMIT 4;

-- CASE on a subquery result: classify each order by its total
SELECT CASE WHEN total < 15 THEN 'Small' WHEN total < 40 THEN 'Medium' ELSE 'Large' END AS size,
       COUNT(*) AS orders
FROM (SELECT order_id, SUM(quantity * unit_price) AS total FROM order_items GROUP BY order_id) AS t
GROUP BY 1 ORDER BY 2 DESC;

-- Conditional counting with SUM and CASE
SELECT SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed,
       SUM(CASE WHEN status <> 'completed' THEN 1 ELSE 0 END) AS other
FROM orders;
