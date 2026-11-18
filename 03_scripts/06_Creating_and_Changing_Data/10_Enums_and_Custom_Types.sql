-- SQL for Everyone: From Zero to Confident
-- Chapter 6: Creating and Changing Data
-- Lesson 6.10: Enums and Custom Types
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/enums-and-custom-types/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Create the type order_priority
CREATE TYPE order_priority AS ENUM ('normal', 'rush', 'gift');

-- List the allowed values
SELECT enum_range(NULL::order_priority) AS allowed_values;

-- Create the table prio_test
CREATE TABLE prio_test (id integer, priority order_priority DEFAULT 'normal');
INSERT INTO prio_test (id) VALUES (1);
INSERT INTO prio_test VALUES (2, 'rush');
SELECT * FROM prio_test ORDER BY priority;

-- 'urgent' is not in the enum: refused
INSERT INTO prio_test VALUES (3, 'urgent');

-- Enum values compare in their declared order
SELECT 'rush'::order_priority > 'normal'::order_priority AS rush_after_normal;

-- Add a new value to the enum
ALTER TYPE order_priority ADD VALUE 'pickup' AFTER 'gift';

-- Drop the table prio_test
DROP TABLE prio_test;
DROP TYPE order_priority;
