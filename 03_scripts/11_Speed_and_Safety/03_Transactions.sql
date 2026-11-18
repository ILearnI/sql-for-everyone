-- SQL for Everyone: From Zero to Confident
-- Chapter 11: Speed and Safety
-- Lesson 11.3: Transactions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/transactions/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Check the balances first
SELECT customer_id, points FROM loyalty_accounts WHERE customer_id IN (1, 2) ORDER BY customer_id;

-- A transfer: both updates, then COMMIT
BEGIN;
UPDATE loyalty_accounts SET points = points - 50 WHERE customer_id = 1;
UPDATE loyalty_accounts SET points = points + 50 WHERE customer_id = 2;
COMMIT;

-- A typo in the second update: the whole transaction fails
BEGIN;
UPDATE loyalty_accounts SET points = points - 50 WHERE customer_id = 1;
UPDATE loyalty_accounts SET pts = pts + 50 WHERE customer_id = 2;
COMMIT;

-- Inside a transaction you see your own changes, then ROLLBACK
BEGIN;
UPDATE loyalty_accounts SET points = points - 50 WHERE customer_id = 1;
SELECT customer_id, points AS inside_transaction FROM loyalty_accounts WHERE customer_id = 1;
ROLLBACK;

-- After the rollback the points are back
SELECT customer_id, points AS after_rollback FROM loyalty_accounts WHERE customer_id = 1;
