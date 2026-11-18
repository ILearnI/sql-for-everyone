-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.8: string_agg, array_agg and DISTINCT ON
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/string-agg-array-agg-and-distinct-on/

-- STRING_AGG joins values into one text
SELECT category, STRING_AGG(name, ', ' ORDER BY name) AS cheap_products
FROM products
WHERE price < 6
GROUP BY category
ORDER BY category;

-- ARRAY_AGG collects values into an array
SELECT category, ARRAY_AGG(name ORDER BY price DESC) AS by_price
FROM products
WHERE category = 'Pantry'
GROUP BY category;

-- STRING_AGG with DISTINCT
SELECT STRING_AGG(DISTINCT channel, ' | ' ORDER BY channel) AS channels FROM orders;

-- DISTINCT ON: the most expensive product of each category
SELECT DISTINCT ON (category) category, name, price
FROM products
ORDER BY category, price DESC;

-- DISTINCT ON: the latest order of each customer
SELECT DISTINCT ON (customer_id) customer_id, order_id, order_date
FROM orders
ORDER BY customer_id, order_date DESC
LIMIT 4;
