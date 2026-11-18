-- SQL for Everyone: From Zero to Confident
-- Chapter 18: SQL in the Real World
-- Lesson 18.3: Parameterised Queries and SQL Injection
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/parameterised-queries-and-sql-injection/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- An unsafe function: SQL built by joining text, and a safe one
CREATE FUNCTION find_unsafe(p_email text) RETURNS bigint LANGUAGE plpgsql AS $$
DECLARE n bigint;
BEGIN
  EXECUTE 'SELECT COUNT(*) FROM customers WHERE email = ''' || p_email || '''' INTO n;
  RETURN n;
END $$;
CREATE FUNCTION find_safe(p_email text) RETURNS bigint LANGUAGE plpgsql AS $$
DECLARE n bigint;
BEGIN
  EXECUTE 'SELECT COUNT(*) FROM customers WHERE email = $1' INTO n USING p_email;
  RETURN n;
END $$;

-- A real email to try
SELECT email FROM customers WHERE email IS NOT NULL ORDER BY customer_id LIMIT 1;

-- Both functions with a normal email
SELECT find_unsafe('ava.walker@gmail.com') AS unsafe, find_safe('ava.walker@gmail.com') AS safe;

-- The query that an attacker's text builds
SELECT 'SELECT COUNT(*) FROM customers WHERE email = ''' || $$x' OR '1'='1$$ || '''' AS the_query_that_runs;

-- The unsafe function returns every customer, the safe one none
SELECT find_unsafe($$x' OR '1'='1$$) AS unsafe, find_safe($$x' OR '1'='1$$) AS safe;

-- format with %L quotes the text safely
SELECT format('SELECT * FROM customers WHERE email = %L', $$x' OR '1'='1$$) AS quoted_safely;

-- A prepared statement: the value can never become SQL
PREPARE by_email(text) AS SELECT COUNT(*) AS matches FROM customers WHERE email = $1;
EXECUTE by_email($$x' OR '1'='1$$);
