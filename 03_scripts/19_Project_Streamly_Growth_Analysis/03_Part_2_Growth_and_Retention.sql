-- SQL for Everyone: From Zero to Confident
-- Chapter 19: Project: Streamly Growth Analysis
-- Lesson 19.3: Part 2: Growth and Retention
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/part-2-growth-and-retention/

-- Signups per month, with the gaps filled
SELECT m::date AS month, COUNT(u.user_id) AS signups
FROM generate_series(DATE '2025-06-01', DATE '2025-10-01', INTERVAL '1 month') m
LEFT JOIN users u ON date_trunc('month', u.signup_date) = m
GROUP BY m ORDER BY m;

-- Growth: 2025 against 2024
SELECT COUNT(*) FILTER (WHERE signup_date < '2025-01-01') AS signups_2024, COUNT(*) FILTER (WHERE signup_date >= '2025-01-01') AS signups_2025,
       ROUND(100.0 * (COUNT(*) FILTER (WHERE signup_date >= '2025-01-01') - COUNT(*) FILTER (WHERE signup_date < '2025-01-01')) /
             COUNT(*) FILTER (WHERE signup_date < '2025-01-01'), 1) AS growth_pct
FROM users;

-- Monthly active users against last year
WITH m AS (
  SELECT date_trunc('month', occurred_at)::date AS month, COUNT(DISTINCT user_id) AS active FROM events GROUP BY 1
)
SELECT month, active, LAG(active, 12) OVER w AS last_year,
       ROUND(100.0 * (active - LAG(active, 12) OVER w) / NULLIF(LAG(active, 12) OVER w, 0), 1) AS yoy_pct
FROM m WINDOW w AS (ORDER BY month) ORDER BY month DESC LIMIT 3;

-- The cohort retention triangle
WITH c AS (SELECT user_id, date_trunc('month', signup_date)::date AS cohort FROM users WHERE signup_date < '2025-07-01'),
     a AS (SELECT DISTINCT user_id, date_trunc('month', occurred_at)::date AS act_month FROM events),
     j AS (
       SELECT c.cohort,
              ((EXTRACT(year FROM a.act_month) * 12 + EXTRACT(month FROM a.act_month)) -
               (EXTRACT(year FROM c.cohort) * 12 + EXTRACT(month FROM c.cohort)))::int AS month_n,
              COUNT(DISTINCT a.user_id) AS active
       FROM c JOIN a ON a.user_id = c.user_id GROUP BY 1, 2),
     s AS (SELECT cohort, COUNT(*) AS size FROM c GROUP BY cohort)
SELECT j.month_n AS months_since_signup, ROUND(AVG(100.0 * j.active / s.size), 1) AS avg_retention_pct
FROM j JOIN s ON s.cohort = j.cohort
WHERE j.month_n BETWEEN 0 AND 6
GROUP BY j.month_n ORDER BY j.month_n;
