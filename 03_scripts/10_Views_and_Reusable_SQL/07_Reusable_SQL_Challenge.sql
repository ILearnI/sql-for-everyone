-- SQL for Everyone: From Zero to Confident
-- Chapter 10: Views and Reusable SQL
-- Lesson 10.7: Reusable SQL Challenge
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/reusable-sql-challenge/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the view v_order_totals
CREATE VIEW v_order_totals AS
SELECT o.order_id, o.customer_id, o.status, ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id;

-- Query v_order_totals
SELECT COUNT(*) AS orders_over_400 FROM v_order_totals WHERE total > 400;

-- Create the function with_tax
CREATE FUNCTION with_tax(amount numeric, rate numeric DEFAULT 20)
RETURNS numeric LANGUAGE sql IMMUTABLE
AS $$ SELECT ROUND(amount * (1 + rate / 100), 2) $$;

-- Query v_order_totals
SELECT order_id, total, with_tax(total) AS gross
FROM v_order_totals
ORDER BY total DESC
LIMIT 2;

-- Create the table order_status_log
CREATE TABLE order_status_log (
  id serial PRIMARY KEY, order_id int, old_status text, new_status text,
  changed_at timestamptz DEFAULT now());
CREATE FUNCTION log_status() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.status IS DISTINCT FROM OLD.status THEN
    INSERT INTO order_status_log (order_id, old_status, new_status)
    VALUES (OLD.order_id, OLD.status, NEW.status);
  END IF;
  RETURN NEW;
END; $$;
CREATE TRIGGER trg_status AFTER UPDATE OF status ON orders
FOR EACH ROW EXECUTE FUNCTION log_status();

-- Update rows in orders
UPDATE orders SET status = 'refunded' WHERE order_id = 1;
SELECT order_id, old_status, new_status FROM order_status_log;
