-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.10: Analytics Patterns Challenge
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/analytics-patterns-challenge/

-- Revenue by month, with zeros filled in
SELECT m::date AS month, COALESCE(ROUND(SUM(p.amount) FILTER (WHERE p.status = 'paid')), 0) AS revenue
FROM generate_series(DATE '2025-07-01', DATE '2025-09-01', INTERVAL '1 month') m
LEFT JOIN payments p ON date_trunc('month', p.paid_at) = m
GROUP BY m ORDER BY m;

-- Retention of the January cohort
WITH c AS (SELECT user_id FROM users WHERE signup_date >= '2025-01-01' AND signup_date < '2025-02-01')
SELECT COUNT(*) AS cohort_size,
       COUNT(*) FILTER (WHERE EXISTS (SELECT 1 FROM events e WHERE e.user_id = c.user_id
                                      AND e.occurred_at >= '2025-04-01' AND e.occurred_at < '2025-05-01')) AS active_in_month_3
FROM c;

-- The funnel by channel
WITH v AS (SELECT channel, COUNT(*) AS visits FROM visits GROUP BY channel),
     p AS (SELECT u.channel, COUNT(DISTINCT u.user_id) AS paid FROM users u
           JOIN subscriptions sb ON sb.user_id = u.user_id AND sb.plan_id > 1
           JOIN payments pm ON pm.subscription_id = sb.subscription_id AND pm.status = 'paid' GROUP BY u.channel)
SELECT v.channel, ROUND(100.0 * p.paid / v.visits, 1) AS visit_to_paid_pct
FROM v JOIN p ON p.channel = v.channel ORDER BY visit_to_paid_pct DESC;

-- Monthly recurring revenue at the end of 2025
SELECT ROUND(SUM(pl.monthly_price)) AS mrr_end_of_2025
FROM subscriptions s JOIN plans pl ON pl.plan_id = s.plan_id
WHERE s.plan_id > 1 AND s.start_date <= '2025-12-31' AND (s.end_date IS NULL OR s.end_date > '2025-12-31');

-- Paid subscriptions ended by month (latest three)
SELECT date_trunc('month', end_date)::date AS month, COUNT(*) AS paid_subscriptions_ended
FROM subscriptions WHERE plan_id > 1 AND end_date IS NOT NULL
GROUP BY 1 ORDER BY 1 DESC LIMIT 3;
