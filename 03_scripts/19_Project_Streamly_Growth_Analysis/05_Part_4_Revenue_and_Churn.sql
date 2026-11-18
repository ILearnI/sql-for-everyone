-- SQL for Everyone: From Zero to Confident
-- Chapter 19: Project: Streamly Growth Analysis
-- Lesson 19.5: Part 4: Revenue and Churn
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/part-4-revenue-and-churn/

-- New and ended subscriptions in the last three months
WITH m AS (SELECT g::date AS month_start FROM generate_series(DATE '2025-10-01', DATE '2025-12-01', INTERVAL '1 month') g)
SELECT m.month_start,
       COUNT(*) FILTER (WHERE s.start_date < m.month_start AND (s.end_date IS NULL OR s.end_date >= m.month_start)) AS active_at_start,
       COUNT(*) FILTER (WHERE s.start_date < m.month_start AND s.end_date >= m.month_start AND s.end_date < m.month_start + INTERVAL '1 month') AS churned
FROM m JOIN subscriptions s ON s.plan_id > 1
GROUP BY m.month_start ORDER BY m.month_start DESC;

-- Monthly recurring revenue at the end of 2025
SELECT ROUND(SUM(pl.monthly_price)) AS mrr_end_of_2025, COUNT(*) AS paid_subscriptions
FROM subscriptions s JOIN plans pl ON pl.plan_id = s.plan_id
WHERE s.plan_id > 1 AND s.start_date <= '2025-12-31' AND (s.end_date IS NULL OR s.end_date > '2025-12-31');

-- Churn by plan
SELECT p.name AS plan, COUNT(*) FILTER (WHERE s.end_date IS NULL) AS active, COUNT(*) FILTER (WHERE s.end_date IS NOT NULL) AS ended,
       ROUND(100.0 * COUNT(*) FILTER (WHERE s.end_date IS NOT NULL) / COUNT(*), 1) AS pct_ended
FROM subscriptions s JOIN plans p ON p.plan_id = s.plan_id WHERE s.plan_id > 1 GROUP BY p.name ORDER BY pct_ended DESC;

-- Revenue at risk: active subscribers with no recent activity
WITH act AS (SELECT s.user_id, pl.monthly_price FROM subscriptions s JOIN plans pl ON pl.plan_id = s.plan_id WHERE s.plan_id > 1 AND s.end_date IS NULL),
     last_ev AS (SELECT user_id, MAX(occurred_at)::date AS last_seen FROM events GROUP BY user_id)
SELECT COUNT(*) AS paying_users, COUNT(*) FILTER (WHERE le.last_seen IS NULL OR le.last_seen < DATE '2025-12-31' - 30) AS quiet_30_days,
       ROUND(SUM(monthly_price) FILTER (WHERE le.last_seen IS NULL OR le.last_seen < DATE '2025-12-31' - 30)) AS mrr_at_risk
FROM act LEFT JOIN last_ev le ON le.user_id = act.user_id;

-- Churn in December, and how many were inactive
SELECT COUNT(*) AS churned_in_december,
       COUNT(*) FILTER (WHERE NOT EXISTS (SELECT 1 FROM events e WHERE e.user_id = s.user_id AND e.occurred_at >= s.end_date - 30 AND e.occurred_at < s.end_date)) AS were_quiet_before
FROM subscriptions s WHERE s.plan_id > 1 AND s.end_date >= '2025-12-01' AND s.end_date < '2026-01-01';
