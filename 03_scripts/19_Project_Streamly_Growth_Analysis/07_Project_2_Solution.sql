-- SQL for Everyone: From Zero to Confident
-- Chapter 19: Project: Streamly Growth Analysis
-- Lesson 19.7: Project 2 Solution
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/project-2-solution/

-- Counting events: the wrong way and the right way
SELECT COUNT(*) AS events_wrong, COUNT(DISTINCT user_id) AS active_users_right
FROM events WHERE occurred_at >= '2025-12-01' AND occurred_at < '2026-01-01';

-- BETWEEN misses the end of the last day
SELECT COUNT(*) FILTER (WHERE occurred_at BETWEEN '2025-12-01' AND '2025-12-31') AS with_between,
       COUNT(*) FILTER (WHERE occurred_at >= '2025-12-01' AND occurred_at < '2026-01-01') AS with_half_open_range
FROM events;

-- Active subscriptions: all plans against paid plans
SELECT COUNT(*) AS all_plans, COUNT(*) FILTER (WHERE plan_id > 1) AS paid_plans_only
FROM subscriptions WHERE start_date <= '2025-12-31' AND (end_date IS NULL OR end_date > '2025-12-31');

-- The churn rate of December
WITH c AS (
  SELECT COUNT(*) FILTER (WHERE start_date < '2025-12-01' AND (end_date IS NULL OR end_date >= '2025-12-01')) AS active_at_start,
         COUNT(*) FILTER (WHERE start_date <= '2025-12-31' AND (end_date IS NULL OR end_date > '2025-12-31')) AS active_at_end,
         COUNT(*) FILTER (WHERE start_date < '2025-12-01' AND end_date >= '2025-12-01' AND end_date < '2026-01-01') AS churned
  FROM subscriptions WHERE plan_id > 1
)
SELECT churned, ROUND(100.0 * churned / active_at_end, 1) AS wrong_pct, ROUND(100.0 * churned / active_at_start, 1) AS right_pct FROM c;

-- Revenue: raw against corrected
SELECT ROUND(SUM(amount) FILTER (WHERE status = 'paid'), 2) AS raw_paid,
       ROUND(SUM(CASE WHEN amount > 20.49 THEN amount / 10 ELSE amount END) FILTER (WHERE status = 'paid'), 2) AS cleaned_paid
FROM payments;
