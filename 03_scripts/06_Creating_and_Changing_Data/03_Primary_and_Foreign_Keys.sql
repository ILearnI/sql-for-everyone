-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.3: Primary and Foreign Keys
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/primary-and-foreign-keys/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table brands
CREATE TABLE brands (
  brand_id integer PRIMARY KEY,
  name     text NOT NULL
);
CREATE TABLE brand_products (
  product_id integer PRIMARY KEY,
  brand_id   integer REFERENCES brands (brand_id),
  title      text
);

-- Insert rows into brands
INSERT INTO brands VALUES (1, 'Brewhouse Reserve'), (2, 'Daily Blend');

-- Insert rows into brand_products
INSERT INTO brand_products VALUES (10, 1, 'Reserve Beans');

-- A duplicate primary key is refused
INSERT INTO brands VALUES (1, 'Duplicate');

-- An unknown brand is refused by the foreign key
INSERT INTO brand_products VALUES (11, 99, 'Ghost Product');

-- Deleting a brand that products use is refused
DELETE FROM brands WHERE brand_id = 1;

-- Change the key to ON DELETE CASCADE
ALTER TABLE brand_products
  DROP CONSTRAINT brand_products_brand_id_fkey,
  ADD FOREIGN KEY (brand_id) REFERENCES brands (brand_id) ON DELETE CASCADE;

-- Count the products that are left
SELECT COUNT(*) AS products_left FROM brand_products;
