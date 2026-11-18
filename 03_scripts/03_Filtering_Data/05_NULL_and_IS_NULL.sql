-- SQL for Everyone: From Zero to Confident
-- Chapter 3: Filtering Data
-- Lesson 3.5: NULL and IS NULL
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/null-and-is-null/

-- IS NULL finds the missing emails
SELECT first_name, email FROM customers WHERE email IS NULL LIMIT 5;

-- = NULL never matches: this returns nothing
SELECT first_name, email FROM customers WHERE email = NULL;

-- IS NOT NULL finds the customers with an email
SELECT first_name, last_name FROM customers WHERE email IS NOT NULL LIMIT 5;

-- Combine IS NULL with another condition
SELECT first_name, city FROM customers
WHERE email IS NULL AND country = 'Japan';

-- 1 = NULL gives NULL, while NULL IS NULL gives true
SELECT 1 = NULL AS equals_null, NULL IS NULL AS is_null;
