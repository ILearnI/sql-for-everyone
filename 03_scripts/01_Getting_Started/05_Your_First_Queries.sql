-- SQL for Everyone: From Zero to Confident
-- Chapter 1: Getting Started
-- Lesson 1.5: Your First Queries
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/your-first-queries/

-- Look at the first rows of products
SELECT * FROM products LIMIT 5;

-- Choose the columns you want
SELECT name, price FROM products LIMIT 5;

-- Same idea on another table, written over three lines
SELECT first_name, last_name, city
FROM customers
LIMIT 5;

-- Look at the first rows of orders
SELECT * FROM orders LIMIT 5;

-- A typo on purpose (SELEC): run it to read the error message
SELEC * FROM products;
