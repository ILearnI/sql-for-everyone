-- SQL for Everyone: From Zero to Confident
-- Chapter 10: Views and Reusable SQL
-- Lesson 10.6: Triggers
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/triggers/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table price_history
CREATE TABLE price_history (
  id serial PRIMARY KEY, product_id int, old_price numeric, new_price numeric,
  changed_at timestamptz DEFAULT now());

-- Create the function log_price_change
CREATE FUNCTION log_price_change() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.price <> OLD.price THEN
    INSERT INTO price_history (product_id, old_price, new_price)
    VALUES (OLD.product_id, OLD.price, NEW.price);
  END IF;
  RETURN NEW;
END; $$;

-- Create the trigger trg_price_audit
CREATE TRIGGER trg_price_audit
AFTER UPDATE OF price ON products
FOR EACH ROW EXECUTE FUNCTION log_price_change();

-- Update rows in products
UPDATE products SET price = 19.50 WHERE product_id = 1;

-- Query price_history
SELECT product_id, old_price, new_price FROM price_history;

-- Update rows in products
UPDATE products SET price = ROUND(price * 1.10, 2) WHERE category = 'Pantry';
SELECT COUNT(*) AS history_rows FROM price_history;

-- Create the function round_price
CREATE FUNCTION round_price() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN NEW.price := ROUND(NEW.price, 2); RETURN NEW; END; $$;
CREATE TRIGGER trg_round BEFORE INSERT OR UPDATE ON products
FOR EACH ROW EXECUTE FUNCTION round_price();
UPDATE products SET price = 7.777 WHERE product_id = 2;
SELECT product_id, price FROM products WHERE product_id = 2;

-- Query pg_trigger
SELECT tgname, tgenabled FROM pg_trigger WHERE NOT tgisinternal ORDER BY tgname;
