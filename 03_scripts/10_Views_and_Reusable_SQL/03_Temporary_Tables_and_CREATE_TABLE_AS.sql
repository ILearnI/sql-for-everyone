-- SQL for Everyone: From Zero to Confident
-- Chapter 10: Views and Reusable SQL
-- Lesson 10.3: Temporary Tables and CREATE TABLE AS
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/temporary-tables-and-create-table-as/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table big_orders from a query
CREATE TEMP TABLE big_orders AS
SELECT o.order_id, o.customer_id, ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.customer_id
HAVING SUM(oi.quantity * oi.unit_price) > 100;
SELECT COUNT(*) AS big_orders, ROUND(AVG(total), 2) AS avg_total FROM big_orders;

-- Creating the table twice fails
CREATE TEMP TABLE big_orders AS
SELECT o.order_id, o.customer_id
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.customer_id
HAVING SUM(oi.quantity * oi.unit_price) > 100;
SELECT c.first_name, COUNT(*) AS big_orders
FROM big_orders b JOIN customers c ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.first_name
ORDER BY big_orders DESC, c.first_name LIMIT 3;

-- Query big_orders
SELECT COUNT(*) FROM big_orders;

-- Create the table customer_summary from a query
CREATE TABLE customer_summary AS
SELECT c.customer_id, c.first_name, c.last_name,
       COUNT(DISTINCT o.order_id) AS orders,
       COALESCE(ROUND(SUM(oi.quantity * oi.unit_price)), 0) AS spent
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id;

-- Query customer_summary
SELECT COUNT(*) AS rows_in_summary FROM customer_summary;

-- Query customer_summary
SELECT * FROM customer_summary ORDER BY spent DESC LIMIT 2;

-- Change the table customer_summary
ALTER TABLE customer_summary ADD PRIMARY KEY (customer_id);

-- Describe customer_summary (psql command)
\d customer_summary

-- Drop the table customer_summary
DROP TABLE customer_summary;
