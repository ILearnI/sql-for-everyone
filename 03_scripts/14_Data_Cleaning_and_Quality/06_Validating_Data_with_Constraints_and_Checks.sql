-- SQL for Everyone: From Zero to Confident
-- Chapter 14: Data Cleaning and Quality
-- Lesson 14.6: Validating Data with Constraints and Checks
-- Database: streamly (setup: 00_setup/streamly-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/validating-data-with-constraints-and-checks/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- A CHECK added as NOT VALID: existing rows are not checked
ALTER TABLE payments ADD CONSTRAINT amount_in_range
  CHECK (amount IS NULL OR (amount > 0 AND amount <= 20.49)) NOT VALID;

-- A bad new row is refused
INSERT INTO payments (payment_id, subscription_id, paid_at, amount, status)
VALUES (999999, 1, now(), -5, 'paid');

-- VALIDATE fails: existing rows break the rule
ALTER TABLE payments VALIDATE CONSTRAINT amount_in_range;

-- Fix the data, then VALIDATE
UPDATE payments SET amount = amount / 10 WHERE amount > 20.49;
ALTER TABLE payments VALIDATE CONSTRAINT amount_in_range;

-- A status CHECK refuses an unknown status
ALTER TABLE payments ADD CONSTRAINT status_known CHECK (status IN ('paid', 'failed', 'refunded'));
INSERT INTO payments (payment_id, subscription_id, paid_at, amount, status)
VALUES (999999, 1, now(), 12.99, 'maybe');

-- A unique constraint on email
ALTER TABLE users ADD CONSTRAINT users_email_unique UNIQUE (email);

-- A quality report: every rule and its violations in one query
SELECT 'email has no @ (contacts_raw)' AS rule, COUNT(*) AS violations FROM contacts_raw WHERE email IS NOT NULL AND email NOT LIKE '%@%'
UNION ALL SELECT 'payment amount missing or out of range', COUNT(*) FROM payments WHERE amount IS NULL OR amount <= 0 OR amount > 20.49
UNION ALL SELECT 'subscription ends before it starts', COUNT(*) FROM subscriptions WHERE end_date < start_date
UNION ALL SELECT 'subscription starts before signup', COUNT(*) FROM subscriptions s JOIN users u ON u.user_id = s.user_id WHERE s.start_date < u.signup_date
UNION ALL SELECT 'ticket closed before opened', COUNT(*) FROM support_tickets WHERE closed_at < opened_at;
