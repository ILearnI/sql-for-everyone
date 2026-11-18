-- SQL for Everyone: From Zero to Confident
-- Chapter 14: Data Cleaning and Quality
-- Lesson 14.5: Missing Values and Outliers
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/missing-values-and-outliers/

-- Missing values in different tables
SELECT COUNT(*) FILTER (WHERE email IS NULL) AS users_without_email,
       (SELECT COUNT(*) FROM subscriptions WHERE end_date IS NULL) AS running_subscriptions,
       (SELECT COUNT(*) FROM payments WHERE amount IS NULL) AS payments_without_amount,
       (SELECT COUNT(*) FROM support_tickets WHERE closed_at IS NULL) AS open_tickets
FROM users;

-- The average ignoring NULLs against NULLs as zero
SELECT AVG(amount) AS average_ignoring_nulls,
       AVG(COALESCE(amount, 0)) AS average_nulls_as_zero
FROM payments;

-- Missing emails by channel
SELECT channel, ROUND(100.0 * COUNT(*) FILTER (WHERE email IS NULL) / COUNT(*), 1) AS pct_missing_email
FROM users GROUP BY channel ORDER BY pct_missing_email DESC;

-- The IQR fence
WITH q AS (
  SELECT percentile_cont(0.25) WITHIN GROUP (ORDER BY amount) AS q1,
         percentile_cont(0.75) WITHIN GROUP (ORDER BY amount) AS q3
  FROM payments
)
SELECT q1, q3, q3 - q1 AS iqr, ROUND((q3 + 1.5 * (q3 - q1))::numeric, 2) AS high_fence FROM q;

-- The mean plus 3 standard deviations
SELECT ROUND(AVG(amount), 2) AS mean, ROUND(STDDEV(amount), 2) AS sd,
       ROUND(AVG(amount) + 3 * STDDEV(amount), 2) AS three_sigma_limit
FROM payments;

-- Flag each payment: missing, outlier or ok
SELECT CASE WHEN amount IS NULL THEN 'missing' WHEN amount > 20.49 THEN 'outlier' ELSE 'ok' END AS quality_flag,
       COUNT(*) AS payments
FROM payments GROUP BY 1 ORDER BY payments DESC;

-- Compare each amount with the plan price: ten times too big
SELECT p.amount, pl.monthly_price, ROUND(p.amount / pl.monthly_price, 1) AS times_the_price, COUNT(*) AS payments
FROM payments p
JOIN subscriptions s ON s.subscription_id = p.subscription_id
JOIN plans pl ON pl.plan_id = s.plan_id
WHERE p.amount > 20.49
GROUP BY p.amount, pl.monthly_price
ORDER BY p.amount;
