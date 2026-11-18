-- SQL for Everyone: From Zero to Confident
-- Chapter 1: Getting Started
-- Lesson 1.3: Setting Up Your Database (Optional)
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/setting-up-your-database/

-- Count the customers: the first statement you run
SELECT count(*) FROM customers;

-- List the tables (psql command)
\dt

-- Pick two columns and show three rows
SELECT name, price FROM products LIMIT 3;
