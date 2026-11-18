-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.10: Aggregation Challenge
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/aggregation-challenge/

-- Lines and revenue by quantity
SELECT quantity, COUNT(*) AS lines, ROUND(SUM(quantity * unit_price)) AS revenue
FROM order_items
GROUP BY quantity
ORDER BY quantity;

-- Orders per month and channel since November
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month, channel, COUNT(*) AS orders
FROM orders
WHERE order_date >= '2025-11-01'
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- Percentage of orders not completed, per channel
SELECT channel,
       ROUND(100.0 * COUNT(*) FILTER (WHERE status <> 'completed') / COUNT(*), 1) AS pct_not_completed
FROM orders
GROUP BY channel
ORDER BY 2 DESC;

-- The five customers with the most orders
SELECT customer_id, COUNT(*) AS orders
FROM orders
GROUP BY customer_id
ORDER BY orders DESC
LIMIT 5;

-- Countries with at least 30 customers, and how many have an email
SELECT country, COUNT(*) AS customers,
       ROUND(100.0 * COUNT(email) / COUNT(*), 0) AS pct_with_email
FROM customers
GROUP BY country
HAVING COUNT(*) >= 30
ORDER BY customers DESC;

-- A summary per category
SELECT category, COUNT(*) AS products, ROUND(AVG(price), 2) AS avg_price,
       MIN(price) AS cheapest, MAX(price) AS dearest
FROM products
GROUP BY category
ORDER BY avg_price DESC;
