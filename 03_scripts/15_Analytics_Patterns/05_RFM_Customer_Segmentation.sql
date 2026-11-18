-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.5: RFM Customer Segmentation
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/rfm-customer-segmentation/

-- Recency, frequency and monetary value of each user
WITH rfm AS (
  SELECT s.user_id, DATE '2025-12-31' - MAX(p.paid_at)::date AS recency_days, COUNT(*) AS frequency, SUM(p.amount) AS monetary
  FROM payments p JOIN subscriptions s ON s.subscription_id = p.subscription_id
  WHERE p.status = 'paid' GROUP BY s.user_id
)
SELECT COUNT(*) AS paying_users, MIN(recency_days) AS min_recency, MAX(recency_days) AS max_recency,
       ROUND(AVG(frequency), 1) AS avg_payments, ROUND(AVG(monetary), 1) AS avg_spend
FROM rfm;

-- Score each from 1 to 4 with ntile
WITH rfm AS (
  SELECT s.user_id, DATE '2025-12-31' - MAX(p.paid_at)::date AS recency_days, COUNT(*) AS frequency, SUM(p.amount) AS monetary
  FROM payments p JOIN subscriptions s ON s.subscription_id = p.subscription_id
  WHERE p.status = 'paid' GROUP BY s.user_id
),
sc AS (SELECT *, NTILE(4) OVER (ORDER BY recency_days DESC) AS r FROM rfm)
SELECT r AS recency_score, COUNT(*) AS users, MIN(recency_days) AS min_days, MAX(recency_days) AS max_days
FROM sc GROUP BY r ORDER BY r;

-- Name the segments and measure them
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
