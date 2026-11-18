-- SQL for Everyone: From Zero to Confident
-- Chapter 4: Functions and Expressions
-- Lesson 4.1: String Functions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/string-functions/

-- UPPER and LOWER change the case
SELECT first_name, UPPER(first_name), LOWER(last_name) FROM customers LIMIT 5;

-- INITCAP fixes names written in capitals
SELECT INITCAP(first_name) AS first, INITCAP(last_name) AS last
FROM customers
WHERE first_name = UPPER(first_name)
LIMIT 4;

-- LENGTH counts characters: the longest product names
SELECT name, LENGTH(name) FROM products ORDER BY LENGTH(name) DESC LIMIT 4;

-- TRIM removes spaces: names with extra spaces
SELECT first_name, LENGTH(first_name) AS raw_len, LENGTH(TRIM(first_name)) AS clean_len
FROM customers
WHERE first_name <> TRIM(first_name)
LIMIT 5;

-- SUBSTRING and LEFT take the first characters
SELECT name, SUBSTRING(name, 1, 4) AS first4, LEFT(name, 3) AS first3 FROM products LIMIT 5;

-- REPLACE swaps one piece of text for another
SELECT name, REPLACE(name, 'Tin', 'Box') AS relabelled FROM products WHERE name LIKE '%Tin';

-- SPLIT_PART takes the domain of an email
SELECT email, SPLIT_PART(email, '@', 2) AS domain FROM customers WHERE email IS NOT NULL LIMIT 3;

-- || gives NULL when a part is NULL, CONCAT skips it
SELECT 'Maya' || ' ' || NULL AS pipes, CONCAT('Maya', ' ', NULL) AS concat;
