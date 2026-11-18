-- SQL for Everyone: From Zero to Confident
-- Chapter 14: Data Cleaning and Quality
-- Lesson 14.7: Data Cleaning Challenge
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/data-cleaning-challenge/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Profile the raw contacts
SELECT COUNT(*) AS rows,
       COUNT(DISTINCT country) AS countries, COUNT(DISTINCT plan) AS plans,
       COUNT(*) FILTER (WHERE email IS NULL) AS no_email,
       COUNT(*) FILTER (WHERE email NOT LIKE '%@%') AS invalid_email
FROM contacts_raw;

-- Clean them into contacts_final
CREATE TABLE contacts_final AS
WITH std AS (
  SELECT contact_id,
         CASE WHEN full_name LIKE '%,%' THEN initcap(trim(split_part(full_name, ',', 2))) || ' ' || initcap(trim(split_part(full_name, ',', 1)))
              ELSE initcap(regexp_replace(trim(full_name), '\s+', ' ', 'g')) END AS full_name,
         CASE WHEN email LIKE '%@%' THEN lower(trim(email)) END AS email,
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
  FROM contacts_raw
), ranked AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY email ORDER BY signup_date DESC NULLS LAST, contact_id DESC) AS rn
  FROM std
)
SELECT contact_id, full_name, email, country, plan, signup_date
FROM ranked
WHERE rn = 1 OR email IS NULL;

-- Profile the clean table
SELECT COUNT(*) AS rows, COUNT(DISTINCT country) AS countries, COUNT(DISTINCT plan) AS plans,
       COUNT(email) - COUNT(DISTINCT email) AS duplicate_emails
FROM contacts_final;

-- A quality report: one line for each rule
SELECT 'country not mapped' AS rule, COUNT(*) AS violations FROM contacts_final WHERE country IS NULL
UNION ALL SELECT 'plan not mapped', COUNT(*) FROM contacts_final WHERE plan IS NULL
UNION ALL SELECT 'email not lower case', COUNT(*) FROM contacts_final WHERE email <> lower(email)
UNION ALL SELECT 'signup date in the future', COUNT(*) FROM contacts_final WHERE signup_date > DATE '2026-02-01'
UNION ALL SELECT 'name with extra spaces', COUNT(*) FROM contacts_final WHERE full_name <> trim(regexp_replace(full_name, '\s+', ' ', 'g'));

-- Contacts by plan
SELECT plan, COUNT(*) AS contacts FROM contacts_final GROUP BY plan ORDER BY contacts DESC;
