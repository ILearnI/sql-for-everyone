-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.3: Cohort Retention
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/cohort-retention/

-- Cohort sizes
SELECT date_trunc('month', signup_date)::date AS cohort, COUNT(*) AS size
FROM users
GROUP BY 1 ORDER BY 1
LIMIT 4;

-- Retention for every cohort and month
WITH c AS (SELECT user_id, date_trunc('month', signup_date)::date AS cohort FROM users),
     a AS (SELECT DISTINCT user_id, date_trunc('month', occurred_at)::date AS act_month FROM events),
     j AS (
       SELECT c.cohort,
              ((EXTRACT(year FROM a.act_month) * 12 + EXTRACT(month FROM a.act_month)) -
               (EXTRACT(year FROM c.cohort) * 12 + EXTRACT(month FROM c.cohort)))::int AS month_n,
              COUNT(DISTINCT a.user_id) AS active
       FROM c JOIN a ON a.user_id = c.user_id GROUP BY 1, 2),
     s AS (SELECT cohort, COUNT(*) AS size FROM c GROUP BY cohort)
SELECT to_char(s.cohort, 'YYYY-MM') AS cohort, s.size,
       ROUND(100.0 * MAX(active) FILTER (WHERE month_n = 0) / s.size) AS m0,
       ROUND(100.0 * MAX(active) FILTER (WHERE month_n = 1) / s.size) AS m1,
       ROUND(100.0 * MAX(active) FILTER (WHERE month_n = 2) / s.size) AS m2,
       ROUND(100.0 * MAX(active) FILTER (WHERE month_n = 3) / s.size) AS m3,
       ROUND(100.0 * MAX(active) FILTER (WHERE month_n = 6) / s.size) AS m6
FROM s JOIN j ON j.cohort = s.cohort
GROUP BY s.cohort, s.size ORDER BY s.cohort LIMIT 6;

-- Only the cohorts old enough: the triangle
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
