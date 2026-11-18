# SQL cheat sheet

PostgreSQL syntax from the course, in lesson order. The coloured web version is at https://www.codepion.com/exercises/udemy-sql-course/cheat-sheet/

Examples use the Brewhouse shop tables.

## Getting Started

psql basics and your very first queries.

### Your First Queries

Count rows

```sql
SELECT count(*) FROM customers;
```

Pick columns, show a few rows

```sql
SELECT name, price FROM products LIMIT 3;
```

List tables, describe one (psql)

```sql
\dt
\d customers
```

## Querying Data

Read columns, rename them, remove duplicates, sort and page.

### SELECT and FROM

All columns / chosen columns

```sql
SELECT * FROM products;
SELECT name, price FROM products;
```

### Aliases and Expressions

Name a result column, calculate

```sql
SELECT name,
       price * 1.2 AS price_with_tax
FROM products;
```

Join text together

```sql
SELECT first_name || ' ' || last_name AS full_name FROM customers;
```

### DISTINCT

Unique values / unique pairs

```sql
SELECT DISTINCT category FROM products;
SELECT DISTINCT category, price FROM products;
```

### ORDER BY

Sort, then break ties

```sql
SELECT name, price FROM products
ORDER BY price DESC, name ASC;
```

Where NULLs go

```sql
ORDER BY price DESC NULLS LAST
```

### LIMIT and OFFSET

Top 5, and page 3 of 10 rows per page

```sql
SELECT * FROM products ORDER BY price DESC LIMIT 5;
SELECT * FROM products ORDER BY id LIMIT 10 OFFSET 20;
```

### Writing Readable SQL and Reading Error Messages

One clause per line, keywords in capitals, comments for the why

```sql
-- revenue per category
SELECT category,
       sum(price) AS total
FROM products
GROUP BY category;
```

Read errors from the top: the message, the LINE marker and the caret show the spot

### How a Query Runs

Logical order the database follows

```sql
FROM -> WHERE -> GROUP BY -> HAVING
-> SELECT -> DISTINCT -> ORDER BY -> LIMIT
```

So a SELECT alias works in ORDER BY but not in WHERE

## Filtering Data

Keep only the rows you want.

### WHERE and Comparison Operators

Compare

```sql
WHERE price >= 10
WHERE category = 'Beer'
WHERE category <> 'Beer'   -- also !=
```

### AND, OR and NOT

Combine conditions (use brackets when mixing AND and OR)

```sql
WHERE (category = 'Beer' OR category = 'Cider')
  AND price < 5
  AND NOT is_active
```

### IN and BETWEEN

A list, a range (both ends included)

```sql
WHERE category IN ('Beer', 'Cider')
WHERE price BETWEEN 5 AND 10
WHERE category NOT IN ('Beer')
```

### LIKE and ILIKE

% = any text, _ = one character, ILIKE ignores case

```sql
WHERE name LIKE 'Pale%'
WHERE name ILIKE '%ale%'
WHERE code LIKE 'A_1'
```

### NULL and IS NULL

NULL is never equal to anything, test it with IS

```sql
WHERE phone IS NULL
WHERE phone IS NOT NULL
WHERE a IS DISTINCT FROM b   -- NULL-safe comparison
```

### Regular Expressions

Match a pattern (~ case sensitive, ~* ignores case)

```sql
WHERE email ~ '^[a-z]+@'
WHERE name ~* 'ipa$'
WHERE name !~ '[0-9]'
```

## Functions and Expressions

Transform values inside a query.

### String Functions

Common text functions

```sql
upper(s)  lower(s)  length(s)  trim(s)
substring(s FROM 1 FOR 3)  left(s, 3)  right(s, 3)
replace(s, 'a', 'b')  split_part(s, ',', 2)
concat(a, b)  concat_ws('-', a, b)  initcap(s)
position('x' IN s)  lpad(s, 5, '0')
```

### Number Functions

Round and friends

```sql
round(x, 2)  ceil(x)  floor(x)  abs(x)
mod(10, 3)  power(2, 8)  sqrt(x)
x::int  -- cast
7 / 2   -- 3 (integers)   7 / 2.0 -- 3.5
```

### Dates and Times

Now, today, build a date

```sql
now()  current_date  current_timestamp
make_date(2026, 11, 18)
'2026-11-18'::date
to_char(d, 'YYYY-MM-DD')  to_date('18/11/2026', 'DD/MM/YYYY')
```

### Date Arithmetic and EXTRACT

Add intervals, read parts, cut to a unit

```sql
d + INTERVAL '7 days'
age(now(), created_at)
EXTRACT(YEAR FROM d)  EXTRACT(DOW FROM d)
date_trunc('month', d)
```

### JSON and JSONB

Read values out of JSONB

```sql
data -> 'address'            -- JSON
data ->> 'city'              -- text
data #>> '{address,city}'    -- path
data @> '{"vip": true}'      -- contains
jsonb_array_elements(data -> 'tags')
```

### Arrays and generate_series

Arrays

```sql
ARRAY[1, 2, 3]
tags[1]          -- first element (1-based)
'beer' = ANY(tags)
unnest(tags)
array_length(tags, 1)
```

Make rows from nothing

```sql
SELECT generate_series(1, 5);
SELECT generate_series('2026-01-01'::date, '2026-01-07', '1 day');
```

### Full-Text Search Basics

Search words, not characters

```sql
WHERE to_tsvector('english', body) @@ to_tsquery('english', 'coffee & roast')
WHERE to_tsvector(body) @@ plainto_tsquery('hoppy beer')
```

### CASE Expressions

If / else inside a query

```sql
CASE
  WHEN price < 5  THEN 'cheap'
  WHEN price < 15 THEN 'normal'
  ELSE 'premium'
END AS price_band
```

### COALESCE, NULLIF and CAST

Defaults, avoid divide by zero, change type

```sql
COALESCE(phone, 'unknown')
sum(x) / NULLIF(count(*), 0)
CAST(price AS integer)   price::integer
```

## Aggregating Data

Turn many rows into one number per group.

### COUNT, SUM, AVG, MIN and MAX

The five aggregates

```sql
SELECT count(*), count(phone), count(DISTINCT city),
       sum(price), avg(price), min(price), max(price)
FROM customers;
```

count(*) counts rows, count(col) skips NULLs

### GROUP BY

One row per group

```sql
SELECT category, count(*) AS products
FROM products
GROUP BY category;
```

### Grouping by Several Columns

One row per combination

```sql
SELECT city, category, sum(price)
FROM products
GROUP BY city, category;
```

### HAVING

Filter groups (WHERE filters rows before grouping)

```sql
SELECT category, count(*)
FROM products
GROUP BY category
HAVING count(*) > 5;
```

### ROLLUP, CUBE and Grouping Sets

Subtotals and grand totals

```sql
GROUP BY ROLLUP (year, month)
GROUP BY CUBE (category, city)
GROUP BY GROUPING SETS ((category), (city), ())
GROUPING(category)   -- 1 on a subtotal row
```

### FILTER and Conditional Aggregation

Count only some rows

```sql
count(*) FILTER (WHERE status = 'paid')
sum(total) FILTER (WHERE city = 'Leeds')
sum(CASE WHEN status = 'paid' THEN total ELSE 0 END)
```

### Pivoting Data

Rows to columns by hand

```sql
SELECT category,
       sum(total) FILTER (WHERE year = 2025) AS y2025,
       sum(total) FILTER (WHERE year = 2026) AS y2026
FROM sales GROUP BY category;
```

### string_agg, array_agg and DISTINCT ON

Collect values, keep the first row per group

```sql
string_agg(name, ', ' ORDER BY name)
array_agg(DISTINCT category)
SELECT DISTINCT ON (customer_id) *
FROM orders
ORDER BY customer_id, ordered_at DESC;
```

### Statistics in SQL

Spread and relationships

```sql
stddev(x)  variance(x)  corr(x, y)
percentile_cont(0.5) WITHIN GROUP (ORDER BY x)   -- median
mode() WITHIN GROUP (ORDER BY x)
```

## Creating and Changing Data

Design tables and change what is in them.

### Data Types

The ones you use most

```sql
integer  bigint  numeric(10, 2)  real
text  varchar(50)  boolean
date  time  timestamp  timestamptz  interval
jsonb  uuid  integer[]
```

### CREATE TABLE

A table with defaults

```sql
CREATE TABLE tasks (
  id         serial PRIMARY KEY,
  title      text NOT NULL,
  done       boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);
```

### Primary and Foreign Keys

Link tables

```sql
id integer PRIMARY KEY
customer_id integer REFERENCES customers (id)
customer_id integer REFERENCES customers (id) ON DELETE CASCADE
```

### Constraints

Rules the data must follow

```sql
NOT NULL
UNIQUE
CHECK (price >= 0)
CONSTRAINT price_positive CHECK (price > 0)
ALTER TABLE t ADD CONSTRAINT u UNIQUE (email);
```

### INSERT

One row, many rows, rows from a query

```sql
INSERT INTO tasks (title) VALUES ('Write notes');
INSERT INTO tasks (title) VALUES ('a'), ('b'), ('c');
INSERT INTO archive SELECT * FROM tasks WHERE done;
```

### UPDATE and DELETE Safely

Always have a WHERE; test it with SELECT first

```sql
SELECT * FROM tasks WHERE id = 7;
UPDATE tasks SET done = true WHERE id = 7;
DELETE FROM tasks WHERE id = 7;
```

### UPSERT and RETURNING

Insert or update, and get the row back

```sql
INSERT INTO stock (sku, qty) VALUES ('A1', 5)
ON CONFLICT (sku) DO UPDATE SET qty = stock.qty + EXCLUDED.qty
RETURNING *;
-- or: ON CONFLICT DO NOTHING
```

### MERGE

Several actions in one statement

```sql
MERGE INTO stock s
USING deliveries d ON s.sku = d.sku
WHEN MATCHED THEN UPDATE SET qty = s.qty + d.qty
WHEN NOT MATCHED THEN INSERT (sku, qty) VALUES (d.sku, d.qty);
```

### Identity Columns, Sequences and Generated Columns

Automatic numbers and calculated columns

```sql
id integer GENERATED ALWAYS AS IDENTITY
CREATE SEQUENCE order_no START 1000;
nextval('order_no')
total numeric GENERATED ALWAYS AS (price * qty) STORED
```

### Enums and Custom Types

A fixed list of values

```sql
CREATE TYPE status AS ENUM ('new', 'paid', 'shipped');
ALTER TYPE status ADD VALUE 'refunded';
```

### ALTER TABLE and DROP

Change a table

```sql
ALTER TABLE t ADD COLUMN note text;
ALTER TABLE t DROP COLUMN note;
ALTER TABLE t RENAME COLUMN a TO b;
ALTER TABLE t ALTER COLUMN price TYPE numeric(10, 2);
DROP TABLE IF EXISTS t;
```

## Joining Tables

Combine tables on matching columns.

### Why Joins?

Data lives in separate tables, linked by keys

```sql
orders.customer_id  ->  customers.id
```

### INNER JOIN

Only rows that match on both sides

```sql
SELECT c.name, o.total
FROM orders o
JOIN customers c ON c.id = o.customer_id;
```

### LEFT JOIN

Keep every left row, NULL when no match

```sql
SELECT c.name, o.id
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id;
```

### RIGHT and FULL JOIN

Keep the right side / both sides

```sql
FROM a RIGHT JOIN b ON ...
FROM a FULL JOIN b ON ...
```

### CROSS and Self Joins

Every combination; a table joined to itself

```sql
FROM sizes CROSS JOIN colours
FROM employees e JOIN employees m ON m.id = e.manager_id
```

### Joining Three or More Tables

Chain the joins

```sql
FROM orders o
JOIN customers c ON c.id = o.customer_id
JOIN order_items i ON i.order_id = o.id
JOIN products p ON p.id = i.product_id
```

### UPDATE FROM, DELETE USING and TRUNCATE

Change or delete using another table; empty a table fast

```sql
UPDATE products p SET price = n.price
FROM new_prices n WHERE n.id = p.id;
DELETE FROM orders o USING customers c
WHERE c.id = o.customer_id AND c.is_test;
TRUNCATE TABLE logs;
```

### UNION, INTERSECT and EXCEPT

Stack result sets (same columns)

```sql
SELECT name FROM a UNION SELECT name FROM b;       -- no duplicates
SELECT name FROM a UNION ALL SELECT name FROM b;   -- keep duplicates
SELECT name FROM a INTERSECT SELECT name FROM b;
SELECT name FROM a EXCEPT SELECT name FROM b;
```

### USING, NATURAL and Non-Equi Joins

Shorter joins, and joins on ranges

```sql
JOIN customers USING (customer_id)
NATURAL JOIN customers   -- avoid: joins on every same-named column
JOIN tiers t ON o.total >= t.min_total AND o.total < t.max_total
```

### Anti-Joins and Semi-Joins

Rows with / without a match

```sql
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id)
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id)
LEFT JOIN orders o ON ... WHERE o.id IS NULL
```

### LATERAL Joins

A subquery that can see the row to its left

```sql
SELECT c.name, last_o.*
FROM customers c
CROSS JOIN LATERAL (
  SELECT * FROM orders o
  WHERE o.customer_id = c.id
  ORDER BY ordered_at DESC LIMIT 1
) last_o;
```

### Join Fan-Out: Why Totals Double

Joining a one-to-many table repeats rows. Aggregate first, then join

```sql
WITH item_totals AS (
  SELECT order_id, sum(qty * price) AS t
  FROM order_items GROUP BY order_id
)
SELECT o.id, t FROM orders o JOIN item_totals USING (order_id);
```

## Subqueries and CTEs

Queries inside queries, and naming the steps.

### Subqueries in WHERE

Compare to a value or a list from another query

```sql
WHERE price > (SELECT avg(price) FROM products)
WHERE id IN (SELECT product_id FROM order_items)
```

### Subqueries in FROM and SELECT

A query as a table; a query as a column

```sql
SELECT * FROM (SELECT category, avg(price) AS a FROM products GROUP BY category) x;
SELECT name, (SELECT count(*) FROM orders o WHERE o.customer_id = c.id) AS orders
FROM customers c;
```

### EXISTS and NOT EXISTS

True as soon as one row is found

```sql
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id)
```

### Common Table Expressions

Name a step with WITH

```sql
WITH big AS (
  SELECT * FROM orders WHERE total > 100
)
SELECT count(*) FROM big;
```

### Several CTEs and Recursive CTEs

Chain CTEs; walk a hierarchy

```sql
WITH a AS (...), b AS (SELECT ... FROM a)
SELECT * FROM b;

WITH RECURSIVE tree AS (
  SELECT id, name, manager_id FROM employees WHERE manager_id IS NULL
  UNION ALL
  SELECT e.id, e.name, e.manager_id
  FROM employees e JOIN tree t ON e.manager_id = t.id
)
SELECT * FROM tree;
```

### Correlated Subqueries

A subquery that uses the outer row

```sql
WHERE price > (SELECT avg(price) FROM products p2
               WHERE p2.category = p.category)
```

## Window Functions

Calculate across related rows without collapsing them.

### What Is a Window Function?

Keep every row, add a calculation

```sql
SELECT name, price,
       avg(price) OVER () AS overall_avg
FROM products;
```

### PARTITION BY and ORDER BY

Restart per group, order inside the group

```sql
avg(price) OVER (PARTITION BY category)
sum(total) OVER (PARTITION BY customer_id ORDER BY ordered_at)
```

### Ranking: ROW_NUMBER, RANK and DENSE_RANK

Number the rows

```sql
row_number() OVER (ORDER BY price DESC)   -- 1 2 3 4
rank()       OVER (ORDER BY price DESC)   -- 1 2 2 4
dense_rank() OVER (ORDER BY price DESC)   -- 1 2 2 3
```

### Running Totals and Frames

Cumulative and moving values

```sql
sum(total) OVER (ORDER BY d)
avg(total) OVER (ORDER BY d ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
```

### LAG and LEAD

Previous and next row

```sql
lag(total, 1) OVER (ORDER BY d)
lead(total) OVER (ORDER BY d)
total - lag(total) OVER (ORDER BY d) AS change
```

### NTILE, FIRST_VALUE and Percentiles

Buckets and edge values

```sql
ntile(4) OVER (ORDER BY total)
first_value(name) OVER (PARTITION BY category ORDER BY price DESC)
last_value(name) OVER (... ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
```

### Named Windows and Distribution Functions

Reuse a window; relative position

```sql
SELECT sum(x) OVER w, avg(x) OVER w
FROM t
WINDOW w AS (PARTITION BY g ORDER BY d);
percent_rank() OVER (ORDER BY x)   cume_dist() OVER (ORDER BY x)
```

### Frame Types: ROWS, RANGE and GROUPS

What counts as a neighbour

```sql
ROWS   BETWEEN 2 PRECEDING AND CURRENT ROW   -- physical rows
RANGE  BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW   -- by value
GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW   -- by peer groups
```

## Views and Reusable SQL

Save queries and logic inside the database.

### Views

A saved query that acts like a table

```sql
CREATE VIEW active_customers AS
SELECT * FROM customers WHERE is_active;
CREATE OR REPLACE VIEW ...;
DROP VIEW active_customers;
```

### Materialized Views

A saved result you refresh

```sql
CREATE MATERIALIZED VIEW monthly_sales AS SELECT ...;
REFRESH MATERIALIZED VIEW monthly_sales;
REFRESH MATERIALIZED VIEW CONCURRENTLY monthly_sales;   -- needs a unique index
```

### Temporary Tables and CREATE TABLE AS

Scratch tables and copies

```sql
CREATE TEMP TABLE work AS SELECT * FROM orders WHERE total > 100;
CREATE TABLE backup AS TABLE orders;
```

### SQL Functions

Reusable calculation

```sql
CREATE FUNCTION with_tax(p numeric) RETURNS numeric
LANGUAGE sql AS $$ SELECT p * 1.2 $$;
SELECT with_tax(10);
```

### Stored Procedures and PL/pgSQL

Logic with variables, IF and loops

```sql
CREATE FUNCTION grade(score int) RETURNS text
LANGUAGE plpgsql AS $$
BEGIN
  IF score >= 50 THEN RETURN 'pass';
  ELSE RETURN 'fail';
  END IF;
END $$;

CREATE PROCEDURE close_day() LANGUAGE sql AS $$ ... $$;
CALL close_day();
```

### Triggers

Run a function automatically on change

```sql
CREATE TRIGGER set_updated
BEFORE UPDATE ON tasks
FOR EACH ROW EXECUTE FUNCTION touch_updated_at();
-- inside: NEW.col, OLD.col, RETURN NEW;
```

## Speed and Safety

Make queries fast and changes safe.

### Indexes

Speed up lookups on a column

```sql
CREATE INDEX idx_orders_customer ON orders (customer_id);
CREATE UNIQUE INDEX ON customers (email);
DROP INDEX idx_orders_customer;
```

### Reading a Query Plan with EXPLAIN

Show the plan, or run it and time it

```sql
EXPLAIN SELECT ...;
EXPLAIN ANALYZE SELECT ...;   -- really runs the query
EXPLAIN (ANALYZE, BUFFERS) SELECT ...;
-- look for: Seq Scan vs Index Scan, rows estimated vs actual
```

### Transactions

All or nothing

```sql
BEGIN;
UPDATE accounts SET balance = balance - 50 WHERE id = 1;
UPDATE accounts SET balance = balance + 50 WHERE id = 2;
COMMIT;   -- or ROLLBACK;
SAVEPOINT s1;  ROLLBACK TO s1;
```

### Index Types: Composite, Partial, Covering and GIN

Pick the right kind

```sql
CREATE INDEX ON orders (customer_id, ordered_at);        -- composite: leftmost column first
CREATE INDEX ON orders (id) WHERE status = 'open';       -- partial
CREATE INDEX ON orders (customer_id) INCLUDE (total);    -- covering
CREATE INDEX ON docs USING gin (tags);                   -- arrays, jsonb, full text
```

### Locks, Isolation Levels and MVCC

Control concurrent changes

```sql
SELECT * FROM t WHERE id = 1 FOR UPDATE;
SELECT * FROM t FOR UPDATE SKIP LOCKED;
BEGIN ISOLATION LEVEL REPEATABLE READ;
-- levels: READ COMMITTED (default), REPEATABLE READ, SERIALIZABLE
```

### Maintenance: VACUUM, ANALYZE and Statistics

Clean up and refresh planner statistics

```sql
VACUUM;  VACUUM (VERBOSE, ANALYZE) orders;
ANALYZE orders;
SELECT * FROM pg_stat_user_tables;
```

### Partitioning Basics

Split a big table by a key

```sql
CREATE TABLE events (id bigint, at date, data jsonb)
PARTITION BY RANGE (at);
CREATE TABLE events_2026 PARTITION OF events
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
```

### Writing Faster Queries

Habits that help

```sql
-- select only the columns you need
-- filter early, index the columns you filter and join on
-- EXISTS instead of IN for big lists
-- avoid functions on indexed columns: WHERE lower(email) = ... needs its own index
```

## Working with Real Data

Import, design and clean up real data.

### Importing and Exporting CSV

Load and save files

```sql
\copy customers FROM 'customers.csv' CSV HEADER
\copy (SELECT * FROM orders) TO 'orders.csv' CSV HEADER
COPY customers FROM '/work/customers.csv' CSV HEADER;   -- server side
```

### Designing a Schema

Steps

```sql
-- 1. list the things (tables) and their facts (columns)
-- 2. pick a primary key for each table
-- 3. connect tables with foreign keys
-- 4. add NOT NULL, UNIQUE and CHECK rules
```

### Normalisation in Plain English

One fact in one place

```sql
-- no repeating groups in one column
-- every column depends on the whole key
-- no column depends on another non-key column
```

### Using AI to Write and Debug SQL

Give it the schema, the goal and a sample; always check results by hand

```sql
-- tell the AI: table definitions, the question, the dialect (PostgreSQL)
-- verify with count(*), a spot check and EXPLAIN
```

## Data Cleaning and Quality

Find and fix problems in messy data.

### Profiling a Table

Know your data first

```sql
SELECT count(*), count(email), count(DISTINCT email),
       min(created_at), max(created_at)
FROM users;
```

### Finding and Removing Duplicates

Find, then delete all but one

```sql
SELECT email, count(*) FROM users GROUP BY email HAVING count(*) > 1;

DELETE FROM users WHERE id IN (
  SELECT id FROM (
    SELECT id, row_number() OVER (PARTITION BY email ORDER BY id) AS rn
    FROM users
  ) x WHERE rn > 1
);
```

### Standardising Text, Dates and Categories

Same value, one spelling

```sql
lower(trim(email))
CASE WHEN country IN ('UK', 'U.K.', 'United Kingdom') THEN 'GB' ELSE country END
to_date(raw, 'DD/MM/YYYY')
```

### Missing Values and Outliers

Fill, flag or remove

```sql
COALESCE(age, 0)
WHERE age IS NULL
WHERE price NOT BETWEEN
  (SELECT percentile_cont(0.01) WITHIN GROUP (ORDER BY price) FROM t)
  AND (SELECT percentile_cont(0.99) WITHIN GROUP (ORDER BY price) FROM t)
```

### Validating Data with Constraints and Checks

Stop bad data at the door

```sql
ALTER TABLE users ADD CONSTRAINT email_format CHECK (email LIKE '%_@_%');
ALTER TABLE users ADD CONSTRAINT age_range CHECK (age BETWEEN 0 AND 120) NOT VALID;
ALTER TABLE users VALIDATE CONSTRAINT age_range;
```

## Analytics Patterns

Recipes analysts use again and again.

### Calendar Tables and Filling Gaps

Show days with no sales

```sql
SELECT d::date, coalesce(sum(o.total), 0) AS revenue
FROM generate_series('2026-01-01'::date, '2026-01-31', '1 day') d
LEFT JOIN orders o ON o.ordered_at::date = d
GROUP BY d ORDER BY d;
```

### Year-over-Year and Period Comparisons

Compare to the same month last year

```sql
SELECT month, revenue,
       lag(revenue, 12) OVER (ORDER BY month) AS last_year,
       round(100.0 * (revenue / lag(revenue, 12) OVER (ORDER BY month) - 1), 1) AS growth_pct
FROM monthly;
```

### Cohort Retention

Group users by first month, count activity later

```sql
WITH first AS (
  SELECT user_id, date_trunc('month', min(at)) AS cohort FROM events GROUP BY user_id
)
SELECT cohort, date_trunc('month', e.at) AS active_month, count(DISTINCT e.user_id)
FROM events e JOIN first USING (user_id)
GROUP BY 1, 2;
```

### Funnels and Conversion

Count users reaching each step

```sql
SELECT count(DISTINCT user_id) FILTER (WHERE step = 'view') AS viewed,
       count(DISTINCT user_id) FILTER (WHERE step = 'cart') AS carted,
       count(DISTINCT user_id) FILTER (WHERE step = 'buy')  AS bought
FROM events;
```

### RFM Customer Segmentation

Recency, Frequency, Monetary in quartiles

```sql
SELECT customer_id,
       ntile(4) OVER (ORDER BY max(ordered_at))   AS r,
       ntile(4) OVER (ORDER BY count(*))          AS f,
       ntile(4) OVER (ORDER BY sum(total))        AS m
FROM orders GROUP BY customer_id;
```

### Gaps and Islands

Group consecutive values by subtracting the row number

```sql
SELECT min(d), max(d), count(*)
FROM (SELECT d, d - (row_number() OVER (ORDER BY d))::int AS grp FROM days) x
GROUP BY grp;
```

### Sessionisation

A new session after 30 minutes of silence

```sql
SELECT *, sum(is_new) OVER (PARTITION BY user_id ORDER BY at) AS session_no
FROM (
  SELECT *, (at - lag(at) OVER (PARTITION BY user_id ORDER BY at) > INTERVAL '30 minutes')::int AS is_new
  FROM events
) x;
```

### Pareto and ABC Analysis

Cumulative share of revenue

```sql
SELECT product, revenue,
       sum(revenue) OVER (ORDER BY revenue DESC) / sum(revenue) OVER () AS cum_share
FROM product_revenue;
```

### Top N per Group and Latest Row per Group

Rank inside groups, keep the top

```sql
SELECT * FROM (
  SELECT *, row_number() OVER (PARTITION BY category ORDER BY price DESC) AS rn
  FROM products
) x WHERE rn <= 3;

SELECT DISTINCT ON (customer_id) * FROM orders ORDER BY customer_id, ordered_at DESC;
```

## Data Modeling and Warehousing

Shape data for reporting.

### OLTP vs. OLAP

Two jobs, two designs

```sql
-- OLTP: many small writes, normalised, fast lookups
-- OLAP: few big reads, wide tables, aggregations
```

### Star Schema: Facts and Dimensions

One fact table, several dimensions

```sql
SELECT d.year, p.category, sum(f.amount)
FROM fact_sales f
JOIN dim_date d    ON d.date_key = f.date_key
JOIN dim_product p ON p.product_key = f.product_key
GROUP BY d.year, p.category;
```

### Slowly Changing Dimensions

Type 2: keep history with valid dates

```sql
-- columns: valid_from, valid_to, is_current
UPDATE dim_customer SET valid_to = now(), is_current = false
WHERE customer_id = 7 AND is_current;
INSERT INTO dim_customer (...) VALUES (...);
```

### Building a Small Warehouse from the Shop Data

Fill a dimension and a fact from the source tables

```sql
INSERT INTO dim_product (product_id, name, category)
SELECT id, name, category FROM products;
INSERT INTO fact_sales (date_key, product_key, amount)
SELECT ... FROM order_items i JOIN ...;
```

### Denormalisation and When to Break the Rules

Copy data on purpose for speed, and keep it in sync

```sql
-- store a total on the order instead of summing items each time
-- accept duplicates for reads, protect them with triggers or a rebuild job
```

## Administration and Security

Run the server and protect the data.

### psql Essentials

Commands you need

```sql
\l  \c dbname  \dt  \d table  \dn  \du  \df  \dv
\x   -- expanded output on/off
\timing
\i file.sql
\q
```

### Schemas and the Search Path

Folders for tables

```sql
CREATE SCHEMA sales;
CREATE TABLE sales.orders (...);
SET search_path = sales, public;
SHOW search_path;
```

### Users, Roles and GRANT

Give the least access needed

```sql
CREATE ROLE analyst LOGIN PASSWORD '...';
GRANT SELECT ON ALL TABLES IN SCHEMA sales TO analyst;
GRANT USAGE ON SCHEMA sales TO analyst;
REVOKE INSERT ON orders FROM analyst;
```

### Row-Level Security

Each user sees their own rows

```sql
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
CREATE POLICY own_rows ON orders
  USING (owner = current_user);
```

### Backup and Restore with pg_dump

From the command line

```sql
pg_dump -Fc mydb > mydb.dump
pg_restore -d newdb mydb.dump
pg_dump mydb > mydb.sql
psql newdb < mydb.sql
```

### Extensions

Add features

```sql
CREATE EXTENSION IF NOT EXISTS pg_trgm;
\dx
```

## SQL in the Real World

Use SQL from other tools safely.

### Connecting Excel, Power BI and Metabase

What you need to connect

```sql
host, port 5432, database, user, password
-- use a read-only role for reporting tools
```

### SQL with Python and pandas

Read a query into a DataFrame

```sql
import pandas as pd
from sqlalchemy import create_engine
engine = create_engine('postgresql://user:pass@localhost/db')
df = pd.read_sql('SELECT * FROM orders', engine)
```

### Parameterised Queries and SQL Injection

Never build SQL by joining strings with user input

```sql
cur.execute('SELECT * FROM users WHERE email = %s', (email,))   # safe
PREPARE find(text) AS SELECT * FROM users WHERE email = $1;
EXECUTE find('a@b.com');
```

### Moving to MySQL and SQL Server

Common differences

```sql
-- PostgreSQL        MySQL            SQL Server
-- LIMIT 10           LIMIT 10         SELECT TOP 10 ...
-- a || b             CONCAT(a, b)     a + b
-- now()              NOW()            GETDATE()
-- ILIKE              LIKE             LIKE (case-insensitive collation)
-- serial / identity  AUTO_INCREMENT   IDENTITY(1,1)
```

## SQL Interview Preparation

Patterns that come up again and again.

### Interview Questions: Basics and Joins

Customers with no orders; second highest value

```sql
SELECT c.* FROM customers c LEFT JOIN orders o ON o.customer_id = c.id WHERE o.id IS NULL;
SELECT max(price) FROM products WHERE price < (SELECT max(price) FROM products);
```

### Interview Questions: Aggregation and Subqueries

Duplicates; above-average rows

```sql
SELECT email FROM users GROUP BY email HAVING count(*) > 1;
SELECT * FROM products WHERE price > (SELECT avg(price) FROM products);
```

### Interview Questions: Window Functions

Top N per group; running total; month-over-month

```sql
row_number() OVER (PARTITION BY g ORDER BY x DESC)
sum(x) OVER (ORDER BY d)
x - lag(x) OVER (ORDER BY d)
```

### Interview Questions: Design, Performance and Theory

Answers worth knowing

```sql
-- WHERE filters rows, HAVING filters groups
-- UNION removes duplicates, UNION ALL keeps them (faster)
-- an index helps reads and slows writes
-- primary key = unique + not null, one per table
```

### Live Coding and Take-Home Habits

Steps

```sql
-- 1. repeat the question and check the columns wanted
-- 2. look at the tables and a few rows
-- 3. build in small steps (CTEs), check each
-- 4. test edge cases: NULLs, ties, empty groups
```

