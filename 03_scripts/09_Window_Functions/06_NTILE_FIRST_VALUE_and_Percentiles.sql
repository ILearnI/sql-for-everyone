-- SQL for Everyone: From Zero to Confident
-- Chapter 9: Window Functions
-- Lesson 9.6: NTILE, FIRST_VALUE and Percentiles
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/ntile-first-value-and-percentiles/

-- Window function ntile
SELECT name, price, NTILE(3) OVER (ORDER BY price) AS tier
FROM products
WHERE category = 'Pantry'
ORDER BY price;

-- Window function ntile, Join orders and order_items and s
WITH s AS (
  SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS spent
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.customer_id
)
SELECT quartile, COUNT(*) AS customers, ROUND(AVG(spent)) AS avg_spent
FROM (SELECT spent, NTILE(4) OVER (ORDER BY spent DESC) AS quartile FROM s) t
GROUP BY quartile ORDER BY quartile;

-- Window function first_value, last_value
SELECT name, price,
       FIRST_VALUE(name) OVER (PARTITION BY category ORDER BY price DESC) AS dearest,
       LAST_VALUE(name)  OVER (PARTITION BY category ORDER BY price DESC) AS wrong_last
FROM products
WHERE category = 'Pantry'
ORDER BY price DESC
LIMIT 3;

-- Query products
SELECT ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price)::numeric, 2) AS median,
       ROUND(AVG(price), 2) AS mean,
       PERCENTILE_DISC(0.9) WITHIN GROUP (ORDER BY price) AS p90
FROM products;
