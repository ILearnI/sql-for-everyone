-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.4: HAVING
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/having/

-- Categories with at least 10 products
SELECT category, COUNT(*) AS products
FROM products
GROUP BY category
HAVING COUNT(*) >= 10
ORDER BY products DESC;

-- Months with more than 250 orders
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month, COUNT(*) AS orders
FROM orders
GROUP BY 1
HAVING COUNT(*) > 250
ORDER BY 1;

-- Customers with at least 100 orders
SELECT customer_id, COUNT(*) AS orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 100
ORDER BY orders DESC;

-- WHERE filters rows, HAVING filters groups
SELECT channel, COUNT(*) AS orders
FROM orders
WHERE status = 'completed'
GROUP BY channel
HAVING COUNT(*) > 1000;

-- HAVING with an average
SELECT category, ROUND(AVG(price), 2) AS avg_price
FROM products
GROUP BY category
HAVING AVG(price) > 10
ORDER BY 2 DESC;

-- Fails on purpose: WHERE cannot use COUNT
SELECT category, COUNT(*) FROM products WHERE COUNT(*) > 5 GROUP BY category;
