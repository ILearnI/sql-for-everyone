-- SQL for Everyone: From Zero to Confident
-- Chapter 8: Subqueries and CTEs
-- Lesson 8.5: Several CTEs and Recursive CTEs
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/several-ctes-and-recursive-ctes/

-- A CTE
WITH monthly AS (
  SELECT date_trunc('month', order_date)::date AS month, COUNT(*) AS n
  FROM orders GROUP BY 1
),
stats AS (
  SELECT ROUND(AVG(n)) AS avg_n FROM monthly
)
SELECT m.month, m.n, s.avg_n
FROM monthly m, stats s
WHERE m.n > s.avg_n * 1.5
ORDER BY m.month;

-- A recursive query
WITH RECURSIVE counter(n) AS (
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM counter WHERE n < 5
)
SELECT n FROM counter;

-- A recursive query
WITH RECURSIVE chain AS (
  SELECT employee_id, first_name, 1 AS depth, first_name::text AS path
  FROM employees WHERE manager_id IS NULL
  UNION ALL
  SELECT e.employee_id, e.first_name, c.depth + 1, c.path || ' > ' || e.first_name
  FROM employees e JOIN chain c ON e.manager_id = c.employee_id
)
SELECT depth, path FROM chain ORDER BY depth, path LIMIT 5;

-- A recursive query
WITH RECURSIVE chain AS (
  SELECT employee_id, 1 AS depth FROM employees WHERE manager_id IS NULL
  UNION ALL
  SELECT e.employee_id, c.depth + 1
  FROM employees e JOIN chain c ON e.manager_id = c.employee_id
)
SELECT depth, COUNT(*) AS employees FROM chain GROUP BY depth ORDER BY depth;
