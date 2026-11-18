-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.5: INSERT
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/insert/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table wishlist
CREATE TABLE wishlist (
  wish_id      integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id  integer NOT NULL,
  product_id   integer NOT NULL,
  note         text,
  added_on     date DEFAULT CURRENT_DATE
);

-- Insert one row
INSERT INTO wishlist (customer_id, product_id, note) VALUES (1, 3, 'birthday');

-- Insert three rows with one statement
INSERT INTO wishlist (customer_id, product_id, note)
VALUES (1, 5, 'for work'), (2, 3, NULL), (2, 8, 'gift');

-- Insert the rows returned by a query
INSERT INTO wishlist (customer_id, product_id, note)
SELECT customer_id, 1, 'top seller' FROM customers WHERE country = 'Japan' LIMIT 3;

-- Query wishlist
SELECT * FROM wishlist ORDER BY wish_id;

-- Without a column list the values go by position: this breaks
INSERT INTO wishlist VALUES (99, 1, 1, 'x');

-- A required column is missing: refused
INSERT INTO wishlist (customer_id) VALUES (7);

-- RETURNING gives back the values the database created
INSERT INTO wishlist (customer_id, product_id, note) VALUES (3, 4, 'later') RETURNING wish_id, added_on;
