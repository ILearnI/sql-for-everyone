-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.6: UPDATE and DELETE Safely
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/update-and-delete-safely/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table price_list from a query
CREATE TABLE price_list AS
SELECT product_id, name, category, price FROM products;

-- Preview the rows you are about to change
SELECT COUNT(*) AS tea_rows, ROUND(SUM(price), 2) AS tea_total
FROM price_list WHERE category = 'Tea';

-- Update rows in price_list
UPDATE price_list SET price = ROUND(price * 1.05, 2) WHERE category = 'Tea';

-- Check the result
SELECT name, price FROM price_list WHERE category = 'Tea' ORDER BY price LIMIT 3;

-- A transaction: change, check, then ROLLBACK or COMMIT
BEGIN;
UPDATE price_list SET price = 0;
SELECT MIN(price), MAX(price) FROM price_list;
ROLLBACK;
SELECT MIN(price), MAX(price) FROM price_list;

-- Delete rows from price_list and return them
DELETE FROM price_list WHERE category = 'Pantry' RETURNING product_id, name;

-- Query price_list
SELECT COUNT(*) AS rows_left FROM price_list;
