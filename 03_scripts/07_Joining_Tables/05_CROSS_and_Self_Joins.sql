-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.5: CROSS and Self Joins
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/cross-and-self-joins/

-- CROSS JOIN of products
SELECT c.category, s.size
FROM (SELECT DISTINCT category FROM products) c
CROSS JOIN (VALUES ('S'), ('M'), ('L')) AS s(size)
ORDER BY c.category, s.size
LIMIT 6;

-- CROSS JOIN of products
SELECT COUNT(*) AS combinations
FROM (SELECT DISTINCT category FROM products) c
CROSS JOIN (VALUES ('S'), ('M'), ('L')) AS s(size);

-- CROSS JOIN of generate_series
SELECT d::date AS day, ch.channel
FROM generate_series(DATE '2025-01-01', DATE '2025-01-03', INTERVAL '1 day') AS d
CROSS JOIN (VALUES ('web'), ('app'), ('store')) AS ch(channel)
ORDER BY 1, 2
LIMIT 6;

-- LEFT JOIN of employees
SELECT e.first_name AS employee, e.role, m.first_name AS manager
FROM employees e
LEFT JOIN employees m ON m.employee_id = e.manager_id
ORDER BY e.employee_id
LIMIT 5;

-- Join employees
SELECT m.first_name AS manager, COUNT(*) AS direct_reports
FROM employees e
JOIN employees m ON m.employee_id = e.manager_id
GROUP BY m.employee_id, m.first_name
ORDER BY direct_reports DESC
LIMIT 3;

-- CROSS JOIN of customers
SELECT COUNT(*) AS rows_in_cross_join FROM customers a CROSS JOIN customers b;
