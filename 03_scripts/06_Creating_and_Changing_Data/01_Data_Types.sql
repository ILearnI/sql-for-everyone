-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.1: Data Types
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/data-types/

-- pg_typeof shows the type of different values
SELECT pg_typeof(42) AS whole, pg_typeof(42.5) AS decimal, pg_typeof(TRUE) AS yes_no,
       pg_typeof(DATE '2025-03-31') AS day, pg_typeof(NOW()) AS moment;

-- The biggest integer and the biggest bigint
SELECT 2147483647::integer AS biggest_integer, 9223372036854775807::bigint AS biggest_bigint;

-- Integer overflow: this fails on purpose
SELECT 2147483647::integer + 1;

-- numeric(7,2) keeps two decimals
SELECT 12345.678::numeric(7,2) AS kept_two_decimals;

-- varchar(3) cuts the text to three characters
SELECT 'Maya'::varchar(3) AS cut_to_three;

-- Booleans: true, false, NULL, and text converted to a boolean
SELECT TRUE AS yes, FALSE AS no, NULL::boolean AS unknown, 'yes'::boolean AS from_text;

-- Describe customers (psql command)
\d customers
