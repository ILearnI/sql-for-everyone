-- SQL for Everyone: From Zero to Confident
-- Chapter 19: Project: Streamly Growth Analysis
-- Lesson 19.1: Project 2 Brief
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/project-2-brief/

-- How big is each table?
SELECT (SELECT COUNT(*) FROM users) AS users, (SELECT COUNT(*) FROM subscriptions) AS subscriptions,
       (SELECT COUNT(*) FROM payments) AS payments, (SELECT COUNT(*) FROM events) AS events,
       (SELECT COUNT(*) FROM visits) AS visits, (SELECT COUNT(*) FROM support_tickets) AS tickets;

-- The signup period, by year
SELECT MIN(signup_date) AS first_signup, MAX(signup_date) AS last_signup,
       COUNT(*) FILTER (WHERE signup_date < '2025-01-01') AS signups_2024,
       COUNT(*) FILTER (WHERE signup_date >= '2025-01-01') AS signups_2025
FROM users;

-- Active and ended paid subscriptions
SELECT COUNT(*) FILTER (WHERE end_date IS NULL) AS active_paid, COUNT(*) FILTER (WHERE end_date IS NOT NULL) AS ended_paid
FROM subscriptions WHERE plan_id > 1;

-- Payments by status
SELECT status, COUNT(*) AS payments FROM payments GROUP BY status ORDER BY payments DESC;

-- Payments to review: missing or suspicious amounts
SELECT COUNT(*) AS payments_to_review FROM payments WHERE amount IS NULL OR amount > 20.49;

-- Users with and without an email
SELECT COUNT(*) AS users, COUNT(email) AS with_email, COUNT(*) - COUNT(email) AS without_email FROM users;
