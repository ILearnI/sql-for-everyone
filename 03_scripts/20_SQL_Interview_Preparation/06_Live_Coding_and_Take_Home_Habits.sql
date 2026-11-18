-- SQL for Everyone: From Zero to Confident
-- Chapter 20: SQL Interview Preparation
-- Lesson 20.6: Live Coding and Take-Home Habits
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/live-coding-and-take-home-habits/

-- Explore first: orders by status
SELECT status, COUNT(*) AS orders FROM orders GROUP BY status ORDER BY orders DESC;

-- Orders per channel in December 2025
SELECT channel, COUNT(*) AS orders FROM orders
WHERE order_date >= '2025-12-01' AND order_date < '2026-01-01' GROUP BY channel ORDER BY orders DESC;

-- A check: the December total
SELECT COUNT(*) AS december_orders FROM orders WHERE order_date >= '2025-12-01' AND order_date < '2026-01-01';

-- A clean take-home query: assumption, comment, one clause per line
-- Q1: orders per channel in December 2025. Assumption: only completed orders count.
SELECT channel, COUNT(*) AS orders FROM orders
WHERE status = 'completed' AND order_date >= '2025-12-01' AND order_date < '2026-01-01'
GROUP BY channel ORDER BY orders DESC;
