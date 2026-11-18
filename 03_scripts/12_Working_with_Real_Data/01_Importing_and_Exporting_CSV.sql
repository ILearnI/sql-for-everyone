-- SQL for Everyone: From Zero to Confident
-- Chapter 12: Working with Real Data
-- Lesson 12.1: Importing and Exporting CSV
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/importing-and-exporting-csv/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create a staging table: every column is text
CREATE TABLE staging_new_customers (
  first_name text, last_name text, email text, city text, signup_date text);

-- COPY loads the CSV file into it
COPY staging_new_customers FROM '/work/new_customers.csv' WITH (FORMAT csv, HEADER true);

-- How many rows were loaded?
SELECT COUNT(*) AS rows_loaded FROM staging_new_customers;

-- Look at the first rows
SELECT * FROM staging_new_customers LIMIT 3;

-- Parse the dates with to_date
SELECT first_name, signup_date, to_date(signup_date, 'DD/MM/YYYY') AS parsed
FROM staging_new_customers
LIMIT 3;

-- The first and the last signup
SELECT MIN(to_date(signup_date, 'DD/MM/YYYY')) AS first_signup,
       MAX(to_date(signup_date, 'DD/MM/YYYY')) AS last_signup
FROM staging_new_customers;

-- The cities with the most new customers
SELECT city, COUNT(*) AS new_customers
FROM staging_new_customers
GROUP BY city
ORDER BY new_customers DESC, city
LIMIT 5;

-- COPY a query result out to a CSV file
COPY (
  SELECT city, COUNT(*) AS new_customers FROM staging_new_customers
  GROUP BY city ORDER BY new_customers DESC, city LIMIT 5
) TO '/work/top_cities.csv' WITH (FORMAT csv, HEADER true);

-- Read the exported file back
SELECT pg_read_file('/work/top_cities.csv') AS file_content;

-- A table with too few columns: the COPY fails on purpose
CREATE TABLE too_few_columns (first_name text, last_name text);
COPY too_few_columns FROM '/work/new_customers.csv' WITH (FORMAT csv, HEADER true);
