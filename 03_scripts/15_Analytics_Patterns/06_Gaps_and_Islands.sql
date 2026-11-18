-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.6: Gaps and Islands
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/gaps-and-islands/

-- The days one user was active
SELECT DISTINCT occurred_at::date AS day FROM events WHERE user_id = 93 ORDER BY day LIMIT 8;

-- The date minus the row number is constant inside a streak
WITH d AS (SELECT DISTINCT occurred_at::date AS day FROM events WHERE user_id = 93)
SELECT day, ROW_NUMBER() OVER (ORDER BY day) AS rn,
       day - (ROW_NUMBER() OVER (ORDER BY day))::int AS island
FROM d ORDER BY day LIMIT 8;

-- The streaks (islands) of one user
WITH d AS (SELECT DISTINCT occurred_at::date AS day FROM events WHERE user_id = 93),
     g AS (SELECT day, day - (ROW_NUMBER() OVER (ORDER BY day))::int AS grp FROM d)
SELECT MIN(day) AS start_day, MAX(day) AS end_day, COUNT(*) AS days
FROM g GROUP BY grp ORDER BY start_day LIMIT 4;

-- The streaks of every user
WITH d AS (SELECT DISTINCT user_id, occurred_at::date AS day FROM events),
     g AS (SELECT user_id, day, day - (ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY day))::int AS grp FROM d)
SELECT user_id, MIN(day) AS start_day, MAX(day) AS end_day, COUNT(*) AS streak_days
FROM g GROUP BY user_id, grp
ORDER BY streak_days DESC, user_id LIMIT 3;

-- The longest streak of each user
WITH d AS (SELECT DISTINCT user_id, occurred_at::date AS day FROM events),
     g AS (SELECT user_id, day - (ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY day))::int AS grp FROM d),
     runs AS (SELECT user_id, COUNT(*) AS streak_days FROM g GROUP BY user_id, grp)
SELECT COUNT(DISTINCT user_id) FILTER (WHERE streak_days >= 3) AS users_3_days,
       COUNT(DISTINCT user_id) FILTER (WHERE streak_days >= 7) AS users_7_days,
       MAX(streak_days) AS longest
FROM runs;

-- Subscribers who came back after a gap
WITH s AS (
  SELECT user_id, start_date, LAG(end_date) OVER (PARTITION BY user_id ORDER BY start_date) AS previous_end
  FROM subscriptions WHERE plan_id > 1
)
SELECT COUNT(*) AS returned_after_a_gap FROM s WHERE previous_end IS NOT NULL AND start_date > previous_end;
