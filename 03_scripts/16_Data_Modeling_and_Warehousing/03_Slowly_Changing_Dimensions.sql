-- SQL for Everyone: From Zero to Confident
-- Chapter 16: Data Modeling and Warehousing
-- Lesson 16.3: Slowly Changing Dimensions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/slowly-changing-dimensions/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- A customer dimension with validity dates
CREATE TABLE dim_customer AS
SELECT customer_id, first_name || ' ' || last_name AS name, city, country,
       DATE '2024-01-01' AS valid_from, DATE '9999-12-31' AS valid_to, true AS is_current
FROM customers WHERE customer_id IN (1, 2, 3);

-- Look at the dimension
SELECT customer_id, name, city FROM dim_customer ORDER BY customer_id;

-- Type 1: overwrite the city (the history is lost)
UPDATE dim_customer SET city = 'Bristol' WHERE customer_id = 3;
SELECT customer_id, name, city FROM dim_customer WHERE customer_id = 3;

-- Type 2: close the old row and add the new version
UPDATE dim_customer SET valid_to = DATE '2025-06-30', is_current = false WHERE customer_id = 1 AND is_current;
INSERT INTO dim_customer
SELECT customer_id, name, 'Lyon', country, DATE '2025-07-01', DATE '9999-12-31', true
FROM dim_customer WHERE customer_id = 1 AND NOT is_current;
SELECT customer_id, name, city, valid_from, valid_to, is_current FROM dim_customer WHERE customer_id = 1 ORDER BY valid_from;

-- Which city was it on a given date?
SELECT 'in March 2025' AS question, city FROM dim_customer WHERE customer_id = 1 AND DATE '2025-03-15' BETWEEN valid_from AND valid_to
UNION ALL
SELECT 'in September 2025', city FROM dim_customer WHERE customer_id = 1 AND DATE '2025-09-01' BETWEEN valid_from AND valid_to;

-- Type 3: keep only the previous value in a column
ALTER TABLE dim_customer ADD COLUMN previous_city text;
UPDATE dim_customer SET previous_city = city, city = 'York' WHERE customer_id = 2;
SELECT customer_id, name, city, previous_city FROM dim_customer WHERE customer_id = 2;
