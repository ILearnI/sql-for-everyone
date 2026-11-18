-- SQL for Everyone: From Zero to Confident
-- Chapter 13: Project: Brewhouse Sales Analysis
-- Lesson 13.4: Part 3: Products
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/part-3-products/

-- Revenue by category
SELECT p.category, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue,
       ROUND(100.0 * SUM(oi.quantity * oi.unit_price) / SUM(SUM(oi.quantity * oi.unit_price)) OVER (), 1) AS pct
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY p.category
ORDER BY revenue DESC;

-- The best product of each category
SELECT category, name, revenue
FROM (
  SELECT p.category, p.name, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue,
         ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS rn
  FROM products p
  JOIN order_items oi ON oi.product_id = p.product_id
  JOIN orders o ON o.order_id = oi.order_id
  WHERE o.status = 'completed'
  GROUP BY p.category, p.name
) t
WHERE rn = 1
ORDER BY category;

-- The best-selling products by units
SELECT p.name, SUM(oi.quantity) AS units
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY p.name
ORDER BY units DESC
LIMIT 3;

-- The most profitable products
SELECT p.name, ROUND(SUM(oi.quantity * (oi.unit_price - p.cost))) AS profit
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY p.name
ORDER BY profit DESC
LIMIT 3;

-- Products often bought together
SELECT a.name AS product_a, b.name AS product_b, COUNT(*) AS orders_together
FROM order_items x
JOIN order_items y ON y.order_id = x.order_id AND x.product_id < y.product_id
JOIN products a ON a.product_id = x.product_id
JOIN products b ON b.product_id = y.product_id
JOIN orders o ON o.order_id = x.order_id
WHERE o.status = 'completed'
GROUP BY a.name, b.name
ORDER BY orders_together DESC, product_a, product_b
LIMIT 3;

-- Products with no completed sales
SELECT p.name, ROUND(COALESCE(SUM(oi.quantity * oi.unit_price) FILTER (WHERE o.status = 'completed'), 0)) AS revenue
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
LEFT JOIN orders o ON o.order_id = oi.order_id
GROUP BY p.name
ORDER BY revenue
LIMIT 3;
