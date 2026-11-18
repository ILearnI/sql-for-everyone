-- SQL for Everyone: From Zero to Confident
-- Chapter 9: Window Functions
-- Lesson 9.8: Frame Types: ROWS, RANGE and GROUPS
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/frame-types-rows-range-and-groups/

-- Window function sum
SELECT name, price,
       SUM(price) OVER (ORDER BY price) AS default_range,
       SUM(price) OVER (ORDER BY price ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_frame,
       SUM(price) OVER (ORDER BY price GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS groups_frame
FROM products
WHERE category = 'Pantry'
ORDER BY price, name;

-- Window function sum
SELECT name, price,
       SUM(price) OVER (ORDER BY price ROWS  BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS rows_pm1,
       SUM(price) OVER (ORDER BY price RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS range_pm1
FROM products
WHERE category = 'Pantry'
ORDER BY price, name;

-- Window function sum
SELECT name, price,
       SUM(price) OVER (ORDER BY price ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
                        EXCLUDE CURRENT ROW) AS neighbours
FROM products
WHERE category = 'Pantry'
ORDER BY price, name
LIMIT 3;

-- Window function sum
SELECT name, price,
       SUM(price) OVER (ORDER BY price, product_id
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS stable_running
FROM products
WHERE category = 'Pantry'
ORDER BY price, product_id;
