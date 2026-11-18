-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.7: UPSERT and RETURNING
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/upsert-and-returning/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table stock_copy from a query
CREATE TABLE stock_copy AS SELECT * FROM product_stock;
ALTER TABLE stock_copy ADD PRIMARY KEY (product_id);

-- Query stock_copy
SELECT COUNT(*) AS in_stock FROM stock_copy;

-- How many staging rows already exist in the stock?
SELECT COUNT(*) AS arriving,
       COUNT(*) FILTER (WHERE product_id IN (SELECT product_id FROM stock_copy)) AS already_known
FROM staging_stock;

-- Insert rows into stock_copy (update on conflict) and return values
INSERT INTO stock_copy (product_id, quantity)
SELECT product_id, quantity FROM staging_stock
ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity
RETURNING product_id, quantity, (xmax = 0) AS inserted;

-- A plain INSERT of an existing product fails
INSERT INTO stock_copy VALUES (1, 5);

-- DO NOTHING skips the existing row
INSERT INTO stock_copy VALUES (1, 5) ON CONFLICT (product_id) DO NOTHING;

-- DO UPDATE adds the new quantity to the old one
INSERT INTO stock_copy VALUES (1, 5)
ON CONFLICT (product_id) DO UPDATE SET quantity = stock_copy.quantity + EXCLUDED.quantity
RETURNING product_id, quantity;
