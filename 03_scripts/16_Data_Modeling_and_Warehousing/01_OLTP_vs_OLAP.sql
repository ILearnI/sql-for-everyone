-- SQL for Everyone: From Zero to Confident
-- Chapter 16: Data Modeling and Warehousing
-- Lesson 16.1: OLTP vs. OLAP
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/oltp-vs-olap/

-- A lookup by key: one row, read with an index
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF, SUMMARY OFF) SELECT * FROM orders WHERE order_id = 4242;

-- The same lookup, plain
SELECT order_id, customer_id, status FROM orders WHERE order_id = 4242;

-- An analytical query: scan and aggregate every order line
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF, SUMMARY OFF)
SELECT p.category, SUM(oi.quantity * oi.unit_price)
FROM order_items oi JOIN products p ON p.product_id = oi.product_id
GROUP BY p.category;

-- The result of that query
SELECT p.category, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
FROM order_items oi JOIN products p ON p.product_id = oi.product_id
GROUP BY p.category ORDER BY revenue DESC;

-- The size of the main tables
SELECT relname AS table_name, pg_size_pretty(pg_total_relation_size(oid)) AS size, reltuples::bigint AS rows
FROM pg_class
WHERE relname IN ('customers', 'orders', 'order_items', 'products', 'events_log')
ORDER BY pg_total_relation_size(oid) DESC;
