-- SQL for Everyone: From Zero to Confident
-- Chapter 2: Querying Data
-- Lesson 2.1: SELECT and FROM
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/select-and-from/

-- Two columns, name first
SELECT name, price FROM products LIMIT 8;

-- The same two columns in the opposite order: the result follows your list
SELECT price, name FROM products LIMIT 8;

-- Three columns from customers
SELECT first_name, last_name, email FROM customers LIMIT 8;

-- A small table, so the star shows it all
SELECT * FROM price_bands;

-- A misspelled column on purpose (nme): read the error and the hint
SELECT name, nme FROM products;
