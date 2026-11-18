-- SQL for Everyone: From Zero to Confident
-- Chapter 18: SQL in the Real World
-- Lesson 18.1: Connecting Excel, Power BI and Metabase
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/connecting-excel-power-bi-and-metabase/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Where am I connected? (\conninfo)
\conninfo

-- A view for the chart
CREATE VIEW v_monthly_revenue AS
SELECT date_trunc('month', o.order_date)::date AS month, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY 1;

-- The first points of the chart
SELECT * FROM v_monthly_revenue ORDER BY month LIMIT 3;

-- How many points on the chart?
SELECT COUNT(*) AS points_on_the_chart, MIN(month) AS first_month, MAX(month) AS last_month FROM v_monthly_revenue;

-- The best month
SELECT month, revenue FROM v_monthly_revenue ORDER BY revenue DESC LIMIT 1;

-- A shell command to prepare a folder
\! mkdir -p /tmp/export && chmod 777 /tmp/export

-- COPY the view to a CSV file
COPY (SELECT month, revenue FROM v_monthly_revenue ORDER BY month) TO '/tmp/export/monthly_revenue.csv' WITH (FORMAT csv, HEADER true);

-- Look at the file
\! head -4 /tmp/export/monthly_revenue.csv && wc -l < /tmp/export/monthly_revenue.csv
