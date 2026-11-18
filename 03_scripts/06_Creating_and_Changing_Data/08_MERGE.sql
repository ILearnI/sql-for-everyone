-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.8: MERGE
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/merge/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table stock_m from a query
CREATE TABLE stock_m AS SELECT * FROM product_stock;
ALTER TABLE stock_m ADD PRIMARY KEY (product_id);

-- Query stock_m
SELECT COUNT(*) AS before FROM stock_m;

-- Merge rows into stock_m
MERGE INTO stock_m t
USING staging_stock s ON t.product_id = s.product_id
WHEN MATCHED THEN UPDATE SET quantity = s.quantity
WHEN NOT MATCHED THEN INSERT (product_id, quantity) VALUES (s.product_id, s.quantity);

-- Query stock_m
SELECT COUNT(*) AS after FROM stock_m;

-- Merge rows into stock_m
MERGE INTO stock_m t
USING (VALUES (3, 0), (999, 5)) AS s(product_id, quantity) ON t.product_id = s.product_id
WHEN MATCHED AND s.quantity = 0 THEN DELETE
WHEN MATCHED THEN UPDATE SET quantity = s.quantity
WHEN NOT MATCHED THEN INSERT VALUES (s.product_id, s.quantity);

-- Query stock_m
SELECT product_id, quantity FROM stock_m WHERE product_id IN (3, 999) ORDER BY 1;

-- Drop the table stock_m
DROP TABLE stock_m;
