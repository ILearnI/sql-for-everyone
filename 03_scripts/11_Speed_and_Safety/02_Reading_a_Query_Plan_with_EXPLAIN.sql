-- SQL for Everyone: From Zero to Confident
-- Chapter 11: Speed and Safety
-- Lesson 11.2: Reading a Query Plan with EXPLAIN
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/reading-a-query-plan-with-explain/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- A plan without running the query: the costs are estimates
EXPLAIN SELECT * FROM events_log WHERE session_token = 's96e3435a05';

-- EXPLAIN ANALYZE runs the query: a function on the column forces a Seq Scan
EXPLAIN (ANALYZE, COSTS OFF) SELECT * FROM events_log WHERE logged_at::date = '2025-12-01';

-- Create an index on logged_at
CREATE INDEX idx_events_logged ON events_log (logged_at);

-- The same day as a range: the index is used
EXPLAIN (ANALYZE, COSTS OFF) SELECT COUNT(*) FROM events_log
WHERE logged_at >= '2025-12-01' AND logged_at < '2025-12-02';

-- A lookup by primary key uses the index
EXPLAIN SELECT * FROM events_log WHERE event_id = 1000;

-- Drop the index
DROP INDEX idx_events_logged;
