-- SQL for Everyone: From Zero to Confident
-- Chapter 2: Querying Data
-- Lesson 2.3: DISTINCT
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/distinct/

-- One row per different category
SELECT DISTINCT category FROM products;

-- One row per different country
SELECT DISTINCT country FROM customers;

-- DISTINCT on two columns removes repeated pairs
SELECT DISTINCT country, city FROM customers LIMIT 8;

-- Count all the values, then only the different ones
SELECT count(country) AS all_rows, count(DISTINCT country) AS different FROM customers;
