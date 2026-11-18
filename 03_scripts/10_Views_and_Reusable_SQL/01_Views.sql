-- SQL for Everyone: From Zero to Confident
-- Chapter 10: Views and Reusable SQL
-- Lesson 10.1: Views
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/views/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the view customer_spend
CREATE VIEW customer_spend AS
SELECT c.customer_id, c.first_name, c.last_name, c.country,
       COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS spent,
       COUNT(DISTINCT o.order_id) AS orders
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id;

-- Query customer_spend
SELECT first_name, last_name, ROUND(spent) AS spent, orders
FROM customer_spend
ORDER BY spent DESC
LIMIT 3;

-- Group customer_spend
SELECT country, COUNT(*) AS customers, ROUND(AVG(spent)) AS avg_spent
FROM customer_spend
GROUP BY country
ORDER BY customers DESC
LIMIT 3;

-- Query customer_spend
SELECT COUNT(*) AS never_ordered FROM customer_spend WHERE orders = 0;

-- Create the view customer_spend (or replace it)
CREATE OR REPLACE VIEW customer_spend AS
SELECT c.customer_id, c.first_name, c.last_name, c.country,
       COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS spent,
       COUNT(DISTINCT o.order_id) AS orders,
       MAX(o.order_date)::date AS last_order
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id;

-- Query customer_spend
SELECT first_name, last_order FROM customer_spend WHERE customer_id IN (1, 10) ORDER BY customer_id;

-- Drop the view customer_spend
DROP VIEW customer_spend;
