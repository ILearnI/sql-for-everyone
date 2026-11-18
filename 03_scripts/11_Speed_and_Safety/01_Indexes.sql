-- SQL for Everyone: From Zero to Confident
-- Chapter 11: Speed and Safety
-- Lesson 11.1: Indexes
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/indexes/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Without an index: a sequential scan reads the whole table
EXPLAIN (ANALYZE, COSTS OFF) SELECT * FROM events_log WHERE session_token = 's96e3435a05';

-- Create an index on session_token
CREATE INDEX idx_events_session ON events_log (session_token);

-- How big are the table and the index?
SELECT pg_size_pretty(pg_relation_size('events_log')) AS table_size,
       pg_size_pretty(pg_relation_size('idx_events_session')) AS index_size;

-- A pattern with a leading % cannot use the index
EXPLAIN (ANALYZE, COSTS OFF) SELECT * FROM events_log WHERE session_token LIKE '%96e34%';

-- A very common value: reading the table is cheaper than the index
EXPLAIN (ANALYZE, COSTS OFF) SELECT * FROM events_log WHERE page = 'checkout';

-- Drop the index
DROP INDEX idx_events_session;
