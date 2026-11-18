-- SQL for Everyone: From Zero to Confident
-- Chapter 11: Speed and Safety
-- Lesson 11.4: Index Types: Composite, Partial, Covering and GIN
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/index-types-composite-partial-covering-and-gin/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- A composite index on customer_id and page
CREATE INDEX idx_events_cust_page ON events_log (customer_id, page);

-- Both columns in the filter: the composite index is used
EXPLAIN (COSTS OFF) SELECT * FROM events_log WHERE customer_id = 100 AND page = 'checkout';

-- Only the second column: the index is not much use
EXPLAIN (COSTS OFF) SELECT * FROM events_log WHERE page = 'checkout';

-- A partial index covers only the checkout rows, and is smaller
CREATE INDEX idx_events_checkout ON events_log (logged_at) WHERE page = 'checkout';
SELECT pg_size_pretty(pg_relation_size('idx_events_checkout')) AS partial_size,
       pg_size_pretty(pg_relation_size('idx_events_cust_page')) AS composite_size;

-- An index on an expression: lower(email)
CREATE INDEX idx_cust_lower_email ON customers (lower(email));
EXPLAIN (COSTS OFF) SELECT * FROM customers WHERE lower(email) = 'mateo.ibrahim80@gmail.com';

-- Refresh the statistics with VACUUM ANALYZE
VACUUM ANALYZE events_log;

-- A covering index: INCLUDE adds a column
DROP INDEX idx_events_cust_page;
CREATE INDEX idx_events_cover ON events_log (customer_id) INCLUDE (page);
EXPLAIN (COSTS OFF) SELECT customer_id, page FROM events_log WHERE customer_id = 100;

-- Count the organic products
SELECT COUNT(*) AS organic_products FROM products WHERE attributes @> '{"organic": true}';

-- A GIN index on a JSONB column
CREATE INDEX idx_products_attr ON products USING gin (attributes);
SET enable_seqscan = off;
EXPLAIN (COSTS OFF) SELECT name FROM products WHERE attributes @> '{"organic": true}';
