-- SQL for Everyone: From Zero to Confident
-- Chapter 9: Window Functions
-- Lesson 9.3: Ranking: ROW_NUMBER, RANK and DENSE_RANK
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/ranking-row-number-rank-and-dense-rank/

-- Window function row_number, rank, dense_rank
SELECT name, price,
       ROW_NUMBER() OVER (ORDER BY price DESC) AS rn,
       RANK()       OVER (ORDER BY price DESC) AS rk,
       DENSE_RANK() OVER (ORDER BY price DESC) AS dr
FROM products
WHERE category = 'Pantry'
ORDER BY price DESC;

-- Window function rank
SELECT category, name, price, rk
FROM (
  SELECT category, name, price,
         RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rk
  FROM products
) t
WHERE rk <= 3
ORDER BY category, rk;

-- Window function row_number, rank, dense_rank, UNION ALL of two queries
SELECT 'ROW_NUMBER' AS fn, COUNT(*) AS rows_kept FROM (SELECT ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) AS n FROM products) t WHERE n <= 3
UNION ALL
SELECT 'RANK', COUNT(*) FROM (SELECT RANK() OVER (PARTITION BY category ORDER BY price DESC) AS n FROM products) t WHERE n <= 3
UNION ALL
SELECT 'DENSE_RANK', COUNT(*) FROM (SELECT DENSE_RANK() OVER (PARTITION BY category ORDER BY price DESC) AS n FROM products) t WHERE n <= 3;
