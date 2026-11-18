-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.11: ALTER TABLE and DROP
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/alter-table-and-drop/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table gift_cards
CREATE TABLE gift_cards (
  card_id  integer PRIMARY KEY,
  code     text NOT NULL,
  balance  numeric(7,2)
);
INSERT INTO gift_cards VALUES (1, 'GC-1', 25), (2, 'GC-2', 50);

-- Add a column with a default
ALTER TABLE gift_cards ADD COLUMN issued_on date DEFAULT CURRENT_DATE;

-- Add a NOT NULL column with no default: fails when rows exist
ALTER TABLE gift_cards ADD COLUMN currency char(3) NOT NULL;

-- Add it with a default: this works
ALTER TABLE gift_cards ADD COLUMN currency char(3) NOT NULL DEFAULT 'USD';

-- Rename a column
ALTER TABLE gift_cards RENAME COLUMN code TO card_code;

-- Change a column type
ALTER TABLE gift_cards ALTER COLUMN balance TYPE numeric(9,2);

-- Change text to integer: PostgreSQL needs USING
ALTER TABLE gift_cards ALTER COLUMN card_code TYPE integer;

-- Drop a column
ALTER TABLE gift_cards DROP COLUMN issued_on;

-- Describe gift_cards (psql command)
\d gift_cards

-- Empty the table gift_cards
TRUNCATE gift_cards;

-- Query gift_cards
SELECT COUNT(*) AS rows_left FROM gift_cards;

-- Drop the table gift_cards
DROP TABLE IF EXISTS gift_cards;
