-- SQL for Everyone: From Zero to Confident
-- Chapter 7: Joining Tables
-- Lesson 7.6: Joining Three or More Tables
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/joining-three-or-more-tables/

-- Join orders and customers and order_items
SELECT o.order_id, c.first_name, p.name, oi.quantity,
       oi.quantity * oi.unit_price AS line_total
FROM orders o
JOIN customers c   ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p    ON p.product_id = oi.product_id
WHERE o.order_id = 1042
ORDER BY oi.order_item_id;

-- Join order_items and products
SELECT p.category, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Join customers and orders and order_items
SELECT c.country, p.category, ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.status = 'completed'
GROUP BY c.country, p.category
ORDER BY revenue DESC
LIMIT 3;

-- Join products and order_items and orders
SELECT p.name, SUM(oi.quantity) AS units
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY p.name
ORDER BY units DESC
LIMIT 3;

-- LEFT JOIN of products and order_items
SELECT p.name, SUM(oi.quantity) AS units
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY units
LIMIT 2;
