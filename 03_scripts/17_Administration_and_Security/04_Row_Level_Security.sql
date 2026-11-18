-- SQL for Everyone: From Zero to Confident
-- Chapter 17: Administration and Security
-- Lesson 17.4: Row-Level Security
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/row-level-security/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Add an account manager column and two roles
ALTER TABLE customers ADD COLUMN account_manager text;
UPDATE customers SET account_manager = CASE WHEN customer_id % 2 = 0 THEN 'rep_anna' ELSE 'rep_ben' END;
CREATE ROLE rep_anna LOGIN;
CREATE ROLE rep_ben LOGIN;
GRANT SELECT, UPDATE ON customers TO rep_anna, rep_ben;

-- Customers per account manager
SELECT account_manager, COUNT(*) AS customers FROM customers GROUP BY account_manager ORDER BY account_manager;

-- Enable row-level security and add a policy
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
CREATE POLICY own_customers ON customers
  USING (account_manager = current_user)
  WITH CHECK (account_manager = current_user);

-- rep_anna sees only her customers
SET ROLE rep_anna;
SELECT COUNT(*) AS anna_sees FROM customers;

-- rep_ben sees only his
SET ROLE rep_ben;
SELECT COUNT(*) AS ben_sees FROM customers;

-- The owner is not filtered
SELECT COUNT(*) AS owner_sees FROM customers;

-- The first rows rep_anna sees
SET ROLE rep_anna;
SELECT customer_id, first_name, account_manager FROM customers ORDER BY customer_id LIMIT 3;

-- rep_anna can update her own rows, but not the others
SET ROLE rep_anna;
UPDATE customers SET city = 'X' WHERE customer_id = 2;
UPDATE customers SET city = 'Y' WHERE customer_id = 1;

-- rep_anna cannot give a row to someone else: refused
SET ROLE rep_anna;
UPDATE customers SET account_manager = 'rep_ben' WHERE customer_id = 2;

-- Read the policy from the catalogue
SELECT policyname, cmd, qual FROM pg_policies WHERE tablename = 'customers';
