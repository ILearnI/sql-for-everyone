-- SQL for Everyone: From Zero to Confident
-- Chapter 15: Analytics Patterns
-- Lesson 15.1: Calendar Tables and Filling Gaps
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/calendar-tables-and-filling-gaps/

-- Signups per month: months with none disappear
SELECT date_trunc('month', signup_date)::date AS month, COUNT(*) AS signups
FROM users
WHERE signup_date >= '2025-01-01' AND signup_date < '2026-01-01'
GROUP BY 1 ORDER BY 1;

-- A calendar fills the gaps
SELECT m::date AS month, COUNT(u.user_id) AS signups
FROM generate_series(DATE '2025-01-01', DATE '2025-12-01', INTERVAL '1 month') m
LEFT JOIN users u ON date_trunc('month', u.signup_date) = m
GROUP BY m ORDER BY m;

-- count(*) against count(u.user_id) on empty months
SELECT m::date AS month, COUNT(*) AS wrong_count, COUNT(u.user_id) AS right_count
FROM generate_series(DATE '2025-07-01', DATE '2025-09-01', INTERVAL '1 month') m
LEFT JOIN users u ON date_trunc('month', u.signup_date) = m
GROUP BY m ORDER BY m;

-- The same by day
SELECT d::date AS day, COUNT(u.user_id) AS signups
FROM generate_series(DATE '2025-08-29', DATE '2025-09-02', INTERVAL '1 day') d
LEFT JOIN users u ON u.signup_date = d::date
GROUP BY d ORDER BY d;

-- Days without a single signup
SELECT COUNT(*) AS days_without_signups
FROM generate_series(DATE '2024-01-01', DATE '2025-12-31', INTERVAL '1 day') g(day)
WHERE NOT EXISTS (SELECT 1 FROM users u WHERE u.signup_date = g.day::date);
