-- SQL for Everyone: From Zero to Confident
-- Chapter 19: Project: Streamly Growth Analysis
-- Lesson 19.2: Part 1: Clean the Data
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/part-1-clean-the-data/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Profile the raw contacts
SELECT (SELECT COUNT(*) FROM contacts_raw) AS contacts, (SELECT COUNT(DISTINCT country) FROM contacts_raw) AS country_spellings,
       (SELECT COUNT(DISTINCT plan) FROM contacts_raw) AS plan_spellings,
       (SELECT COUNT(*) FROM contacts_raw WHERE email IS NOT NULL AND email NOT LIKE '%@%') AS invalid_emails,
       (SELECT COUNT(*) FROM payments WHERE amount IS NULL OR amount > 20.49) AS suspect_payments;

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

-- Check the clean table
SELECT COUNT(*) AS rows, COUNT(DISTINCT country) AS countries, COUNT(DISTINCT plan) AS plans,
       COUNT(email) - COUNT(DISTINCT email) AS duplicate_emails
FROM contacts_final;

-- Compare each amount with the plan price
SELECT p.amount, pl.monthly_price, ROUND(p.amount / pl.monthly_price, 1) AS times_the_price, COUNT(*) AS payments
FROM payments p JOIN subscriptions s ON s.subscription_id = p.subscription_id JOIN plans pl ON pl.plan_id = s.plan_id
WHERE p.amount > 20.49 GROUP BY p.amount, pl.monthly_price ORDER BY p.amount;

-- Fix the payments into payments_clean
CREATE TABLE payments_clean AS
SELECT payment_id, subscription_id, paid_at,
       CASE WHEN amount > 20.49 THEN ROUND(amount / 10, 2) ELSE amount END AS amount, status,
       amount IS NULL AS amount_missing, COALESCE(amount > 20.49, false) AS amount_corrected
FROM payments;

-- How many were corrected or missing?
SELECT COUNT(*) FILTER (WHERE amount_corrected) AS corrected, COUNT(*) FILTER (WHERE amount_missing) AS missing, MAX(amount) AS max_amount
FROM payments_clean;

-- Payments still different from the plan price
SELECT COUNT(*) AS payments_not_equal_to_plan_price
FROM payments_clean pc JOIN subscriptions s ON s.subscription_id = pc.subscription_id JOIN plans p ON p.plan_id = s.plan_id
WHERE pc.amount IS NOT NULL AND pc.amount <> p.monthly_price;

-- Raw revenue against clean revenue
SELECT (SELECT SUM(amount) FROM payments WHERE status = 'paid') AS raw_paid_revenue,
       (SELECT SUM(amount) FROM payments_clean WHERE status = 'paid') AS clean_paid_revenue;
