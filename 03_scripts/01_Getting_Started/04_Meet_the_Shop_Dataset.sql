-- SQL for Everyone: From Zero to Confident
-- Chapter 1: Getting Started
-- Lesson 1.4: Meet the Shop Dataset
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/meet-the-shop-dataset/

-- List the tables (psql command)
\dt

-- Describe one table: its columns, types and keys (psql command)
\d customers

-- Look at the first rows of products
SELECT * FROM products LIMIT 5;

-- Look at employees: see how manager_id points to another employee
SELECT * FROM employees LIMIT 5;

-- Look at the first rows of orders
SELECT * FROM orders LIMIT 5;

-- Look at the first rows of order_items
SELECT * FROM order_items LIMIT 5;
