-- SQL for Everyone: From Zero to Confident
-- Chapter 2: Querying Data
-- Lesson 2.6: Writing Readable SQL and Reading Error Messages
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/writing-readable-sql-and-reading-error-messages/

-- A wrong table name on purpose: read the error
SELECT name FROM product;

-- A wrong column name on purpose: read the error and the hint
SELECT nme FROM products;

-- An extra comma on purpose: a syntax error
SELECT name, FROM products;

-- Text without quotes on purpose: read the error
SELECT name FROM products WHERE category = Tea;

-- The fix: text goes in single quotes
SELECT name FROM products WHERE category = 'Tea';
