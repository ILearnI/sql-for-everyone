-- SQL for Everyone: From Zero to Confident
-- Chapter 17: Administration and Security
-- Lesson 17.1: psql Essentials
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/psql-essentials/

-- Where am I connected? (\conninfo)
\conninfo

-- List the databases (\l)
\l

-- Describe a table (\d)
\d products

-- List the tables with their sizes, by pattern (\dt+)
\dt+ order*

-- Run a file of SQL (\i): a psql command
\i /tmp/top3.sql

-- Who am I, and which version?
SELECT current_user, current_database() AS database, split_part(version(), ' ', 2) AS postgres_version;
