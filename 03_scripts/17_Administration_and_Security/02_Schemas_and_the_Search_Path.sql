-- SQL for Everyone: From Zero to Confident
-- Chapter 17: Administration and Security
-- Lesson 17.2: Schemas and the Search Path
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/schemas-and-the-search-path/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- The search path
SHOW search_path;

-- Create two schemas and a table inside one
CREATE SCHEMA staging;
CREATE SCHEMA analytics;
CREATE TABLE staging.new_customers AS SELECT * FROM customer_imports LIMIT 20;

-- List the schemas (\dn)
\dn

-- An unqualified name is not found: the table is not in public
SELECT COUNT(*) FROM new_customers;

-- The qualified name works
SELECT COUNT(*) AS qualified_name FROM staging.new_customers;

-- Add staging to the search path
SET search_path TO staging, public;
SELECT COUNT(*) AS found_without_prefix FROM new_customers;

-- Two tables with the same name: the first schema wins
CREATE TABLE staging.customers AS SELECT * FROM public.customers LIMIT 3;
SET search_path TO staging, public;
SELECT COUNT(*) AS staging_first FROM customers;

-- Put public first: the other table wins
SET search_path TO public, staging;
SELECT COUNT(*) AS public_first FROM customers;

-- Move a table to another schema
ALTER TABLE staging.new_customers SET SCHEMA analytics;
SELECT schemaname, tablename FROM pg_tables WHERE schemaname IN ('staging', 'analytics') ORDER BY 1, 2;

-- Drop a schema that still has a table in it: refused
DROP SCHEMA staging;
