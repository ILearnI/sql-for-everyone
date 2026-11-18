-- SQL for Everyone: From Zero to Confident
-- Chapter 19: Project: Streamly Growth Analysis
-- Lesson 19.4: Part 3: Funnel and Segments
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/part-3-funnel-and-segments/

-- The funnel by channel
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

-- RFM segments
WITH rfm AS (
  SELECT s.user_id, DATE '2025-12-31' - MAX(p.paid_at)::date AS recency_days, COUNT(*) AS frequency, SUM(p.amount) AS monetary
  FROM payments p JOIN subscriptions s ON s.subscription_id = p.subscription_id
  WHERE p.status = 'paid' GROUP BY s.user_id
),
sc AS (SELECT *, NTILE(4) OVER (ORDER BY recency_days DESC) AS r, NTILE(4) OVER (ORDER BY frequency) AS f FROM rfm),
seg AS (SELECT *, CASE WHEN r >= 3 AND f >= 3 THEN 'Champions' WHEN r >= 3 THEN 'New or promising' WHEN f >= 3 THEN 'At risk' ELSE 'Lost' END AS segment FROM sc)
SELECT segment, COUNT(*) AS users, ROUND(AVG(recency_days)) AS avg_recency_days, ROUND(AVG(frequency), 1) AS avg_payments,
       ROUND(SUM(monetary)) AS revenue, ROUND(100.0 * SUM(monetary) / SUM(SUM(monetary)) OVER (), 1) AS pct_of_revenue
FROM seg GROUP BY segment ORDER BY revenue DESC;

-- The RFM scores in detail
WITH rfm AS (
  SELECT s.user_id, DATE '2025-12-31' - MAX(p.paid_at)::date AS recency_days, COUNT(*) AS frequency
  FROM payments p JOIN subscriptions s ON s.subscription_id = p.subscription_id WHERE p.status = 'paid' GROUP BY s.user_id
), sc AS (
  SELECT *, NTILE(4) OVER (ORDER BY recency_days DESC) AS r, NTILE(4) OVER (ORDER BY frequency) AS f FROM rfm
), seg AS (
  SELECT user_id, CASE WHEN r >= 3 AND f >= 3 THEN 'Champions' WHEN r >= 3 THEN 'New or promising' WHEN f >= 3 THEN 'At risk' ELSE 'Lost' END AS segment FROM sc
)
SELECT u.channel, COUNT(*) AS paying_users, COUNT(*) FILTER (WHERE segment = 'Champions') AS champions,
       ROUND(100.0 * COUNT(*) FILTER (WHERE segment = 'Champions') / COUNT(*), 1) AS pct_champions
FROM seg JOIN users u ON u.user_id = seg.user_id GROUP BY u.channel ORDER BY pct_champions DESC;

-- Trial to paid conversion
SELECT ROUND(100.0 * COUNT(DISTINCT user_id) FILTER (WHERE plan_id > 1) / COUNT(DISTINCT user_id) FILTER (WHERE plan_id = 1), 1) AS trial_to_paid_pct
FROM subscriptions;
