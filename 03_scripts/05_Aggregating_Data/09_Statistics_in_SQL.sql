-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.9: Statistics in SQL
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/statistics-in-sql/

-- Mean, median and 90th percentile
SELECT ROUND(AVG(quantity * unit_price), 2) AS mean,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY quantity * unit_price) AS median,
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY quantity * unit_price) AS p90
FROM order_items;

-- Median and mean per category
SELECT category,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median,
       ROUND(AVG(price), 2) AS mean
FROM products
GROUP BY category
ORDER BY category;

-- Several percentiles at once: the quartiles
SELECT PERCENTILE_CONT(ARRAY[0.25, 0.5, 0.75]) WITHIN GROUP (ORDER BY price) AS quartiles FROM products;

-- Standard deviation and variance
SELECT ROUND(STDDEV(quantity * unit_price), 2) AS stddev,
       ROUND(VARIANCE(quantity * unit_price), 1) AS variance
FROM order_items;

-- CORR: how closely two columns move together
SELECT ROUND(CORR(price, cost)::numeric, 3) AS price_vs_cost FROM products;

-- MODE: the most common value
SELECT MODE() WITHIN GROUP (ORDER BY quantity) AS most_common_quantity FROM order_items;
