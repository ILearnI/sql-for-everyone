-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.9: Top N per Group and Latest Row per Group
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/top-n-per-group-and-latest-row-per-group/

-- The latest subscription of each user with ROW_NUMBER
WITH r AS (
  SELECT user_id, plan_id, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY start_date DESC, subscription_id DESC) AS rn
  FROM subscriptions
)
SELECT COUNT(*) AS users, COUNT(*) FILTER (WHERE plan_id > 1) AS latest_is_paid FROM r WHERE rn = 1;

-- The same with DISTINCT ON
SELECT COUNT(*) AS users, COUNT(*) FILTER (WHERE plan_id > 1) AS latest_is_paid
FROM (SELECT DISTINCT ON (user_id) user_id, plan_id
      FROM subscriptions ORDER BY user_id, start_date DESC, subscription_id DESC) t;

-- The same with NOT EXISTS
SELECT COUNT(*) AS users FROM subscriptions s
WHERE NOT EXISTS (SELECT 1 FROM subscriptions s2
                  WHERE s2.user_id = s.user_id
                    AND (s2.start_date, s2.subscription_id) > (s.start_date, s.subscription_id));

-- The top title of each genre with ROW_NUMBER
SELECT genre, title, plays
FROM (
  SELECT t.genre, t.title, COUNT(*) AS plays,
         ROW_NUMBER() OVER (PARTITION BY t.genre ORDER BY COUNT(*) DESC, t.title) AS rn
  FROM events e JOIN titles t ON t.title_id = e.title_id
  WHERE e.event_type = 'play'
  GROUP BY t.genre, t.title
) x
WHERE rn = 1 ORDER BY plays DESC;

-- The top titles of each genre with LATERAL
SELECT g.genre, top.title, top.plays
FROM (SELECT DISTINCT genre FROM titles) g
CROSS JOIN LATERAL (
  SELECT t.title, COUNT(*) AS plays
  FROM events e JOIN titles t ON t.title_id = e.title_id
  WHERE e.event_type = 'play' AND t.genre = g.genre
  GROUP BY t.title ORDER BY plays DESC, t.title LIMIT 2
) top
ORDER BY g.genre, top.plays DESC LIMIT 6;
