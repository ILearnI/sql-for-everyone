-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.2: Year-over-Year and Period Comparisons
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/year-over-year-and-period-comparisons/

-- Monthly active users against the same month last year
WITH m AS (
  SELECT date_trunc('month', occurred_at)::date AS month, COUNT(DISTINCT user_id) AS active
  FROM events GROUP BY 1
)
SELECT month, active, LAG(active, 12) OVER w AS last_year,
       ROUND(100.0 * (active - LAG(active, 12) OVER w) / NULLIF(LAG(active, 12) OVER w, 0), 1) AS pct_change
FROM m
WINDOW w AS (ORDER BY month)
ORDER BY month DESC LIMIT 4;

-- Weekly active users: watch the partial weeks
WITH w AS (
  SELECT date_trunc('week', occurred_at)::date AS wk, COUNT(DISTINCT user_id) AS wau,
         COUNT(DISTINCT occurred_at::date) AS days_of_data
  FROM events GROUP BY 1
)
SELECT wk, days_of_data, wau, ROUND(100.0 * (wau - LAG(wau) OVER (ORDER BY wk)) / LAG(wau) OVER (ORDER BY wk), 1) AS wow_pct
FROM w ORDER BY wk DESC LIMIT 3;

-- Week-over-week change
WITH w AS (
  SELECT date_trunc('week', occurred_at)::date AS wk, COUNT(DISTINCT user_id) AS wau
  FROM events GROUP BY 1
)
SELECT wk, wau, ROUND(100.0 * (wau - LAG(wau) OVER (ORDER BY wk)) / LAG(wau) OVER (ORDER BY wk), 1) AS wow_pct
FROM w
WHERE wk + 6 <= (SELECT MAX(occurred_at)::date FROM events)
ORDER BY wk DESC LIMIT 3;

-- A 7-day moving average of plays
WITH d AS (
  SELECT occurred_at::date AS day, COUNT(*) AS plays FROM events WHERE event_type = 'play' GROUP BY 1
)
SELECT day, plays,
       ROUND(AVG(plays) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS avg_7_days
FROM d ORDER BY day DESC LIMIT 3;

-- December 2025 against December 2024
SELECT COUNT(DISTINCT user_id) FILTER (WHERE occurred_at >= '2025-12-01' AND occurred_at < '2026-01-01') AS mau_dec_2025,
       COUNT(DISTINCT user_id) FILTER (WHERE occurred_at >= '2024-12-01' AND occurred_at < '2025-01-01') AS mau_dec_2024
FROM events;
