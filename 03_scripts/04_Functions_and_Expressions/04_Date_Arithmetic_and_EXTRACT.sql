-- SQL for Everyone: From Zero to Confident
-- Chapter 4: Functions and Expressions
-- Lesson 4.4: Date Arithmetic and EXTRACT
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/date-arithmetic-and-extract/

-- Add and subtract days
SELECT DATE '2025-03-31' + 7 AS plus_week, DATE '2025-03-31' - 31 AS minus_31;

-- Add an INTERVAL (a month at the end of January)
SELECT TIMESTAMP '2025-03-31 09:00' + INTERVAL '2 days 3 hours' AS later,
       DATE '2025-01-31' + INTERVAL '1 month' AS next_month;

-- Days since signup
SELECT customer_id, signup_date, CURRENT_DATE - signup_date AS days_since FROM customers LIMIT 3;

-- Days between two dates, and AGE
SELECT DATE '2025-12-31' - DATE '2025-01-01' AS days_between, AGE(DATE '2025-12-31', DATE '2020-03-15') AS age;

-- EXTRACT pulls out the year, month and weekday
SELECT EXTRACT(year FROM order_date) AS yr, EXTRACT(month FROM order_date) AS mon, EXTRACT(dow FROM order_date) AS weekday
FROM orders LIMIT 3;

-- DATE_TRUNC cuts a timestamp to the start of the month
SELECT order_date, DATE_TRUNC('month', order_date) AS month_start FROM orders LIMIT 3;
