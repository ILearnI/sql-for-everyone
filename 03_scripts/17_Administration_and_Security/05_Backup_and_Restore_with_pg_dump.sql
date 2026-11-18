-- SQL for Everyone: From Zero to Confident
-- Chapter 17: Administration and Security
-- Lesson 17.5: Backup and Restore with pg_dump
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/backup-and-restore-with-pg-dump/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- pg_dump writes a backup file (a shell command)
\! mkdir -p /tmp/backup && pg_dump -U postgres -d brewhouse -t product_stock -Fc -f /tmp/backup/product_stock.dump && ls -l /tmp/backup

-- Count the rows before
SELECT COUNT(*) AS rows_before FROM product_stock;

-- List what the backup contains (a shell command)
\! pg_restore -l /tmp/backup/product_stock.dump | grep -v '^;'

-- Drop the table: the accident
DROP TABLE product_stock;

-- The table is gone
SELECT to_regclass('product_stock') AS table_exists;

-- pg_restore brings it back (a shell command)
\! pg_restore -U postgres -d brewhouse /tmp/backup/product_stock.dump

-- Count the rows after the restore
SELECT COUNT(*) AS rows_after_restore FROM product_stock;

-- The structure is back too
\d product_stock

-- A plain-text dump with INSERT statements (a shell command)
\! pg_dump -U postgres -d brewhouse -t price_bands --column-inserts | grep INSERT | head -2
