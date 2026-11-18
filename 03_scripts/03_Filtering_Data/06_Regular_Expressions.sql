-- SQL for Everyone: From Zero to Confident
-- Chapter 3: Filtering Data
-- Lesson 3.6: Regular Expressions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/regular-expressions/

-- ~ finds text matching a pattern: names containing Beans
SELECT name FROM products WHERE name ~ 'Beans';

-- ^ anchors the pattern to the start
SELECT name FROM products WHERE name ~ '^Cold';

-- Anchors and [0-9]+: a size code made of digits
SELECT name FROM products WHERE name ~ '^Cold Brew [0-9]+$';

-- Alternatives with |: names ending in Tin or Jar
SELECT name FROM products WHERE name ~ '(Tin|Jar)$';

-- !~ finds names that do not match: no digits
SELECT name FROM products WHERE name !~ '[0-9]' LIMIT 6;

-- {3} means exactly three: three-digit size codes
SELECT name FROM products WHERE name ~ '^Cold Brew [0-9]{3}$';
