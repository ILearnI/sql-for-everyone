-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.7: Sessionisation
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/sessionisation/

-- The gaps between the events of one user
SELECT occurred_at, event_type,
       occurred_at - LAG(occurred_at) OVER (ORDER BY occurred_at) AS gap
FROM events WHERE user_id = 6
ORDER BY occurred_at LIMIT 7;

-- Number the sessions with a running sum
WITH e AS (
  SELECT user_id, occurred_at, LAG(occurred_at) OVER (PARTITION BY user_id ORDER BY occurred_at) AS prev FROM events
), f AS (
  SELECT *, CASE WHEN prev IS NULL OR occurred_at - prev > INTERVAL '30 minutes' THEN 1 ELSE 0 END AS new_session FROM e
), s AS (
  SELECT *, SUM(new_session) OVER (PARTITION BY user_id ORDER BY occurred_at) AS session_no FROM f
)
SELECT session_no, MIN(occurred_at) AS started, MAX(occurred_at) AS ended, COUNT(*) AS events
FROM s WHERE user_id = 6 GROUP BY session_no ORDER BY session_no;

-- Session length and events per session
WITH e AS (
  SELECT user_id, occurred_at, LAG(occurred_at) OVER (PARTITION BY user_id ORDER BY occurred_at) AS prev FROM events
), f AS (
  SELECT *, CASE WHEN prev IS NULL OR occurred_at - prev > INTERVAL '30 minutes' THEN 1 ELSE 0 END AS new_session FROM e
), s AS (
  SELECT *, SUM(new_session) OVER (PARTITION BY user_id ORDER BY occurred_at) AS session_no FROM f
), x AS (
  SELECT user_id, session_no, COUNT(*) AS events, EXTRACT(epoch FROM MAX(occurred_at) - MIN(occurred_at)) / 60 AS minutes
  FROM s GROUP BY user_id, session_no
)
SELECT COUNT(*) AS sessions, ROUND(AVG(events), 1) AS avg_events, ROUND(AVG(minutes), 1) AS avg_minutes,
       ROUND(percentile_cont(0.5) WITHIN GROUP (ORDER BY minutes)::numeric, 1) AS median_minutes
FROM x;

-- How many gaps are within 30 minutes?
WITH e AS (SELECT occurred_at - LAG(occurred_at) OVER (PARTITION BY user_id ORDER BY occurred_at) AS gap FROM events)
SELECT COUNT(*) FILTER (WHERE gap <= INTERVAL '30 minutes') AS within_30_minutes,
       COUNT(*) FILTER (WHERE gap > INTERVAL '30 minutes') AS after_a_longer_gap,
       COUNT(*) FILTER (WHERE gap IS NULL) AS first_events
FROM e;
