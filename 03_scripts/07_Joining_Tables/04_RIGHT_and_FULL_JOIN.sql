-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.4: RIGHT and FULL JOIN
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/right-and-full-join/

-- Join product_stock and staging_stock
SELECT COUNT(*) AS matched
FROM product_stock s
JOIN staging_stock t ON t.product_id = s.product_id;

-- LEFT JOIN of product_stock and staging_stock
SELECT COUNT(*) AS left_rows
FROM product_stock s
LEFT JOIN staging_stock t ON t.product_id = s.product_id;

-- RIGHT JOIN of product_stock and staging_stock
SELECT COUNT(*) AS right_rows
FROM product_stock s
RIGHT JOIN staging_stock t ON t.product_id = s.product_id;

-- FULL JOIN of product_stock and staging_stock
SELECT COUNT(*) AS full_rows
FROM product_stock s
FULL JOIN staging_stock t ON t.product_id = s.product_id;

-- FULL JOIN of product_stock and staging_stock
SELECT COALESCE(s.product_id, t.product_id) AS product_id,
       s.quantity AS stock_qty, t.quantity AS delivery_qty,
       CASE WHEN s.product_id IS NULL THEN 'new'
            WHEN t.product_id IS NULL THEN 'not in delivery'
            ELSE 'update' END AS action
FROM product_stock s
FULL JOIN staging_stock t ON t.product_id = s.product_id
WHERE s.product_id IS NULL OR t.product_id IS NULL
ORDER BY 1
LIMIT 6;
