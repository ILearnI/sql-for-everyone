-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.4: Funnels and Conversion
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/funnels-and-conversion/

-- The overall funnel: visits, signups, trials, paid
SELECT (SELECT COUNT(*) FROM visits) AS visits,
       (SELECT COUNT(*) FROM users) AS signups,
       (SELECT COUNT(DISTINCT user_id) FROM subscriptions WHERE plan_id = 1) AS trials,
       (SELECT COUNT(DISTINCT s.user_id) FROM subscriptions s JOIN payments p ON p.subscription_id = s.subscription_id
        WHERE s.plan_id > 1 AND p.status = 'paid') AS paid;

-- The same with the rate between steps
WITH f AS (
  SELECT (SELECT COUNT(*) FROM visits) AS visits, (SELECT COUNT(*) FROM users) AS signups,
         (SELECT COUNT(DISTINCT user_id) FROM subscriptions WHERE plan_id = 1) AS trials,
         (SELECT COUNT(DISTINCT s.user_id) FROM subscriptions s JOIN payments p ON p.subscription_id = s.subscription_id WHERE s.plan_id > 1 AND p.status = 'paid') AS paid
)
SELECT ROUND(100.0 * signups / visits, 1) AS visit_to_signup, ROUND(100.0 * trials / signups, 1) AS signup_to_trial,
       ROUND(100.0 * paid / trials, 1) AS trial_to_paid, ROUND(100.0 * paid / visits, 1) AS overall
FROM f;

-- The funnel for each channel
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

-- Payments by status
SELECT status, COUNT(*) AS payments FROM payments GROUP BY status ORDER BY payments DESC;
