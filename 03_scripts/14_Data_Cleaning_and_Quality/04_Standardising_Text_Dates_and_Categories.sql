-- SQL for Everyone: From Zero to Confident
-- Chapter 14: Data Cleaning and Quality
-- Lesson 14.4: Standardising Text, Dates and Categories
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/standardising-text-dates-and-categories/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Spellings of country before and after normalising
SELECT COUNT(DISTINCT country) AS spellings,
       COUNT(DISTINCT lower(trim(replace(country, '.', '')))) AS after_normalising
FROM contacts_raw;

-- The naive minimum date is wrong: the formats are mixed
SELECT MIN(to_date(signup_date, 'DD/MM/YYYY')) AS naive_minimum
FROM contacts_raw WHERE signup_date LIKE '%/%/%';

-- Build the clean table
CREATE TABLE contacts_clean AS
SELECT contact_id,
       CASE WHEN full_name LIKE '%,%'
            THEN initcap(trim(split_part(full_name, ',', 2))) || ' ' || initcap(trim(split_part(full_name, ',', 1)))
            ELSE initcap(regexp_replace(trim(full_name), '\s+', ' ', 'g')) END AS full_name,
       lower(trim(email)) AS email,
       CASE lower(trim(replace(country, '.', '')))
         WHEN 'usa' THEN 'USA' WHEN 'us' THEN 'USA' WHEN 'united states' THEN 'USA' WHEN 'united states of america' THEN 'USA'
         WHEN 'uk' THEN 'UK' WHEN 'gb' THEN 'UK' WHEN 'great britain' THEN 'UK' WHEN 'united kingdom' THEN 'UK'
         WHEN 'canada' THEN 'Canada' WHEN 'ca' THEN 'Canada' WHEN 'germany' THEN 'Germany' WHEN 'de' THEN 'Germany' WHEN 'deutschland' THEN 'Germany'
         WHEN 'france' THEN 'France' WHEN 'fr' THEN 'France' WHEN 'spain' THEN 'Spain' WHEN 'es' THEN 'Spain' WHEN 'espana' THEN 'Spain'
         WHEN 'india' THEN 'India' WHEN 'in' THEN 'India' WHEN 'brazil' THEN 'Brazil' WHEN 'br' THEN 'Brazil' WHEN 'brasil' THEN 'Brazil'
         WHEN 'australia' THEN 'Australia' WHEN 'au' THEN 'Australia' WHEN 'mexico' THEN 'Mexico' WHEN 'méxico' THEN 'Mexico' WHEN 'mx' THEN 'Mexico' END AS country,
       CASE WHEN lower(trim(plan)) IN ('basic', 'basic plan', 'bsc') THEN 'Basic'
            WHEN lower(trim(plan)) IN ('standard', 'standard plan', 'std') THEN 'Standard'
            WHEN lower(trim(plan)) IN ('premium', 'premium plan', 'prem') THEN 'Premium'
            WHEN lower(trim(plan)) IN ('free trial', 'trial') THEN 'Free Trial' END AS plan,
       CASE WHEN signup_date ~ '^\d{4}-\d{2}-\d{2}$' THEN to_date(signup_date, 'YYYY-MM-DD')
            WHEN signup_date ~ '^\d{2}/\d{2}/\d{4}$' AND signup_date <> '00/00/0000' THEN to_date(signup_date, 'DD/MM/YYYY')
            WHEN signup_date ~ '^\d{2}-\d{2}-\d{4}$' THEN to_date(signup_date, 'MM-DD-YYYY')
            WHEN signup_date ~ '^[A-Z][a-z]{2} \d{2}, \d{4}$' THEN to_date(signup_date, 'Mon DD, YYYY')
            WHEN signup_date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN to_date(signup_date, 'DD.MM.YYYY') END AS signup_date
FROM contacts_raw;

-- Check the clean table
SELECT COUNT(DISTINCT country) AS countries, COUNT(DISTINCT plan) AS plans,
       COUNT(*) FILTER (WHERE country IS NULL) AS unmapped_countries,
       COUNT(*) FILTER (WHERE signup_date IS NULL) AS unparsed_dates
FROM contacts_clean;

-- The date range after cleaning
SELECT MIN(signup_date) AS first_signup, MAX(signup_date) AS last_signup FROM contacts_clean;

-- Look at three cleaned contacts
SELECT contact_id, full_name, country, plan, signup_date
FROM contacts_clean
WHERE contact_id IN (1, 2, 3)
ORDER BY contact_id;
