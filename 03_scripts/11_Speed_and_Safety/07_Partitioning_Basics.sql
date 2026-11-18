-- SQL for Everyone: From Zero to Confident
-- Chapter 11: Speed and Safety
-- Lesson 11.7: Partitioning Basics
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/partitioning-basics/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- A table partitioned by range of logged_at
CREATE TABLE events_by_month (LIKE events_log) PARTITION BY RANGE (logged_at);

-- Create one partition per month
DO $$
DECLARE m date;
BEGIN
  FOR m IN SELECT generate_series(DATE '2025-01-01', DATE '2025-12-01', INTERVAL '1 month')::date LOOP
    EXECUTE format('CREATE TABLE %I PARTITION OF events_by_month FOR VALUES FROM (%L) TO (%L)',
                   'events_' || to_char(m, 'YYYY_MM'), m, (m + INTERVAL '1 month')::date);
  END LOOP;
END $$;

-- Copy the events into the partitioned table
INSERT INTO events_by_month SELECT * FROM events_log;

-- The rows are spread across the partitions
SELECT tableoid::regclass AS partition, COUNT(*) AS rows
FROM events_by_month
GROUP BY 1 ORDER BY 1 LIMIT 4;

-- Partition pruning: a one-week range reads one partition
EXPLAIN (COSTS OFF) SELECT COUNT(*) FROM events_by_month
WHERE logged_at >= '2025-12-01' AND logged_at < '2025-12-08';

-- A function that counts the partitions in a plan
CREATE FUNCTION partitions_scanned(q text) RETURNS int LANGUAGE plpgsql AS $$
DECLARE r text; n int := 0;
BEGIN
  FOR r IN EXECUTE 'EXPLAIN ' || q LOOP
    IF r LIKE '%Scan on events_2025%' THEN n := n + 1; END IF;
  END LOOP;
  RETURN n;
END $$;

-- Compare a range with a function on the column
SELECT partitions_scanned('SELECT COUNT(*) FROM events_by_month WHERE logged_at >= ''2025-12-01'' AND logged_at < ''2025-12-08''') AS with_range,
       partitions_scanned('SELECT COUNT(*) FROM events_by_month WHERE logged_at::date = ''2025-12-01''') AS with_cast,
       partitions_scanned('SELECT COUNT(*) FROM events_by_month WHERE page = ''home''') AS other_column;

-- A row outside every partition is refused
INSERT INTO events_by_month VALUES (999999, '2027-01-01', 1, 'home', 'x');

-- Detach a partition
ALTER TABLE events_by_month DETACH PARTITION events_2025_01;
SELECT COUNT(*) AS rows_left FROM events_by_month;
