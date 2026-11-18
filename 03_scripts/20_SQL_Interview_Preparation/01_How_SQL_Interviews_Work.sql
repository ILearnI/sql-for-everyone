-- SQL for Everyone: From Zero to Confident
-- Chapter 20: SQL Interview Preparation
-- Lesson 20.1: How SQL Interviews Work
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/how-sql-interviews-work/

-- List the tables (psql command)
\dt

-- Describe employees (psql command)
\d employees

-- Query employees
SELECT * FROM employees ORDER BY employee_id LIMIT 4;

-- Query employees
SELECT COUNT(*) AS rows, COUNT(DISTINCT department) AS departments, COUNT(salary) AS salaries_present FROM employees;

-- Group employees
SELECT salary, COUNT(*) AS employees FROM employees GROUP BY salary HAVING COUNT(*) > 1 ORDER BY salary DESC LIMIT 3;
