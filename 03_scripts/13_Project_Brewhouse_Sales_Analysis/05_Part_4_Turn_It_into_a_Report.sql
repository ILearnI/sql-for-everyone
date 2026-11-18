-- SQL for Everyone: From Zero to Confident
-- Chapter 13: Project: Brewhouse Sales Analysis
-- Lesson 13.5: Part 4: Turn It into a Report
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/part-4-turn-it-into-a-report/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- A view of the completed order lines
CREATE VIEW v_completed_lines AS
SELECT o.order_id, o.customer_id, o.order_date, o.channel, p.name AS product, p.category,
       oi.quantity * oi.unit_price AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.status = 'completed';

-- Three more views built on it: monthly revenue, customer tiers, product ranking
CREATE VIEW v_monthly_revenue AS
SELECT date_trunc('month', order_date)::date AS month, ROUND(SUM(revenue)) AS revenue
FROM v_completed_lines GROUP BY 1;
CREATE VIEW v_customer_tiers AS
SELECT customer_id, ROUND(SUM(revenue)) AS spent,
       CASE WHEN SUM(revenue) >= 1000 THEN 'gold' WHEN SUM(revenue) >= 300 THEN 'silver' ELSE 'bronze' END AS tier
FROM v_completed_lines GROUP BY customer_id;
CREATE VIEW v_product_ranking AS
SELECT category, product, ROUND(SUM(revenue)) AS revenue,
       RANK() OVER (PARTITION BY category ORDER BY SUM(revenue) DESC) AS rank_in_category
FROM v_completed_lines GROUP BY category, product;

-- The latest two months
SELECT * FROM v_monthly_revenue ORDER BY month DESC LIMIT 2;

-- Customers in each tier
SELECT tier, COUNT(*) AS customers FROM v_customer_tiers GROUP BY tier ORDER BY customers;

-- The top product of each category
SELECT category, product, revenue FROM v_product_ranking WHERE rank_in_category = 1 ORDER BY category;

-- Build a summary table for the report
CREATE TABLE report_summary AS
SELECT 1 AS ord, 'total_revenue' AS metric, ROUND(SUM(revenue))::text AS value FROM v_completed_lines
UNION ALL SELECT 2, 'average_order_value', ROUND(SUM(revenue) / COUNT(DISTINCT order_id), 2)::text FROM v_completed_lines
UNION ALL SELECT 3, 'active_customers', COUNT(DISTINCT customer_id)::text FROM v_completed_lines
UNION ALL SELECT 4, 'gold_customers', COUNT(*)::text FROM v_customer_tiers WHERE tier = 'gold'
UNION ALL SELECT 5, 'best_month', (SELECT month::text FROM v_monthly_revenue ORDER BY revenue DESC LIMIT 1)
UNION ALL SELECT 6, 'top_product_by_revenue', (SELECT product FROM v_product_ranking ORDER BY revenue DESC LIMIT 1);

-- Read the summary
SELECT metric, value FROM report_summary ORDER BY ord;

-- Document a view with COMMENT
COMMENT ON VIEW v_monthly_revenue IS 'Revenue per month, completed orders only';
SELECT obj_description('v_monthly_revenue'::regclass, 'pg_class') AS description;

-- Check the total against the raw tables
SELECT ROUND(SUM(oi.quantity * oi.unit_price)) AS check_total
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed';
