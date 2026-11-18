-- SQL for Everyone: From Zero to Confident
-- Chapter 10: Views and Reusable SQL
-- Lesson 10.5: Stored Procedures and PL/pgSQL
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/stored-procedures-and-pl-pgsql/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the function order_size
CREATE FUNCTION order_size(total numeric) RETURNS text LANGUAGE plpgsql IMMUTABLE AS $$
BEGIN
  IF total >= 200 THEN RETURN 'large';
  ELSIF total >= 50 THEN RETURN 'medium';
  ELSE RETURN 'small';
  END IF;
END; $$;

-- A query without a table
SELECT order_size(20) AS a, order_size(80) AS b, order_size(250) AS c;

-- A subquery on order_items
SELECT order_size(t) AS size, COUNT(*) AS orders
FROM (SELECT SUM(quantity * unit_price) AS t FROM order_items GROUP BY order_id) x
GROUP BY 1 ORDER BY 2 DESC;

-- Create the procedure restock
CREATE PROCEDURE restock(p_product int, p_qty int) LANGUAGE plpgsql AS $$
DECLARE current_qty int;
BEGIN
  SELECT quantity INTO current_qty FROM product_stock WHERE product_id = p_product;
  IF current_qty IS NULL THEN RAISE EXCEPTION 'product % is not in the stock table', p_product; END IF;
  UPDATE product_stock SET quantity = quantity + p_qty WHERE product_id = p_product;
  RAISE NOTICE 'product % restocked: % -> %', p_product, current_qty, current_qty + p_qty;
END; $$;

-- Call a procedure
CALL restock(1, 50);

-- Query product_stock
SELECT product_id, quantity FROM product_stock WHERE product_id = 1;

-- The procedure raises an error for an unknown product
CALL restock(11, 10);

-- Run an anonymous code block
DO $$
DECLARE i int; total int := 0;
BEGIN
  FOR i IN 1..5 LOOP total := total + i; END LOOP;
  RAISE NOTICE 'sum of 1..5 = %', total;
END $$;

-- Run an anonymous code block
DO $$
BEGIN
  CALL restock(999, 1);
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'caught: %', SQLERRM;
END $$;

-- Drop the procedure restock
DROP PROCEDURE restock(int, int);
DROP FUNCTION order_size(numeric);
