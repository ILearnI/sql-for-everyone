-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.7: UPDATE FROM, DELETE USING and TRUNCATE
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/update-from-delete-using-and-truncate/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table items_copy from a query
CREATE TABLE items_copy AS SELECT * FROM order_items;
CREATE TABLE prod_copy AS SELECT * FROM products;

-- Query products
SELECT product_id, name FROM products WHERE NOT is_active;

-- Join items_copy and prod_copy
SELECT COUNT(*) AS lines_to_delete
FROM items_copy ic
JOIN prod_copy p ON p.product_id = ic.product_id
WHERE NOT p.is_active;

-- Update rows in prod_copy
UPDATE prod_copy SET price = ROUND(price * 1.05, 2) WHERE category = 'Tea';
UPDATE items_copy ic
SET unit_price = p.price
FROM prod_copy p
WHERE p.product_id = ic.product_id
  AND p.category = 'Tea' AND ic.order_id <= 100;

-- Join items_copy and order_items
SELECT ic.order_item_id, ic.unit_price AS new_price, oi.unit_price AS old_price
FROM items_copy ic
JOIN order_items oi ON oi.order_item_id = ic.order_item_id
WHERE ic.unit_price <> oi.unit_price
ORDER BY 1
LIMIT 3;

-- A CTE
WITH removed AS (
  DELETE FROM items_copy ic
  USING prod_copy p
  WHERE p.product_id = ic.product_id AND NOT p.is_active
  RETURNING ic.order_item_id
)
SELECT COUNT(*) AS deleted FROM removed;

-- Query items_copy
SELECT COUNT(*) AS lines_left FROM items_copy;

-- Empty the table items_copy
TRUNCATE items_copy;
SELECT COUNT(*) AS lines_after_truncate FROM items_copy;

-- Drop the table items_copy
DROP TABLE items_copy, prod_copy;
