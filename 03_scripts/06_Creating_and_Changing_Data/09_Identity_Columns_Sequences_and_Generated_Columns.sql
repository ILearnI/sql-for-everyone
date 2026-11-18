-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.9: Identity Columns, Sequences and Generated Columns
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/identity-columns-sequences-and-generated-columns/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table loyalty_cards
CREATE TABLE loyalty_cards (
  card_id      integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  card_number  text GENERATED ALWAYS AS ('BH-' || lpad(card_id::text, 6, '0')) STORED,
  customer_id  integer NOT NULL,
  points       integer DEFAULT 0,
  tier         text GENERATED ALWAYS AS (
                 CASE WHEN points >= 1000 THEN 'gold'
                      WHEN points >= 500  THEN 'silver'
                      ELSE 'bronze' END) STORED
);

-- Insert rows into loyalty_cards and return values
INSERT INTO loyalty_cards (customer_id, points)
VALUES (1, 120), (2, 640), (3, 1500)
RETURNING *;

-- Update rows in loyalty_cards and return them
UPDATE loyalty_cards SET points = 520 WHERE card_id = 1
RETURNING card_number, points, tier;

-- A manual id is refused with GENERATED ALWAYS
INSERT INTO loyalty_cards (card_id, customer_id) VALUES (50, 4);

-- A generated column cannot be inserted
INSERT INTO loyalty_cards (customer_id, points, card_number) VALUES (9, 1, 'X');

-- Create the sequence invoice_no
CREATE SEQUENCE invoice_no START 1000 INCREMENT 5;

-- A sequence hands out numbers: 1000, then 1005
SELECT nextval('invoice_no') AS first, nextval('invoice_no') AS second;

-- Insert rows into loyalty_cards and return values
INSERT INTO loyalty_cards (customer_id) VALUES (8) RETURNING card_id, card_number;

-- Drop the table loyalty_cards
DROP TABLE loyalty_cards;
DROP SEQUENCE invoice_no;
