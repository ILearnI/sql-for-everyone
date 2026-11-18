-- SQL for Everyone: From Zero to Confident
-- Chapter 17: Administration and Security
-- Lesson 17.6: Extensions
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/extensions/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Which extensions are available?
SELECT name, default_version, left(comment, 55) AS what
FROM pg_available_extensions
WHERE name IN ('pg_trgm', 'uuid-ossp', 'pgcrypto', 'citext', 'unaccent')
ORDER BY name;

-- Needs an extension: not available in the browser playground, run it in your own PostgreSQL
CREATE EXTENSION pg_trgm;
CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION pgcrypto;

-- List the installed extensions (\dx)
\dx

-- Needs an extension: not available in the browser playground, run it in your own PostgreSQL
SELECT similarity('Espresso Machine', 'Expresso Machin') AS similarity;

-- Needs an extension: not available in the browser playground, run it in your own PostgreSQL
SELECT name FROM products WHERE name % 'Expresso' ORDER BY similarity(name, 'Expresso') DESC LIMIT 3;

-- Needs an extension: not available in the browser playground, run it in your own PostgreSQL
SELECT length(uuid_generate_v4()::text) AS uuid_length, length(gen_random_uuid()::text) AS builtin_uuid_length;

-- Needs an extension: not available in the browser playground, run it in your own PostgreSQL
WITH h AS (SELECT crypt('s3cret', gen_salt('bf')) AS hash)
SELECT crypt('s3cret', hash) = hash AS right_password, crypt('wrong', hash) = hash AS wrong_password, length(hash) AS hash_length
FROM h;

-- Needs an extension: not available in the browser playground, run it in your own PostgreSQL
SELECT encode(digest('hello', 'sha256'), 'hex') AS sha256_of_hello;

-- An extension that does not exist: this fails on purpose
CREATE EXTENSION nonexistent_ext;
