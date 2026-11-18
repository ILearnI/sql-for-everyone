-- SQL for Everyone: From Zero to Confident
-- Chapter 17: Administration and Security
-- Lesson 17.3: Users, Roles and GRANT
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/users-roles-and-grant/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create a login role and a group role, then grant privileges
CREATE ROLE analyst LOGIN PASSWORD 'change-me';
CREATE ROLE readers NOLOGIN;
GRANT readers TO analyst;
GRANT USAGE ON SCHEMA public TO readers;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readers;

-- List the roles (\du)
\du

-- Act as the analyst and read
SET ROLE analyst;
SELECT COUNT(*) AS customers_the_analyst_can_read FROM customers;

-- The analyst cannot delete: refused
SET ROLE analyst;
DELETE FROM customers WHERE customer_id = 1;

-- The analyst cannot insert: refused
SET ROLE analyst;
INSERT INTO products (product_id, name, category, price, cost) VALUES (999, 'x', 'Tea', 1, 1);

-- The analyst cannot create tables: refused
SET ROLE analyst;
CREATE TABLE public.mine (id int);

-- Ask for privileges without logging in
SELECT has_table_privilege('analyst', 'customers', 'SELECT') AS can_select,
       has_table_privilege('analyst', 'customers', 'DELETE') AS can_delete;

-- Column privileges: revoke, then grant three columns
REVOKE SELECT ON customers FROM readers;
GRANT SELECT (customer_id, first_name, country) ON customers TO readers;

-- Reading the allowed columns works
SET ROLE analyst;
SELECT first_name, country FROM customers LIMIT 2;

-- Reading another column is refused
SET ROLE analyst;
SELECT email FROM customers LIMIT 1;
