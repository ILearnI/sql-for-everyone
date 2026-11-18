-- SQL for Everyone: From Zero to Confident
-- Chapter 20: SQL Interview Preparation
-- Lesson 20.2: Interview Questions: Basics and Joins
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/interview-questions-basics-and-joins/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Brackets change the answer: AND binds tighter than OR
SELECT (SELECT COUNT(*) FROM customers WHERE country = 'UK' OR country = 'Canada' AND signup_date >= '2025-01-01') AS without_brackets,
       (SELECT COUNT(*) FROM customers WHERE (country = 'UK' OR country = 'Canada') AND signup_date >= '2025-01-01') AS with_brackets;

-- NULL: = NULL finds nothing, IS NULL works
SELECT COUNT(*) FILTER (WHERE email = NULL) AS equals_null, COUNT(*) FILTER (WHERE email IS NULL) AS is_null,
       COUNT(*) FILTER (WHERE email <> 'x@y.com') AS not_equal, COUNT(*) FILTER (WHERE email IS DISTINCT FROM 'x@y.com') AS is_distinct_from
FROM customers;

-- Count the duplicates: same email, different capitals
SELECT COUNT(*) AS rows, COUNT(DISTINCT lower(email)) AS people, COUNT(*) - COUNT(DISTINCT lower(email)) AS extra_rows FROM customer_imports;

-- Delete the duplicates in a copy, keeping the first row of each email
CREATE TABLE imports_copy AS SELECT * FROM customer_imports;
WITH r AS (
  SELECT import_id, ROW_NUMBER() OVER (PARTITION BY lower(email) ORDER BY import_id) AS rn FROM imports_copy
)
DELETE FROM imports_copy c USING r WHERE r.import_id = c.import_id AND r.rn > 1;

-- Rows left after the delete
SELECT COUNT(*) AS rows_left FROM imports_copy;

-- Customers who never ordered (LEFT JOIN, then IS NULL)
SELECT COUNT(*) AS never_ordered FROM customers c LEFT JOIN orders o ON o.customer_id = c.customer_id WHERE o.order_id IS NULL;

-- COUNT(*) against COUNT(o.order_id) after a LEFT JOIN
SELECT c.customer_id, COUNT(*) AS wrong_count, COUNT(o.order_id) AS right_count
FROM customers c LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE c.customer_id = 10 GROUP BY c.customer_id;

-- A self join: each employee with their manager
SELECT e.first_name || ' ' || e.last_name AS employee, COALESCE(m.first_name || ' ' || m.last_name, '(none)') AS manager
FROM employees e LEFT JOIN employees m ON m.employee_id = e.manager_id
ORDER BY e.employee_id LIMIT 3;

-- Customers who ordered in both years
SELECT COUNT(*) AS ordered_in_both_years FROM (
  SELECT customer_id FROM orders GROUP BY customer_id
  HAVING MIN(order_date) < '2025-01-01' AND MAX(order_date) >= '2025-01-01'
) t;
