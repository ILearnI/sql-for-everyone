-- SQL for Everyone: From Zero to Confident
-- Chapter 4: Functions and Expressions
-- Lesson 4.5: JSON and JSONB
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/json-and-jsonb/

-- A JSONB column holds a document
SELECT name, attributes FROM products WHERE attributes IS NOT NULL LIMIT 3;

-- -> returns JSON, ->> returns text
SELECT name, attributes->'roast' AS as_json, attributes->>'roast' AS as_text
FROM products WHERE attributes ? 'roast' LIMIT 3;

-- Filter on a JSON field: dark-roast products
SELECT name, attributes->>'origin' AS origin FROM products WHERE attributes->>'roast' = 'dark';

-- @> tests whether the document contains a value
SELECT name FROM products WHERE attributes @> '{"organic": true}' LIMIT 5;

-- jsonb_each turns a document into key and value rows
SELECT key, value FROM products, jsonb_each(attributes) WHERE name = 'Espresso Beans 1kg';

-- Cast a JSON field to boolean
SELECT name, (attributes->>'organic')::boolean AS organic FROM products WHERE attributes ? 'organic' LIMIT 4;
