-- SQL for Everyone: From Zero to Confident
-- Chapter 13: Project: Brewhouse Sales Analysis
-- Lesson 13.1: Project Brief
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/project-brief/

-- How big is each table?
SELECT (SELECT COUNT(*) FROM customers) AS customers,
       (SELECT COUNT(*) FROM products) AS products,
       (SELECT COUNT(*) FROM orders) AS orders,
       (SELECT COUNT(*) FROM order_items) AS order_lines;

-- The period covered by the orders
SELECT MIN(order_date)::date AS first_order, MAX(order_date)::date AS last_order FROM orders;

-- Orders by status, with their share
SELECT status, COUNT(*) AS orders,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM orders
GROUP BY status
ORDER BY orders DESC;

-- Orders by channel
SELECT channel, COUNT(*) AS orders FROM orders GROUP BY channel ORDER BY orders DESC;

-- Revenue of all orders against completed orders
SELECT ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue_all,
       ROUND(SUM(oi.quantity * oi.unit_price) FILTER (WHERE o.status = 'completed')) AS revenue_completed
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id;
