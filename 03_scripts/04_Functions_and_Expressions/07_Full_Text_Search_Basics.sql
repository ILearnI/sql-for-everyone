-- SQL for Everyone: From Zero to Confident
-- Chapter 4: Functions and Expressions
-- Lesson 4.7: Full-Text Search Basics
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/full-text-search-basics/

-- to_tsvector breaks text into searchable words
SELECT to_tsvector('english', 'Smooth dark roast with chocolate notes') AS tsv;

-- Stemming: running becomes run
SELECT to_tsvector('english', 'The running dogs were running') AS stemmed;

-- @@ tests a document against a query
SELECT to_tsvector('english', 'Smooth dark roast with chocolate notes')
       @@ to_tsquery('english', 'chocolate & roast') AS is_match;

-- Search the product names
SELECT name FROM products
WHERE to_tsvector('english', name) @@ plainto_tsquery('english', 'cold brew');

-- Rank the matches
SELECT name, ts_rank(to_tsvector('english', name), plainto_tsquery('english', 'coffee')) AS rank
FROM products
WHERE to_tsvector('english', name) @@ plainto_tsquery('english', 'coffee')
ORDER BY rank DESC;

-- Prefix search with :*
SELECT name FROM products
WHERE to_tsvector('english', name) @@ to_tsquery('english', 'cold:* & brew:*');
