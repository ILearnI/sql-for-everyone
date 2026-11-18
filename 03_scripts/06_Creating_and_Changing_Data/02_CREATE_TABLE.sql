-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.2: CREATE TABLE
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/create-table/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the table suppliers
CREATE TABLE suppliers (
  supplier_id  integer PRIMARY KEY,
  name         text NOT NULL,
  country      text,
  rating       numeric(3,1),
  active       boolean DEFAULT true,
  added_on     date DEFAULT CURRENT_DATE
);

-- Describe suppliers (psql command)
\d suppliers

-- Query suppliers
SELECT * FROM suppliers;

-- Creating it again fails: the table already exists
CREATE TABLE suppliers (id integer);

-- IF NOT EXISTS skips it without an error
CREATE TABLE IF NOT EXISTS suppliers (id integer);

-- List the tables (psql command)
\dt

-- Drop the table suppliers
DROP TABLE suppliers;
