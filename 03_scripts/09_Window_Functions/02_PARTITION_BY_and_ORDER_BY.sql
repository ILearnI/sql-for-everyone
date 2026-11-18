-- SQL for Everyone: From Zero to Confident
-- Chapter 9: Window Functions
-- Lesson 9.2: PARTITION BY and ORDER BY
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/partition-by-and-order-by/

-- Window function avg
SELECT category, name, price,
       ROUND(AVG(price) OVER (PARTITION BY category), 2) AS category_avg
FROM products
WHERE category IN ('Pantry', 'Coffee')
ORDER BY category, price
LIMIT 5;

-- Window function sum
SELECT name, price,
       SUM(price) OVER (ORDER BY price) AS running_total
FROM products
WHERE category = 'Pantry'
ORDER BY price
LIMIT 5;

-- Window function row_number
SELECT channel, order_id,
       ROW_NUMBER() OVER (PARTITION BY channel ORDER BY order_date) AS nth
FROM orders
WHERE order_id <= 5
ORDER BY channel, nth;

-- Group customers
SELECT country, COUNT(*) AS customers,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM customers
GROUP BY country
ORDER BY customers DESC
LIMIT 3;
