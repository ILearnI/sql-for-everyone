-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.4: Constraints
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/constraints/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table coupons
CREATE TABLE coupons (
  coupon_id     integer PRIMARY KEY,
  code          text NOT NULL UNIQUE,
  discount_pct  integer NOT NULL CHECK (discount_pct BETWEEN 1 AND 90),
  min_order     numeric(7,2) DEFAULT 0 CHECK (min_order >= 0),
  expires_on    date
);

-- Insert rows into coupons
INSERT INTO coupons (coupon_id, code, discount_pct) VALUES (1, 'WELCOME10', 10);

-- Query coupons
SELECT * FROM coupons;

-- NULL in a NOT NULL column is refused
INSERT INTO coupons (coupon_id, code, discount_pct) VALUES (2, NULL, 10);

-- A duplicate code is refused (UNIQUE)
INSERT INTO coupons (coupon_id, code, discount_pct) VALUES (3, 'WELCOME10', 5);

-- A discount of 150 is refused (CHECK)
INSERT INTO coupons (coupon_id, code, discount_pct) VALUES (4, 'BIGSALE', 150);

-- Change the table coupons
ALTER TABLE coupons ADD CONSTRAINT code_not_blank CHECK (length(trim(code)) > 0);

-- A blank code is refused by the new CHECK
INSERT INTO coupons (coupon_id, code, discount_pct) VALUES (5, '   ', 5);

-- Describe coupons (psql command)
\d coupons
