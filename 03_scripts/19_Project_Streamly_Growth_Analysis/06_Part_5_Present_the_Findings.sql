-- SQL for Everyone: From Zero to Confident
-- Chapter 19: Project: Streamly Growth Analysis
-- Lesson 19.6: Part 5: Present the Findings
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/part-5-present-the-findings/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- A view of monthly signups
CREATE VIEW v_signups_monthly AS
SELECT m::date AS month, COUNT(u.user_id) AS signups
FROM generate_series(DATE '2024-01-01', DATE '2025-12-01', INTERVAL '1 month') m
LEFT JOIN users u ON date_trunc('month', u.signup_date) = m GROUP BY m;
CREATE VIEW v_active_monthly AS
SELECT date_trunc('month', occurred_at)::date AS month, COUNT(DISTINCT user_id) AS active_users FROM events GROUP BY 1;

-- A view of monthly recurring revenue
CREATE VIEW v_mrr_monthly AS
SELECT (date_trunc('month', g) + INTERVAL '1 month - 1 day')::date AS month_end, ROUND(SUM(pl.monthly_price)) AS mrr
FROM generate_series(DATE '2024-01-01', DATE '2025-12-01', INTERVAL '1 month') g
JOIN subscriptions s ON s.plan_id > 1 AND s.start_date <= (date_trunc('month', g) + INTERVAL '1 month - 1 day')::date
     AND (s.end_date IS NULL OR s.end_date > (date_trunc('month', g) + INTERVAL '1 month - 1 day')::date)
JOIN plans pl ON pl.plan_id = s.plan_id GROUP BY 1;
CREATE VIEW v_churn_monthly AS
SELECT g::date AS month_start,
       COUNT(*) FILTER (WHERE s.start_date < g AND (s.end_date IS NULL OR s.end_date >= g)) AS active_at_start,
       COUNT(*) FILTER (WHERE s.start_date < g AND s.end_date >= g AND s.end_date < g + INTERVAL '1 month') AS churned
FROM generate_series(DATE '2025-01-01', DATE '2025-12-01', INTERVAL '1 month') g JOIN subscriptions s ON s.plan_id > 1 GROUP BY g;

-- A view of the channel funnel
CREATE VIEW v_channel_funnel AS
WITH v AS (SELECT channel, COUNT(*) AS visits FROM visits GROUP BY channel),
     s AS (SELECT channel, COUNT(*) AS signups FROM users GROUP BY channel),
     t AS (SELECT u.channel, COUNT(DISTINCT u.user_id) AS trials FROM users u JOIN subscriptions sb ON sb.user_id = u.user_id AND sb.plan_id = 1 GROUP BY u.channel),
     p AS (SELECT u.channel, COUNT(DISTINCT u.user_id) AS paid FROM users u
           JOIN subscriptions sb ON sb.user_id = u.user_id AND sb.plan_id > 1
           JOIN payments pm ON pm.subscription_id = sb.subscription_id AND pm.status = 'paid' GROUP BY u.channel)
SELECT v.channel, v.visits, s.signups, t.trials, p.paid,
       ROUND(100.0 * s.signups / v.visits, 1) AS visit_to_signup,
       ROUND(100.0 * p.paid / t.trials, 1) AS trial_to_paid,
       ROUND(100.0 * p.paid / v.visits, 1) AS overall
FROM v JOIN s ON s.channel = v.channel JOIN t ON t.channel = v.channel JOIN p ON p.channel = v.channel
ORDER BY overall DESC;

-- A summary table for the report
CREATE TABLE report_summary AS
SELECT 1 AS ord, 'signups_2025' AS metric, (SELECT SUM(signups)::text FROM v_signups_monthly WHERE month >= '2025-01-01') AS value
UNION ALL SELECT 2, 'signup_growth_pct', (SELECT ROUND(100.0 * (SUM(signups) FILTER (WHERE month >= '2025-01-01') - SUM(signups) FILTER (WHERE month < '2025-01-01')) / SUM(signups) FILTER (WHERE month < '2025-01-01'), 1)::text FROM v_signups_monthly)
UNION ALL SELECT 3, 'active_users_dec_2025', (SELECT active_users::text FROM v_active_monthly WHERE month = '2025-12-01')
UNION ALL SELECT 4, 'mrr_dec_2025', (SELECT mrr::text FROM v_mrr_monthly WHERE month_end = '2025-12-31')
UNION ALL SELECT 5, 'churn_pct_dec_2025', (SELECT ROUND(100.0 * churned / active_at_start, 1)::text FROM v_churn_monthly WHERE month_start = '2025-12-01')
UNION ALL SELECT 6, 'best_channel', (SELECT channel || ' (' || overall || '%)' FROM v_channel_funnel ORDER BY overall DESC LIMIT 1)
UNION ALL SELECT 7, 'worst_channel', (SELECT channel || ' (' || overall || '%)' FROM v_channel_funnel ORDER BY overall LIMIT 1);

-- Read the summary
SELECT metric, value FROM report_summary ORDER BY ord;

-- A shell command to prepare a folder
\! mkdir -p /tmp/export && chmod 777 /tmp/export

-- COPY the summary to a CSV file
COPY (SELECT metric, value FROM report_summary ORDER BY ord) TO '/tmp/export/report_summary.csv' WITH (FORMAT csv, HEADER true);

-- Look at the file
\! head -4 /tmp/export/report_summary.csv
