-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.8: Pareto and ABC Analysis
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/pareto-and-abc-analysis/

-- Plays per title: how spread out?
WITH t AS (SELECT title_id, COUNT(*) AS plays FROM events WHERE event_type = 'play' GROUP BY title_id)
SELECT COUNT(*) AS titles, MAX(plays) AS most_plays, MIN(plays) AS fewest_plays, SUM(plays) AS total_plays FROM t;

-- Rank the titles with a cumulative share
WITH t AS (SELECT title_id, COUNT(*) AS plays FROM events WHERE event_type = 'play' GROUP BY title_id),
     o AS (
       SELECT title_id, plays, ROW_NUMBER() OVER (ORDER BY plays DESC, title_id) AS rank,
              ROUND(100.0 * SUM(plays) OVER (ORDER BY plays DESC, title_id) / SUM(plays) OVER (), 1) AS cumulative_pct
       FROM t)
SELECT rank, title_id, plays, cumulative_pct FROM o WHERE rank IN (1, 10, 50, 96, 200, 300) ORDER BY rank;

-- How many titles make 80% of the plays?
WITH t AS (SELECT title_id, COUNT(*) AS plays FROM events WHERE event_type = 'play' GROUP BY title_id),
     o AS (SELECT *, SUM(plays) OVER (ORDER BY plays DESC, title_id) AS running, SUM(plays) OVER () AS total FROM t)
SELECT CASE WHEN running * 1.0 / total <= 0.80 THEN 'A' WHEN running * 1.0 / total <= 0.95 THEN 'B' ELSE 'C' END AS class,
       COUNT(*) AS titles, SUM(plays) AS plays
FROM o GROUP BY 1 ORDER BY 1;

-- How many customers make 80% of the revenue?
WITH r AS (SELECT s.user_id, SUM(p.amount) AS revenue FROM payments p JOIN subscriptions s ON s.subscription_id = p.subscription_id WHERE p.status = 'paid' GROUP BY s.user_id),
     o AS (SELECT revenue, SUM(revenue) OVER (ORDER BY revenue DESC, user_id) AS running, SUM(revenue) OVER () AS total,
                  ROW_NUMBER() OVER (ORDER BY revenue DESC, user_id) AS rn FROM r)
SELECT MIN(rn) FILTER (WHERE running / total >= 0.8) AS users_for_80_percent, COUNT(*) AS paying_users
FROM o;
