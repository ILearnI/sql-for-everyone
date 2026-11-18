-- SQL for Everyone: From Zero to Confident
-- Chapter 14: Data Cleaning and Quality
-- Lesson 14.2: Profiling a Table
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/profiling-a-table/

-- Profile the users: rows, NULLs, distinct emails, date range
SELECT COUNT(*) AS rows,
       COUNT(*) - COUNT(email) AS email_nulls,
       COUNT(DISTINCT email) AS distinct_emails,
       MIN(signup_date) AS first_signup, MAX(signup_date) AS last_signup
FROM users;

-- NULLs in every column of every table, with one catalogue query
SELECT column_name,
       (xpath('/row/c/text()', query_to_xml(format('SELECT COUNT(*) - COUNT(%I) AS c FROM %I', column_name, table_name), false, true, '')))[1]::text::int AS nulls,
       (xpath('/row/c/text()', query_to_xml(format('SELECT COUNT(DISTINCT %I) AS c FROM %I', column_name, table_name), false, true, '')))[1]::text::int AS distinct_values
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'contacts_raw'
ORDER BY ordinal_position;

-- The spellings of country in the raw contacts
SELECT country, COUNT(*) AS contacts FROM contacts_raw GROUP BY country ORDER BY contacts DESC LIMIT 6;

-- Emails with no @, or that need cleaning
SELECT COUNT(*) FILTER (WHERE email NOT LIKE '%@%') AS no_at_sign,
       COUNT(*) FILTER (WHERE email <> lower(trim(email))) AS needs_cleaning
FROM contacts_raw;

-- Payments: NULLs, minimum, maximum, mean and median
SELECT COUNT(*) FILTER (WHERE amount IS NULL) AS null_amounts, MIN(amount), MAX(amount),
       ROUND(AVG(amount), 2) AS average,
       ROUND(percentile_cont(0.5) WITHIN GROUP (ORDER BY amount)::numeric, 2) AS median
FROM payments;

-- Events by type, with and without a title
SELECT event_type, COUNT(*) AS events, COUNT(title_id) AS with_title FROM events GROUP BY event_type ORDER BY events DESC;
