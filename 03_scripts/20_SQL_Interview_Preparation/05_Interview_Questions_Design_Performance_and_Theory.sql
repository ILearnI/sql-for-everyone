-- SQL for Everyone: From Zero to Confident
-- Chapter 20: SQL Interview Preparation
-- Lesson 20.5: Interview Questions: Design, Performance and Theory
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/interview-questions-design-performance-and-theory/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- The plan: a Seq Scan on orders
EXPLAIN SELECT * FROM orders WHERE customer_id = 99;

-- Create an index on customer_id
CREATE INDEX idx_orders_customer ON orders (customer_id);

-- A function on the column: the Seq Scan is back
EXPLAIN SELECT * FROM orders WHERE customer_id::text = '99';

-- UNION against UNION ALL
SELECT (SELECT COUNT(*) FROM (SELECT country FROM customers UNION SELECT country FROM customers) t) AS union_rows,
       (SELECT COUNT(*) FROM (SELECT country FROM customers UNION ALL SELECT country FROM customers) t) AS union_all_rows;

-- Drop the index
DROP INDEX idx_orders_customer;
