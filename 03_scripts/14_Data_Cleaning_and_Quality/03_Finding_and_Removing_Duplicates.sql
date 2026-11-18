-- SQL for Everyone: From Zero to Confident
-- Chapter 14: Data Cleaning and Quality
-- Lesson 14.3: Finding and Removing Duplicates
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/finding-and-removing-duplicates/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Exact duplicate rows
SELECT COUNT(*) AS exact_duplicate_groups, SUM(c - 1) AS extra_rows
FROM (SELECT COUNT(*) AS c FROM contacts_raw
      GROUP BY full_name, email, phone, country, signup_date, plan, notes HAVING COUNT(*) > 1) t;

-- Rows with an email against different people
SELECT COUNT(*) AS rows_with_email, COUNT(DISTINCT lower(trim(email))) AS different_people
FROM contacts_raw WHERE email LIKE '%@%';

-- One person, several rows
SELECT contact_id, full_name, email, signup_date
FROM contacts_raw
WHERE lower(trim(email)) = 'aiko.wright94@gmail.com'
ORDER BY contact_id;

-- Number the rows of that person, newest first
SELECT contact_id, full_name,
       ROW_NUMBER() OVER (PARTITION BY lower(trim(email)) ORDER BY contact_id DESC) AS rn
FROM contacts_raw
WHERE lower(trim(email)) = 'aiko.wright94@gmail.com'
ORDER BY rn;

-- Copy the table to work on
CREATE TABLE contacts_dedup AS SELECT * FROM contacts_raw;

-- Delete all but the newest row of each person
WITH ranked AS (
  SELECT contact_id,
         ROW_NUMBER() OVER (PARTITION BY lower(trim(email)) ORDER BY contact_id DESC) AS rn
  FROM contacts_dedup WHERE email LIKE '%@%'
)
DELETE FROM contacts_dedup d USING ranked r
WHERE d.contact_id = r.contact_id AND r.rn > 1;

-- Check: no duplicates left
SELECT COUNT(*) AS rows_left,
       COUNT(*) FILTER (WHERE email LIKE '%@%') - COUNT(DISTINCT lower(trim(email))) AS duplicates_left
FROM contacts_dedup;
