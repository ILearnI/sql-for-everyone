-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.8: UNION, INTERSECT and EXCEPT
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/union-intersect-and-except/

-- UNION of two queries
SELECT category FROM products
UNION
SELECT 'Gift'
ORDER BY category;

-- UNION of two queries
SELECT COUNT(*) AS union_rows FROM (
  SELECT customer_id FROM orders WHERE order_date <  '2025-01-01'
  UNION
  SELECT customer_id FROM orders WHERE order_date >= '2025-01-01') t;

-- UNION ALL of two queries
SELECT COUNT(*) AS union_all_rows FROM (
  SELECT customer_id FROM orders WHERE order_date <  '2025-01-01'
  UNION ALL
  SELECT customer_id FROM orders WHERE order_date >= '2025-01-01') t;

-- INTERSECT of two queries
SELECT COUNT(*) AS in_both_years FROM (
  SELECT DISTINCT customer_id FROM orders WHERE order_date <  '2025-01-01'
  INTERSECT
  SELECT DISTINCT customer_id FROM orders WHERE order_date >= '2025-01-01') t;

-- EXCEPT of two queries
SELECT COUNT(*) AS new_in_2025 FROM (
  SELECT DISTINCT customer_id FROM orders WHERE order_date >= '2025-01-01'
  EXCEPT
  SELECT DISTINCT customer_id FROM orders WHERE order_date <  '2025-01-01') t;

-- UNION ALL of two queries
SELECT name AS label, 'product' AS kind FROM products WHERE price > 50
UNION ALL
SELECT role, 'employee' FROM employees WHERE role LIKE 'Head%'
ORDER BY kind, label;

-- The columns of both queries must have matching types
SELECT 1 AS a, 'x' AS b
UNION
SELECT 2, 3;
