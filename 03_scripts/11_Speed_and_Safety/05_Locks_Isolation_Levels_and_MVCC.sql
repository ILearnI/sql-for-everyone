-- SQL for Everyone: From Zero to Confident
-- Chapter 11: Speed and Safety
-- Lesson 11.5: Locks, Isolation Levels and MVCC
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/locks-isolation-levels-and-mvcc/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Every row has hidden columns: ctid and xmin
SELECT ctid, xmin, customer_id, points FROM loyalty_accounts WHERE customer_id = 1;

-- An update writes a new version of the row
UPDATE loyalty_accounts SET points = points + 1 WHERE customer_id = 1;

-- The default isolation level
SHOW transaction_isolation;

-- REPEATABLE READ: one snapshot for the whole transaction
BEGIN ISOLATION LEVEL REPEATABLE READ;
SHOW transaction_isolation;
SELECT points FROM loyalty_accounts WHERE customer_id = 1;
COMMIT;

-- FOR UPDATE locks the row: see the lock in pg_locks
BEGIN;
SELECT points FROM loyalty_accounts WHERE customer_id = 1 FOR UPDATE;
SELECT locktype, mode FROM pg_locks WHERE pid = pg_backend_pid() AND locktype IN ('relation', 'transactionid') AND relation IS DISTINCT FROM 'pg_locks'::regclass ORDER BY 1, 2;
COMMIT;
