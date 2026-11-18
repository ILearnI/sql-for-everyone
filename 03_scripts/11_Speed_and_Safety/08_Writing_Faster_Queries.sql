-- SQL for Everyone: From Zero to Confident
-- Chapter 11: Speed and Safety
-- Lesson 11.8: Writing Faster Queries
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/writing-faster-queries/

-- SELECT * reads every column
EXPLAIN SELECT * FROM events_log;

-- Only the column you need
EXPLAIN SELECT event_id FROM events_log;

-- A correlated subquery in the select list
EXPLAIN (COSTS OFF)
SELECT c.first_name, (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) AS orders
FROM customers c;

-- The same result with a join and GROUP BY
EXPLAIN (COSTS OFF)
SELECT c.first_name, COUNT(o.order_id) AS orders
FROM customers c LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id;

-- UNION removes duplicates, which costs extra work
EXPLAIN (COSTS OFF) SELECT customer_id FROM orders UNION SELECT customer_id FROM customers;

-- UNION ALL skips that work
EXPLAIN (COSTS OFF) SELECT customer_id FROM orders UNION ALL SELECT customer_id FROM customers;

-- OFFSET reads and discards all the rows before it
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF, SUMMARY OFF)
SELECT * FROM events_log ORDER BY event_id OFFSET 150000 LIMIT 10;

-- Keyset paging: a condition on the key instead of OFFSET
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF, SUMMARY OFF)
SELECT * FROM events_log WHERE event_id > 150000 ORDER BY event_id LIMIT 10;
