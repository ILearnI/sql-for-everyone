-- SQL for Everyone: From Zero to Confident
-- Chapter 5: Aggregating Data
-- Lesson 5.1: COUNT, SUM, AVG, MIN and MAX
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/count-sum-avg-min-and-max/

-- COUNT(*) counts rows, COUNT(email) skips NULL
SELECT COUNT(*) AS customers, COUNT(email) AS with_email, COUNT(*) - COUNT(email) AS without_email
FROM customers;

-- Several aggregates in one query
SELECT COUNT(*) AS items, SUM(quantity * unit_price) AS revenue,
       ROUND(AVG(quantity * unit_price), 2) AS avg_line, MAX(quantity * unit_price) AS biggest
FROM order_items;

-- The cheapest, the dearest and the average price
SELECT MIN(price) AS cheapest, MAX(price) AS dearest, ROUND(AVG(price), 2) AS average FROM products;

-- COUNT(DISTINCT ...) counts different values
SELECT COUNT(DISTINCT country) AS countries FROM customers;

-- MIN and MAX on dates
SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order FROM orders;

-- SUM on no rows is NULL: COALESCE gives 0
SELECT SUM(price) AS no_match, COALESCE(SUM(price), 0) AS safe FROM products WHERE price > 1000;
