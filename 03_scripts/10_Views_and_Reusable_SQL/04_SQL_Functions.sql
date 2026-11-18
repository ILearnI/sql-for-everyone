-- SQL for Everyone: From Zero to Confident
-- Chapter 10: Views and Reusable SQL
-- Lesson 10.4: SQL Functions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/sql-functions/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the function price_after_discount
CREATE FUNCTION price_after_discount(price numeric, pct numeric)
RETURNS numeric LANGUAGE sql IMMUTABLE
AS $$ SELECT ROUND(price * (1 - pct / 100), 2) $$;

-- A query without a table
SELECT price_after_discount(20, 15) AS discounted;

-- Query products
SELECT name, price, price_after_discount(price, 10) AS sale_price
FROM products
ORDER BY price DESC
LIMIT 3;

-- Create the function customer_orders
CREATE FUNCTION customer_orders(cid int)
RETURNS TABLE(order_id int, order_date date, total numeric)
LANGUAGE sql STABLE AS $$
  SELECT o.order_id, o.order_date::date, ROUND(SUM(oi.quantity * oi.unit_price), 2)
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.customer_id = cid
  GROUP BY o.order_id, o.order_date
  ORDER BY o.order_date
$$;

-- Query customer_orders
SELECT * FROM customer_orders(1) LIMIT 3;

-- Query customer_orders
SELECT COUNT(*) AS orders_of_customer_129 FROM customer_orders(129);

-- A psql command
\df price_after_discount

-- Drop the function price_after_discount
DROP FUNCTION price_after_discount(numeric, numeric);
DROP FUNCTION customer_orders(int);
