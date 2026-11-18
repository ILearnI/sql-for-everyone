-- SQL for Everyone: From Zero to Confident
-- Chapter 1: Getting Started
-- Lesson 1.2: What Is SQL?
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/what-is-sql/

-- The five most expensive products over 10: one question, written as SQL
SELECT name, category, price
FROM products
WHERE price > 10
ORDER BY price DESC
LIMIT 5;
