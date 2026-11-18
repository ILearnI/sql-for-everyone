-- SQL for Everyone: From Zero to Confident
-- Chapter 11: Speed and Safety
-- Lesson 11.6: Maintenance: VACUUM, ANALYZE and Statistics
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/maintenance-vacuum-analyze-and-statistics/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- What the statistics say before ANALYZE
SELECT relname, n_live_tup AS stats_say
FROM pg_stat_user_tables
WHERE relname IN ('customers', 'orders', 'events_log')
ORDER BY relname;

-- What is really in customers
SELECT COUNT(*) AS really_customers FROM customers;

-- ANALYZE refreshes the statistics
ANALYZE;

-- The statistics now
SELECT relname, n_live_tup AS stats_now
FROM pg_stat_user_tables
WHERE relname IN ('customers', 'orders', 'events_log')
ORDER BY relname;

-- The size of events_log after loading
SELECT pg_size_pretty(pg_total_relation_size('events_log')) AS size_loaded;

-- An update makes dead rows: the table grows
UPDATE events_log SET page = page WHERE event_id <= 100000;
SELECT pg_size_pretty(pg_total_relation_size('events_log')) AS size_after_update;

-- VACUUM makes the space reusable
VACUUM events_log;

-- The size after VACUUM
SELECT pg_size_pretty(pg_total_relation_size('events_log')) AS size_after_vacuum;

-- VACUUM FULL rewrites the table and gives the space back
VACUUM FULL events_log;

-- The size after VACUUM FULL
SELECT pg_size_pretty(pg_total_relation_size('events_log')) AS size_after_vacuum_full;
