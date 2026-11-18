-- SQL for Everyone: From Zero to Confident
-- Chapter 3: Filtering Data
-- Lesson 3.4: LIKE and ILIKE
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/like-and-ilike/

-- % matches any number of characters: names starting with Cold
SELECT name FROM products WHERE name LIKE 'Cold%';

-- _ matches exactly one character: three-character size codes
SELECT name FROM products WHERE name LIKE 'Cold Brew ___';

-- % on both sides: names containing Beans
SELECT name FROM products WHERE name LIKE '%Beans%';

-- LIKE is case-sensitive: 'cold%' finds nothing
SELECT name FROM products WHERE name LIKE 'cold%';

-- ILIKE ignores the case
SELECT name FROM products WHERE name ILIKE 'cold%';

-- Emails ending with @gmail.com
SELECT first_name, email FROM customers WHERE email ILIKE '%@gmail.com' LIMIT 5;
