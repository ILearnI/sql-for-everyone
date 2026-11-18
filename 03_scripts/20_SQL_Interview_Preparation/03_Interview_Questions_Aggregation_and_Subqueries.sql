-- SQL for Everyone: From Zero to Confident
-- Chapter 20: SQL Interview Preparation
-- Lesson 20.3: Interview Questions: Aggregation and Subqueries
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/interview-questions-aggregation-and-subqueries/

-- OFFSET against DENSE_RANK for the third-highest salary
SELECT (SELECT salary FROM employees ORDER BY salary DESC OFFSET 2 LIMIT 1) AS offset_gives,
       (SELECT salary FROM (SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS r FROM employees) t WHERE r = 3 LIMIT 1) AS third_highest;

-- Employees above their department average
SELECT e.first_name, e.department, e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(x.salary) FROM employees x WHERE x.department = e.department)
ORDER BY e.department, e.salary DESC LIMIT 4;

-- How many are above their department average?
SELECT COUNT(*) AS above_own_department_average
FROM employees e WHERE salary > (SELECT AVG(x.salary) FROM employees x WHERE x.department = e.department);

-- Mean against median order value
WITH t AS (SELECT SUM(quantity * unit_price) AS total FROM order_items GROUP BY order_id)
SELECT ROUND(AVG(total), 2) AS mean, ROUND(percentile_cont(0.5) WITHIN GROUP (ORDER BY total)::numeric, 2) AS median FROM t;

-- The median by hand, with ROW_NUMBER
WITH t AS (
  SELECT SUM(quantity * unit_price) AS total, ROW_NUMBER() OVER (ORDER BY SUM(quantity * unit_price)) AS rn, COUNT(*) OVER () AS n
  FROM order_items GROUP BY order_id
)
SELECT ROUND(AVG(total), 2) AS median_by_hand FROM t WHERE rn IN ((n + 1) / 2, (n + 2) / 2);

-- Departments with an average salary above 70,000
SELECT department, COUNT(*) AS employees, ROUND(AVG(salary)) AS average_salary
FROM employees GROUP BY department HAVING AVG(salary) > 70000 ORDER BY average_salary DESC;

-- Customers with more orders than the average customer
SELECT COUNT(*) AS customers_above_average_orders FROM customers c
WHERE (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) > (SELECT AVG(n) FROM (SELECT COUNT(*) AS n FROM orders GROUP BY customer_id) t);

-- The second-highest customer total
WITH t AS (SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS total FROM orders o JOIN order_items oi ON oi.order_id = o.order_id GROUP BY o.customer_id)
SELECT MAX(total) AS second_highest_total FROM t WHERE total < (SELECT MAX(total) FROM t);

-- Products that were never sold (NOT EXISTS)
SELECT COUNT(*) AS products_never_sold FROM products p WHERE NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.product_id = p.product_id);

-- The category with the most products (ties included)
SELECT category, COUNT(*) AS products FROM products GROUP BY category
HAVING COUNT(*) = (SELECT MAX(c) FROM (SELECT COUNT(*) AS c FROM products GROUP BY category) t);
