-- SQL for Everyone: From Zero to Confident
-- Chapter 4: Functions and Expressions
-- Lesson 4.3: Dates and Times
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/dates-and-times/

-- Today's date and the current time
SELECT CURRENT_DATE, NOW()::timestamp(0) AS right_now;

-- A timestamp cast to a date
SELECT order_id, order_date, order_date::date AS day FROM orders LIMIT 3;

-- TO_CHAR formats a timestamp as text
SELECT TO_CHAR(order_date, 'YYYY-MM-DD HH24:MI') AS formatted,
       TO_CHAR(order_date, 'Day, DD Mon YYYY') AS long_form
FROM orders LIMIT 3;

-- FM removes the padding in TO_CHAR
SELECT TO_CHAR(DATE '2025-12-25', 'FMDay, FMDD FMMonth YYYY') AS christmas;

-- The time zone of the session
SHOW timezone;

-- The same instant in three time zones
SELECT TIMESTAMPTZ '2025-03-31 12:00+00' AS utc,
       TIMESTAMPTZ '2025-03-31 12:00+00' AT TIME ZONE 'Asia/Tokyo' AS tokyo,
       TIMESTAMPTZ '2025-03-31 12:00+00' AT TIME ZONE 'America/New_York' AS new_york;
