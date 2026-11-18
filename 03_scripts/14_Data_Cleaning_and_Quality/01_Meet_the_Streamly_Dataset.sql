-- SQL for Everyone: From Zero to Confident
-- Chapter 14: Data Cleaning and Quality
-- Lesson 14.1: Meet the Streamly Dataset
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/meet-the-streamly-dataset/

-- List the tables
\dt

-- Row counts of the main tables
SELECT 'users' AS table_name, COUNT(*) AS row_count FROM users
UNION ALL SELECT 'subscriptions', COUNT(*) FROM subscriptions
UNION ALL SELECT 'payments', COUNT(*) FROM payments
UNION ALL SELECT 'events', COUNT(*) FROM events
UNION ALL SELECT 'support_tickets', COUNT(*) FROM support_tickets
UNION ALL SELECT 'contacts_raw', COUNT(*) FROM contacts_raw;

-- The first users
SELECT * FROM users ORDER BY user_id LIMIT 3;

-- Subscriptions per plan
SELECT p.name AS plan, COUNT(*) AS subscriptions
FROM subscriptions s JOIN plans p ON p.plan_id = s.plan_id
GROUP BY p.name
ORDER BY subscriptions DESC;

-- The raw contacts: messy on purpose
SELECT contact_id, full_name, email, country, signup_date, plan
FROM contacts_raw
ORDER BY contact_id
LIMIT 6;

-- The signup period, and August 2025
SELECT MIN(signup_date) AS first_signup, MAX(signup_date) AS last_signup,
       COUNT(*) FILTER (WHERE signup_date >= '2025-08-01' AND signup_date < '2025-09-01') AS signups_in_august_2025
FROM users;
