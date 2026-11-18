# SQL for Everyone: From Zero to Confident: course outline

## Introduction

- **Course Introduction**: Welcome, who the course is for (anyone who works with data: marketing, sales, operations, students, career changers, curious developers), what they will be able to do at the end, and how the course works: short lessons, queries run for real, challenges after every chapter, and two projects that tie it together.

## Chapter 1: Getting Started

- **1.1 What Is a Database?**: Tables, rows and columns, why spreadsheets stop working, and what a relational database adds.
- **1.2 What Is SQL?**: SQL as the language for asking questions of data; SQL vs. PostgreSQL vs. MySQL vs. SQL Server (95% of what you learn transfers); the four families of statements (query, define, change, control).
- **1.3 Setting Up Your Database (Optional)**: Optional lesson: the browser playground is enough to follow the whole course. If you also want a database on your own computer, a one-command Docker setup (Mac, Windows and Linux) starts it, loads the Brewhouse data, installs the course psql settings and opens psql; a normal PostgreSQL install works too. Includes a quick tour of the playground and your first statements.
- **1.4 Meet the Shop Dataset**: The Brewhouse online coffee shop: customers, products, orders, order items and employees. Load it with one script, then explore the tables.
- **1.5 Your First Queries**: SELECT * FROM, reading a result table, and the rhythm used for the rest of the course: read the question, write the query, run it, check the result.

## Chapter 2: Querying Data

- **2.1 SELECT and FROM**: Choosing columns, the order of columns, and why SELECT * is only for exploring.
- **2.2 Aliases and Expressions**: AS for column and table aliases, arithmetic in the SELECT list, and string concatenation.
- **2.3 DISTINCT**: Removing duplicates, DISTINCT on one and several columns, and counting distinct values.
- **2.4 ORDER BY**: Ascending and descending, sorting by several columns, sorting by an expression or alias, and where NULLs go.
- **2.5 LIMIT and OFFSET**: Top-N queries, paging through results, and the one-line way to see the five biggest orders.
- **2.6 Writing Readable SQL and Reading Error Messages**: Formatting and comment habits, the style used in the course, and how to read the most common PostgreSQL errors (missing column, ambiguous column, syntax error near...) and fix them.
- **2.7 How a Query Runs**: The logical order SQL evaluates a query (FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY, LIMIT). Animated step by step. This explains many errors students will meet later.

## Chapter 3: Filtering Data

- **3.1 WHERE and Comparison Operators**: =, <>, <, >, <=, >=, comparing numbers, text and dates.
- **3.2 AND, OR and NOT**: Combining conditions, precedence, and parentheses.
- **3.3 IN and BETWEEN**: Lists of values, ranges, and BETWEEN with dates (and the end-of-day trap).
- **3.4 LIKE and ILIKE**: Pattern matching with % and _, case-insensitive matching, and escaping wildcards.
- **3.5 NULL and IS NULL**: What NULL really means, why = NULL never works, IS NULL / IS NOT NULL, and three-valued logic.
- **3.6 Regular Expressions**: POSIX pattern matching with ~, ~* and !~, character classes, anchors, and when a regular expression beats LIKE.
- **3.7 Filtering Challenge**: Six business questions on the shop data, solved live with hints and a worked solution.

## Chapter 4: Functions and Expressions

- **4.1 String Functions**: UPPER, LOWER, LENGTH, TRIM, SUBSTRING, REPLACE, CONCAT, splitting and cleaning messy text.
- **4.2 Number Functions**: ROUND, CEIL, FLOOR, ABS, MOD, integer division, and why money columns use NUMERIC.
- **4.3 Dates and Times**: DATE, TIMESTAMP, current date and time, formatting with TO_CHAR, and time zones in one honest lesson.
- **4.4 Date Arithmetic and EXTRACT**: Intervals, differences between dates, EXTRACT and DATE_TRUNC for months, weeks and years.
- **4.5 JSON and JSONB**: Storing JSON, the -> and ->> operators, filtering on JSON fields, and turning JSON into columns and rows.
- **4.6 Arrays and generate_series**: Array columns, ANY and unnest, and generating number and date series for test data and calendars.
- **4.7 Full-Text Search Basics**: tsvector, tsquery, ranking results, and when LIKE is not enough.
- **4.8 CASE Expressions**: Turning values into categories (order size, customer tier), CASE in SELECT, ORDER BY and aggregates.
- **4.9 COALESCE, NULLIF and CAST**: Handling missing values, avoiding divide-by-zero, and converting between types.

## Chapter 5: Aggregating Data

- **5.1 COUNT, SUM, AVG, MIN and MAX**: Summarising a whole table, COUNT(*) vs. COUNT(column), and how aggregates treat NULLs.
- **5.2 GROUP BY**: One result row per group.
- **5.3 Grouping by Several Columns**: Multi-column groups, grouping by expressions (month, year), and the rule that every selected column must be grouped or aggregated.
- **5.4 HAVING**: Filtering groups, WHERE vs. HAVING, and where each fits in the order of execution.
- **5.5 ROLLUP, CUBE and Grouping Sets**: Subtotals, cross-totals and grand totals in one query, and the GROUPING function.
- **5.6 FILTER and Conditional Aggregation**: Several conditional totals in one query with FILTER and CASE, for example paid vs. refunded revenue side by side.
- **5.7 Pivoting Data**: Turning rows into columns with conditional aggregation and crosstab, and unpivoting back.
- **5.8 string_agg, array_agg and DISTINCT ON**: Collecting values into a list, and keeping one row per group the easy way.
- **5.9 Statistics in SQL**: Percentiles with percentile_cont, median, standard deviation, variance and correlation.
- **5.10 Aggregation Challenge**: Revenue, order counts and averages by month, product category and city, with a worked solution.

## Chapter 6: Creating and Changing Data

- **6.1 Data Types**: INTEGER, NUMERIC, TEXT, VARCHAR, BOOLEAN, DATE, TIMESTAMP and when to use each.
- **6.2 CREATE TABLE**: Defining columns, naming conventions, and creating the practice tables.
- **6.3 Primary and Foreign Keys**: Identifying rows, linking tables, and what a foreign key stops you from doing. Animated.
- **6.4 Constraints**: NOT NULL, UNIQUE, DEFAULT and CHECK, and how a database protects itself from bad data.
- **6.5 INSERT**: Single and multi-row inserts, inserting from a query, and letting the database generate ids.
- **6.6 UPDATE and DELETE Safely**: Changing and removing rows, always previewing with SELECT first, and using a transaction as a safety net.
- **6.7 UPSERT and RETURNING**: INSERT ... ON CONFLICT, updating if the row exists, and getting the changed rows back with RETURNING.
- **6.8 MERGE**: The standard MERGE statement (PostgreSQL 15+), and how it compares with UPSERT.
- **6.9 Identity Columns, Sequences and Generated Columns**: Auto-numbering the modern way, sequences, and columns calculated by the database.
- **6.10 Enums and Custom Types**: Limiting a column to a fixed list of values, and when a lookup table is better.
- **6.11 ALTER TABLE and DROP**: Adding, renaming and changing columns, dropping tables, and what cannot be undone.

## Chapter 7: Joining Tables

- **7.1 Why Joins?**: Why data is split across tables, one-to-many relationships, and what a join does. Animated.
- **7.2 INNER JOIN**: Matching rows from two tables, the ON clause, and table aliases.
- **7.3 LEFT JOIN**: Keeping every row from the left table, finding customers with no orders, and the INNER vs. LEFT animation.
- **7.4 RIGHT and FULL JOIN**: When to use them, and why most people just flip a LEFT JOIN.
- **7.5 CROSS and Self Joins**: All combinations, and joining a table to itself (employees and their managers).
- **7.6 Joining Three or More Tables**: Chaining customers, orders, order items and products, and many-to-many through a link table.
- **7.7 UPDATE FROM, DELETE USING and TRUNCATE**: Changing or removing rows based on another table, and emptying a table quickly.
- **7.8 UNION, INTERSECT and EXCEPT**: Stacking and comparing results, UNION vs. UNION ALL, and when to use a set operator instead of a join.
- **7.9 USING, NATURAL and Non-Equi Joins**: Shorter join syntax, why NATURAL is risky, and joining on ranges (price bands, date ranges).
- **7.10 Anti-Joins and Semi-Joins**: Finding rows with no match and rows with at least one match, three ways (LEFT JOIN, NOT EXISTS, NOT IN), and which is safest.
- **7.11 LATERAL Joins**: Running a subquery for each row, for example the latest three orders of every customer.
- **7.12 Join Fan-Out: Why Totals Double**: The most common real-world join bug: one-to-many joins multiplying rows and inflating sums, and how to spot and fix it. Animated.
- **7.13 Joins Challenge**: Seven questions that need two to four tables, with a worked solution.

## Chapter 8: Subqueries and CTEs

- **8.1 Subqueries in WHERE**: IN with a subquery, comparing to a single value, and when a join is clearer.
- **8.2 Subqueries in FROM and SELECT**: Derived tables and scalar subqueries.
- **8.3 EXISTS and NOT EXISTS**: Checking for related rows, and NOT EXISTS vs. NOT IN with NULLs.
- **8.4 Common Table Expressions**: WITH ... AS, naming a step, and turning a nested query into a readable one. Animated.
- **8.5 Several CTEs and Recursive CTEs**: Chaining CTEs, and walking an org chart with a recursive CTE.
- **8.6 Correlated Subqueries**: Subqueries that refer to the outer row, when they are slow, and how to rewrite them as joins or window functions.
- **8.7 Subqueries and CTEs Challenge**: Customers above average spend, top product per category, and more.

## Chapter 9: Window Functions

- **9.1 What Is a Window Function?**: OVER(), why a window function is not a GROUP BY, and the aggregate-without-collapsing idea. Animated.
- **9.2 PARTITION BY and ORDER BY**: Splitting rows into windows and ordering inside them.
- **9.3 Ranking: ROW_NUMBER, RANK and DENSE_RANK**: Top N per group, ties, and the differences between the three functions.
- **9.4 Running Totals and Frames**: SUM() OVER with ORDER BY, moving averages, and ROWS BETWEEN.
- **9.5 LAG and LEAD**: Comparing a row to the previous and next ones, and month-over-month change.
- **9.6 NTILE, FIRST_VALUE and Percentiles**: Buckets, first and last in a group, and a first look at percentiles.
- **9.7 Named Windows and Distribution Functions**: The WINDOW clause, PERCENT_RANK, CUME_DIST and NTH_VALUE.
- **9.8 Frame Types: ROWS, RANGE and GROUPS**: How the frame is really defined, the default-frame trap with ORDER BY, and EXCLUDE.
- **9.9 Window Functions Challenge**: Ranking customers, running revenue and month-over-month growth, with a worked solution.

## Chapter 10: Views and Reusable SQL

- **10.1 Views**: Saving a query as a virtual table, updating a view, and when views help teams.
- **10.2 Materialized Views**: Storing the result for speed, refreshing it, and the trade-offs.
- **10.3 Temporary Tables and CREATE TABLE AS**: Saving intermediate results and building a summary table.
- **10.4 SQL Functions**: Writing a small reusable SQL function with parameters, and when a view is simpler.
- **10.5 Stored Procedures and PL/pgSQL**: Variables, IF and loops in PL/pgSQL, procedures that run several statements, and error handling.
- **10.6 Triggers**: Running code automatically on INSERT, UPDATE or DELETE: an audit log and a last-updated timestamp. Animated.
- **10.7 Reusable SQL Challenge**: Build a view, a function and an audit trigger for the shop data.

## Chapter 11: Speed and Safety

- **11.1 Indexes**: What an index is, how a lookup changes from scanning every row to jumping straight to it, creating one, and when not to. Animated.
- **11.2 Reading a Query Plan with EXPLAIN**: Seq Scan vs. Index Scan, reading cost and rows, and fixing a slow query.
- **11.3 Transactions**: BEGIN, COMMIT and ROLLBACK, the all-or-nothing idea (a payment transfer), and a short look at what ACID means. Animated.
- **11.4 Index Types: Composite, Partial, Covering and GIN**: Column order in composite indexes, partial and expression indexes, covering indexes, and GIN for JSON and text search.
- **11.5 Locks, Isolation Levels and MVCC**: How PostgreSQL lets many people read and write at once, the isolation levels, row locks, and how a deadlock happens. Animated.
- **11.6 Maintenance: VACUUM, ANALYZE and Statistics**: Why tables bloat, what autovacuum does, and how stale statistics produce bad plans.
- **11.7 Partitioning Basics**: Splitting a large table by date, partition pruning, and when it is worth it.
- **11.8 Writing Faster Queries**: Ten habits that avoid slow queries: select only what you need, filter early, avoid functions on indexed columns, and more.

## Chapter 12: Working with Real Data

- **12.1 Importing and Exporting CSV**: Loading a CSV file into a table and exporting a result.
- **12.2 Designing a Schema**: From a business problem to tables: entities, relationships and an ER diagram, drawn live.
- **12.3 Normalisation in Plain English**: Why repeating data causes bugs, first to third normal form with a messy-spreadsheet example.
- **12.4 Using AI to Write and Debug SQL**: Prompts that work, giving the model your schema, checking its answer, and a safe habit for running generated SQL.

## Chapter 13: Project: Brewhouse Sales Analysis

- **13.1 Project Brief**: The business asks: how is the shop doing, who are the best customers, and what should we stock? Dataset, deliverables and how to work through the project.
- **13.2 Part 1: Revenue Over Time**: Monthly revenue, growth, best and worst months, and a running total.
- **13.3 Part 2: Customers**: New vs. returning customers, top spenders, customers who went quiet, and a simple customer tiering with CASE.
- **13.4 Part 3: Products**: Best sellers by category, products that sell together, and a ranking per category with window functions.
- **13.5 Part 4: Turn It into a Report**: Package the answers as views and one summary table that a colleague could use.
- **13.6 Project Solution and Next Steps**: Reviewing the solution, common mistakes, and where to go next (Part 2 of the course: cleaning, analytics patterns, modelling and a second project).

## Chapter 14: Data Cleaning and Quality

- **14.1 Meet the Streamly Dataset**: The second dataset: Streamly, a video-streaming subscription service with users, plans, subscriptions, payments, viewing events and support tickets, plus a deliberately messy contacts file. Load it with one script.
- **14.2 Profiling a Table**: Row counts, NULL counts, distinct values, min and max, and a reusable profiling query for any new table.
- **14.3 Finding and Removing Duplicates**: Exact and near duplicates, finding them with GROUP BY and ROW_NUMBER, and deleting them safely. Animated.
- **14.4 Standardising Text, Dates and Categories**: Trimming, case, inconsistent spellings, mixed date formats, and mapping messy categories to clean ones.
- **14.5 Missing Values and Outliers**: Deciding what to do with NULLs, spotting outliers with percentiles and the IQR rule, and flagging instead of deleting.
- **14.6 Validating Data with Constraints and Checks**: Turning cleaning rules into CHECK constraints and a data-quality query that runs after every load.
- **14.7 Data Cleaning Challenge**: Clean the messy contacts file end to end, with a worked solution.

## Chapter 15: Analytics Patterns

- **15.1 Calendar Tables and Filling Gaps**: Generating a date spine so months with no sales still show up as zero.
- **15.2 Year-over-Year and Period Comparisons**: Same month last year, rolling 7 and 28 days, week-over-week, and avoiding partial-period traps.
- **15.3 Cohort Retention**: Group users by signup month and see how many are still active after 1, 2, 3 months. Animated retention table.
- **15.4 Funnels and Conversion**: Visit, signup, trial, paid: counting each step, drop-off between steps, and conversion by channel. Animated.
- **15.5 RFM Customer Segmentation**: Recency, frequency and monetary value with NTILE, and naming the segments (champions, at risk, lost).
- **15.6 Gaps and Islands**: Finding streaks and consecutive runs (login streaks, unbroken subscriptions) with a ROW_NUMBER trick. Animated.
- **15.7 Sessionisation**: Grouping raw viewing events into sessions with a 30-minute inactivity rule, using LAG and a running sum.
- **15.8 Pareto and ABC Analysis**: Which 20% of customers or titles make 80% of revenue, with cumulative percentages.
- **15.9 Top N per Group and Latest Row per Group**: Three ways to get each customer's latest order or each category's top three, compared.
- **15.10 Analytics Patterns Challenge**: Four business questions on Streamly that combine the patterns above, with a worked solution.

## Chapter 16: Data Modeling and Warehousing

- **16.1 OLTP vs. OLAP**: Why the database that runs the app is not the one you analyse in, row vs. column storage, and where PostgreSQL fits. Animated.
- **16.2 Star Schema: Facts and Dimensions**: Fact tables, dimension tables, grain, and redrawing the Brewhouse data as a star. Animated.
- **16.3 Slowly Changing Dimensions**: What to do when a customer moves city or a product changes price: overwrite, add a row, add a column.
- **16.4 Building a Small Warehouse from the Shop Data**: Create a date dimension, load dimensions and a sales fact table, and query it.
- **16.5 Denormalisation and When to Break the Rules**: Wide tables, summary tables, and the trade-off against the normal forms from earlier.

## Chapter 17: Administration and Security

- **17.1 psql Essentials**: Connecting from the terminal, the backslash commands, running script files, and formatting output.
- **17.2 Schemas and the Search Path**: Organising tables into schemas, qualified names, and the search path.
- **17.3 Users, Roles and GRANT**: Creating a read-only analyst role, GRANT and REVOKE, and the principle of least privilege.
- **17.4 Row-Level Security**: Letting each user see only their own rows with a policy.
- **17.5 Backup and Restore with pg_dump**: Dumping one table or a whole database, restoring it, and checking the restore.
- **17.6 Extensions**: Listing and enabling extensions (pg_trgm, uuid-ossp, pgcrypto) and what each is for.

## Chapter 18: SQL in the Real World

- **18.1 Connecting Excel, Power BI and Metabase**: Pointing a spreadsheet and two BI tools at the database, and building a chart from a SQL query.
- **18.2 SQL with Python and pandas**: Running a query from Python, loading the result into a DataFrame, and plotting it.
- **18.3 Parameterised Queries and SQL Injection**: How an attack works on a string-built query, and why parameters stop it. Animated.
- **18.4 Moving to MySQL and SQL Server**: What changes in another engine: LIMIT vs. TOP, date functions, quoting, string concatenation, and a translation cheat sheet.

## Chapter 19: Project: Streamly Growth Analysis

- **19.1 Project 2 Brief**: The company asks: are we growing, who stays, who leaves, and where do new users drop off? Dataset, deliverables and the rules for the project.
- **19.2 Part 1: Clean the Data**: Profile the tables, remove duplicates, standardise plans and countries, and add checks.
- **19.3 Part 2: Growth and Retention**: Monthly signups and active users, year-over-year growth, and a cohort retention table.
- **19.4 Part 3: Funnel and Segments**: Signup-to-paid funnel by channel, and RFM-style segments for viewers.
- **19.5 Part 4: Revenue and Churn**: Monthly recurring revenue, churned subscriptions, and a simple churn-risk list.
- **19.6 Part 5: Present the Findings**: Build the final views, export the results, and write three business recommendations.
- **19.7 Project 2 Solution**: Reviewing the solution, common mistakes and alternative approaches.

## Chapter 20: SQL Interview Preparation

- **20.1 How SQL Interviews Work**: The usual stages (screen, live coding, take-home), what interviewers look for, and a one-week preparation plan.
- **20.2 Interview Questions: Basics and Joins**: Eight classic questions on filtering, NULLs, duplicates and joins, solved live and explained out loud.
- **20.3 Interview Questions: Aggregation and Subqueries**: Second-highest salary, customers with no orders, the median, and other favourites.
- **20.4 Interview Questions: Window Functions**: Top N per group, running totals, consecutive days, year-over-year, and the patterns behind them.
- **20.5 Interview Questions: Design, Performance and Theory**: Indexes, normalisation, ACID, WHERE vs. HAVING, UNION vs. UNION ALL, and how to answer without rambling.
- **20.6 Live Coding and Take-Home Habits**: Thinking out loud, clarifying questions, checking edge cases, and formatting a take-home submission.
- **20.7 Mock Interview: Three Problems Live**: A full mock session with three problems of increasing difficulty and feedback on each.

## Conclusion

- **Course Conclusion**: What you can now do, a recap of the biggest ideas (joins, grouping, windows, indexes, cleaning, analytics patterns), and the next steps: certifications, other engines and portfolio ideas.

