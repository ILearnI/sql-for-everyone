# SQL for Everyone: From Zero to Confident

The files of the course **SQL for Everyone: From Zero to Confident**: every query of every lesson, the practice databases, and a link to run each lesson in your browser.
If this repository helps you, please give it a star so other learners can find it.

> **Nothing to install:** open any **Run** link below and the lesson's queries run in your browser on real PostgreSQL.
> Prefer your own computer? See [`00_setup`](00_setup).

> **Cheat sheet:** all the syntax from the course on one page: [open the cheat sheet](https://www.codepion.com/exercises/udemy-sql-course/cheat-sheet/).

## New here?

Start with the [setup guide](00_setup/README.md). It covers three ways to run the queries: in your browser, with Docker, or with a normal PostgreSQL install.

## What is in this repository

```
00_setup/       how to run the queries, plus ready-to-use Docker packages for the two databases
01_datasets/    description of the Brewhouse and Streamly databases, and the CSV files for the import lessons
02_docs/        the course outline
03_scripts/     one SQL file per lesson, grouped by chapter
```

Chapters 1 to 13 use the **Brewhouse** database (an online coffee shop). Chapters 14 to 20 use **Streamly** (a video-streaming service).
Each script starts with a few comment lines saying which database it needs.

## The lessons

Every lesson with queries has its script, a playground (runs in the browser) and a lesson page with exercises and quizzes.

### Chapter 1: Getting Started

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 1.1 | What Is a Database? | [SQL](03_scripts/01_Getting_Started/01_What_Is_a_Database.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/what-is-a-database/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/what-is-a-database/) |
| 1.2 | What Is SQL? | [SQL](03_scripts/01_Getting_Started/02_What_Is_SQL.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/what-is-sql/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/what-is-sql/) |
| 1.3 | Setting Up Your Database (Optional) | [SQL](03_scripts/01_Getting_Started/03_Setting_Up_Your_Database_Optional.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/setting-up-your-database/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/setting-up-your-database/) |
| 1.4 | Meet the Shop Dataset | [SQL](03_scripts/01_Getting_Started/04_Meet_the_Shop_Dataset.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/meet-the-shop-dataset/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/meet-the-shop-dataset/) |
| 1.5 | Your First Queries | [SQL](03_scripts/01_Getting_Started/05_Your_First_Queries.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/your-first-queries/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/your-first-queries/) |

### Chapter 2: Querying Data

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 2.1 | SELECT and FROM | [SQL](03_scripts/02_Querying_Data/01_SELECT_and_FROM.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/select-and-from/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/select-and-from/) |
| 2.2 | Aliases and Expressions | [SQL](03_scripts/02_Querying_Data/02_Aliases_and_Expressions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/aliases-and-expressions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/aliases-and-expressions/) |
| 2.3 | DISTINCT | [SQL](03_scripts/02_Querying_Data/03_DISTINCT.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/distinct/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/distinct/) |
| 2.4 | ORDER BY | [SQL](03_scripts/02_Querying_Data/04_ORDER_BY.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/order-by/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/order-by/) |
| 2.5 | LIMIT and OFFSET | [SQL](03_scripts/02_Querying_Data/05_LIMIT_and_OFFSET.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/limit-and-offset/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/limit-and-offset/) |
| 2.6 | Writing Readable SQL and Reading Error Messages | [SQL](03_scripts/02_Querying_Data/06_Writing_Readable_SQL_and_Reading_Error_Messages.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/writing-readable-sql-and-reading-error-messages/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/writing-readable-sql-and-reading-error-messages/) |
| 2.7 | How a Query Runs | [SQL](03_scripts/02_Querying_Data/07_How_a_Query_Runs.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/how-a-query-runs/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/how-a-query-runs/) |

### Chapter 3: Filtering Data

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 3.1 | WHERE and Comparison Operators | [SQL](03_scripts/03_Filtering_Data/01_WHERE_and_Comparison_Operators.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/where-and-comparison-operators/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/where-and-comparison-operators/) |
| 3.2 | AND, OR and NOT | [SQL](03_scripts/03_Filtering_Data/02_AND_OR_and_NOT.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/and-or-and-not/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/and-or-and-not/) |
| 3.3 | IN and BETWEEN | [SQL](03_scripts/03_Filtering_Data/03_IN_and_BETWEEN.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/in-and-between/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/in-and-between/) |
| 3.4 | LIKE and ILIKE | [SQL](03_scripts/03_Filtering_Data/04_LIKE_and_ILIKE.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/like-and-ilike/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/like-and-ilike/) |
| 3.5 | NULL and IS NULL | [SQL](03_scripts/03_Filtering_Data/05_NULL_and_IS_NULL.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/null-and-is-null/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/null-and-is-null/) |
| 3.6 | Regular Expressions | [SQL](03_scripts/03_Filtering_Data/06_Regular_Expressions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/regular-expressions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/regular-expressions/) |
| 3.7 | Filtering Challenge | [SQL](03_scripts/03_Filtering_Data/07_Filtering_Challenge.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/filtering-challenge/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/filtering-challenge/) |

### Chapter 4: Functions and Expressions

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 4.1 | String Functions | [SQL](03_scripts/04_Functions_and_Expressions/01_String_Functions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/string-functions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/string-functions/) |
| 4.2 | Number Functions | [SQL](03_scripts/04_Functions_and_Expressions/02_Number_Functions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/number-functions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/number-functions/) |
| 4.3 | Dates and Times | [SQL](03_scripts/04_Functions_and_Expressions/03_Dates_and_Times.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/dates-and-times/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/dates-and-times/) |
| 4.4 | Date Arithmetic and EXTRACT | [SQL](03_scripts/04_Functions_and_Expressions/04_Date_Arithmetic_and_EXTRACT.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/date-arithmetic-and-extract/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/date-arithmetic-and-extract/) |
| 4.5 | JSON and JSONB | [SQL](03_scripts/04_Functions_and_Expressions/05_JSON_and_JSONB.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/json-and-jsonb/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/json-and-jsonb/) |
| 4.6 | Arrays and generate_series | [SQL](03_scripts/04_Functions_and_Expressions/06_Arrays_and_generate_series.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/arrays-and-generate-series/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/arrays-and-generate-series/) |
| 4.7 | Full-Text Search Basics | [SQL](03_scripts/04_Functions_and_Expressions/07_Full_Text_Search_Basics.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/full-text-search-basics/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/full-text-search-basics/) |
| 4.8 | CASE Expressions | [SQL](03_scripts/04_Functions_and_Expressions/08_CASE_Expressions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/case-expressions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/case-expressions/) |
| 4.9 | COALESCE, NULLIF and CAST | [SQL](03_scripts/04_Functions_and_Expressions/09_COALESCE_NULLIF_and_CAST.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/coalesce-nullif-and-cast/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/coalesce-nullif-and-cast/) |

### Chapter 5: Aggregating Data

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 5.1 | COUNT, SUM, AVG, MIN and MAX | [SQL](03_scripts/05_Aggregating_Data/01_COUNT_SUM_AVG_MIN_and_MAX.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/count-sum-avg-min-and-max/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/count-sum-avg-min-and-max/) |
| 5.2 | GROUP BY | [SQL](03_scripts/05_Aggregating_Data/02_GROUP_BY.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/group-by/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/group-by/) |
| 5.3 | Grouping by Several Columns | [SQL](03_scripts/05_Aggregating_Data/03_Grouping_by_Several_Columns.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/grouping-by-several-columns/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/grouping-by-several-columns/) |
| 5.4 | HAVING | [SQL](03_scripts/05_Aggregating_Data/04_HAVING.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/having/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/having/) |
| 5.5 | ROLLUP, CUBE and Grouping Sets | [SQL](03_scripts/05_Aggregating_Data/05_ROLLUP_CUBE_and_Grouping_Sets.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/rollup-cube-and-grouping-sets/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/rollup-cube-and-grouping-sets/) |
| 5.6 | FILTER and Conditional Aggregation | [SQL](03_scripts/05_Aggregating_Data/06_FILTER_and_Conditional_Aggregation.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/filter-and-conditional-aggregation/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/filter-and-conditional-aggregation/) |
| 5.7 | Pivoting Data | [SQL](03_scripts/05_Aggregating_Data/07_Pivoting_Data.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/pivoting-data/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/pivoting-data/) |
| 5.8 | string_agg, array_agg and DISTINCT ON | [SQL](03_scripts/05_Aggregating_Data/08_string_agg_array_agg_and_DISTINCT_ON.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/string-agg-array-agg-and-distinct-on/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/string-agg-array-agg-and-distinct-on/) |
| 5.9 | Statistics in SQL | [SQL](03_scripts/05_Aggregating_Data/09_Statistics_in_SQL.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/statistics-in-sql/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/statistics-in-sql/) |
| 5.10 | Aggregation Challenge | [SQL](03_scripts/05_Aggregating_Data/10_Aggregation_Challenge.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/aggregation-challenge/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/aggregation-challenge/) |

### Chapter 6: Creating and Changing Data

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 6.1 | Data Types | [SQL](03_scripts/06_Creating_and_Changing_Data/01_Data_Types.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/data-types/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/data-types/) |
| 6.2 | CREATE TABLE | [SQL](03_scripts/06_Creating_and_Changing_Data/02_CREATE_TABLE.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/create-table/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/create-table/) |
| 6.3 | Primary and Foreign Keys | [SQL](03_scripts/06_Creating_and_Changing_Data/03_Primary_and_Foreign_Keys.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/primary-and-foreign-keys/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/primary-and-foreign-keys/) |
| 6.4 | Constraints | [SQL](03_scripts/06_Creating_and_Changing_Data/04_Constraints.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/constraints/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/constraints/) |
| 6.5 | INSERT | [SQL](03_scripts/06_Creating_and_Changing_Data/05_INSERT.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/insert/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/insert/) |
| 6.6 | UPDATE and DELETE Safely | [SQL](03_scripts/06_Creating_and_Changing_Data/06_UPDATE_and_DELETE_Safely.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/update-and-delete-safely/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/update-and-delete-safely/) |
| 6.7 | UPSERT and RETURNING | [SQL](03_scripts/06_Creating_and_Changing_Data/07_UPSERT_and_RETURNING.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/upsert-and-returning/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/upsert-and-returning/) |
| 6.8 | MERGE | [SQL](03_scripts/06_Creating_and_Changing_Data/08_MERGE.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/merge/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/merge/) |
| 6.9 | Identity Columns, Sequences and Generated Columns | [SQL](03_scripts/06_Creating_and_Changing_Data/09_Identity_Columns_Sequences_and_Generated_Columns.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/identity-columns-sequences-and-generated-columns/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/identity-columns-sequences-and-generated-columns/) |
| 6.10 | Enums and Custom Types | [SQL](03_scripts/06_Creating_and_Changing_Data/10_Enums_and_Custom_Types.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/enums-and-custom-types/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/enums-and-custom-types/) |
| 6.11 | ALTER TABLE and DROP | [SQL](03_scripts/06_Creating_and_Changing_Data/11_ALTER_TABLE_and_DROP.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/alter-table-and-drop/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/alter-table-and-drop/) |

### Chapter 7: Joining Tables

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 7.1 | Why Joins? | [SQL](03_scripts/07_Joining_Tables/01_Why_Joins.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/why-joins/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/why-joins/) |
| 7.2 | INNER JOIN | [SQL](03_scripts/07_Joining_Tables/02_INNER_JOIN.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/inner-join/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/inner-join/) |
| 7.3 | LEFT JOIN | [SQL](03_scripts/07_Joining_Tables/03_LEFT_JOIN.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/left-join/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/left-join/) |
| 7.4 | RIGHT and FULL JOIN | [SQL](03_scripts/07_Joining_Tables/04_RIGHT_and_FULL_JOIN.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/right-and-full-join/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/right-and-full-join/) |
| 7.5 | CROSS and Self Joins | [SQL](03_scripts/07_Joining_Tables/05_CROSS_and_Self_Joins.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/cross-and-self-joins/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/cross-and-self-joins/) |
| 7.6 | Joining Three or More Tables | [SQL](03_scripts/07_Joining_Tables/06_Joining_Three_or_More_Tables.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/joining-three-or-more-tables/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/joining-three-or-more-tables/) |
| 7.7 | UPDATE FROM, DELETE USING and TRUNCATE | [SQL](03_scripts/07_Joining_Tables/07_UPDATE_FROM_DELETE_USING_and_TRUNCATE.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/update-from-delete-using-and-truncate/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/update-from-delete-using-and-truncate/) |
| 7.8 | UNION, INTERSECT and EXCEPT | [SQL](03_scripts/07_Joining_Tables/08_UNION_INTERSECT_and_EXCEPT.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/union-intersect-and-except/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/union-intersect-and-except/) |
| 7.9 | USING, NATURAL and Non-Equi Joins | [SQL](03_scripts/07_Joining_Tables/09_USING_NATURAL_and_Non_Equi_Joins.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/using-natural-and-non-equi-joins/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/using-natural-and-non-equi-joins/) |
| 7.10 | Anti-Joins and Semi-Joins | [SQL](03_scripts/07_Joining_Tables/10_Anti_Joins_and_Semi_Joins.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/anti-joins-and-semi-joins/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/anti-joins-and-semi-joins/) |
| 7.11 | LATERAL Joins | [SQL](03_scripts/07_Joining_Tables/11_LATERAL_Joins.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/lateral-joins/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/lateral-joins/) |
| 7.12 | Join Fan-Out: Why Totals Double | [SQL](03_scripts/07_Joining_Tables/12_Join_Fan_Out_Why_Totals_Double.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/join-fan-out-why-totals-double/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/join-fan-out-why-totals-double/) |
| 7.13 | Joins Challenge | [SQL](03_scripts/07_Joining_Tables/13_Joins_Challenge.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/joins-challenge/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/joins-challenge/) |

### Chapter 8: Subqueries and CTEs

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 8.1 | Subqueries in WHERE | [SQL](03_scripts/08_Subqueries_and_CTEs/01_Subqueries_in_WHERE.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/subqueries-in-where/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/subqueries-in-where/) |
| 8.2 | Subqueries in FROM and SELECT | [SQL](03_scripts/08_Subqueries_and_CTEs/02_Subqueries_in_FROM_and_SELECT.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/subqueries-in-from-and-select/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/subqueries-in-from-and-select/) |
| 8.3 | EXISTS and NOT EXISTS | [SQL](03_scripts/08_Subqueries_and_CTEs/03_EXISTS_and_NOT_EXISTS.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/exists-and-not-exists/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/exists-and-not-exists/) |
| 8.4 | Common Table Expressions | [SQL](03_scripts/08_Subqueries_and_CTEs/04_Common_Table_Expressions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/common-table-expressions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/common-table-expressions/) |
| 8.5 | Several CTEs and Recursive CTEs | [SQL](03_scripts/08_Subqueries_and_CTEs/05_Several_CTEs_and_Recursive_CTEs.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/several-ctes-and-recursive-ctes/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/several-ctes-and-recursive-ctes/) |
| 8.6 | Correlated Subqueries | [SQL](03_scripts/08_Subqueries_and_CTEs/06_Correlated_Subqueries.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/correlated-subqueries/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/correlated-subqueries/) |
| 8.7 | Subqueries and CTEs Challenge | [SQL](03_scripts/08_Subqueries_and_CTEs/07_Subqueries_and_CTEs_Challenge.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/subqueries-and-ctes-challenge/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/subqueries-and-ctes-challenge/) |

### Chapter 9: Window Functions

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 9.1 | What Is a Window Function? | [SQL](03_scripts/09_Window_Functions/01_What_Is_a_Window_Function.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/what-is-a-window-function/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/what-is-a-window-function/) |
| 9.2 | PARTITION BY and ORDER BY | [SQL](03_scripts/09_Window_Functions/02_PARTITION_BY_and_ORDER_BY.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/partition-by-and-order-by/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/partition-by-and-order-by/) |
| 9.3 | Ranking: ROW_NUMBER, RANK and DENSE_RANK | [SQL](03_scripts/09_Window_Functions/03_Ranking_ROW_NUMBER_RANK_and_DENSE_RANK.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/ranking-row-number-rank-and-dense-rank/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/ranking-row-number-rank-and-dense-rank/) |
| 9.4 | Running Totals and Frames | [SQL](03_scripts/09_Window_Functions/04_Running_Totals_and_Frames.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/running-totals-and-frames/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/running-totals-and-frames/) |
| 9.5 | LAG and LEAD | [SQL](03_scripts/09_Window_Functions/05_LAG_and_LEAD.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/lag-and-lead/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/lag-and-lead/) |
| 9.6 | NTILE, FIRST_VALUE and Percentiles | [SQL](03_scripts/09_Window_Functions/06_NTILE_FIRST_VALUE_and_Percentiles.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/ntile-first-value-and-percentiles/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/ntile-first-value-and-percentiles/) |
| 9.7 | Named Windows and Distribution Functions | [SQL](03_scripts/09_Window_Functions/07_Named_Windows_and_Distribution_Functions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/named-windows-and-distribution-functions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/named-windows-and-distribution-functions/) |
| 9.8 | Frame Types: ROWS, RANGE and GROUPS | [SQL](03_scripts/09_Window_Functions/08_Frame_Types_ROWS_RANGE_and_GROUPS.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/frame-types-rows-range-and-groups/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/frame-types-rows-range-and-groups/) |
| 9.9 | Window Functions Challenge | [SQL](03_scripts/09_Window_Functions/09_Window_Functions_Challenge.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/window-functions-challenge/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/window-functions-challenge/) |

### Chapter 10: Views and Reusable SQL

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 10.1 | Views | [SQL](03_scripts/10_Views_and_Reusable_SQL/01_Views.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/views/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/views/) |
| 10.2 | Materialized Views | [SQL](03_scripts/10_Views_and_Reusable_SQL/02_Materialized_Views.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/materialized-views/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/materialized-views/) |
| 10.3 | Temporary Tables and CREATE TABLE AS | [SQL](03_scripts/10_Views_and_Reusable_SQL/03_Temporary_Tables_and_CREATE_TABLE_AS.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/temporary-tables-and-create-table-as/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/temporary-tables-and-create-table-as/) |
| 10.4 | SQL Functions | [SQL](03_scripts/10_Views_and_Reusable_SQL/04_SQL_Functions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/sql-functions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/sql-functions/) |
| 10.5 | Stored Procedures and PL/pgSQL | [SQL](03_scripts/10_Views_and_Reusable_SQL/05_Stored_Procedures_and_PL_pgSQL.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/stored-procedures-and-pl-pgsql/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/stored-procedures-and-pl-pgsql/) |
| 10.6 | Triggers | [SQL](03_scripts/10_Views_and_Reusable_SQL/06_Triggers.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/triggers/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/triggers/) |
| 10.7 | Reusable SQL Challenge | [SQL](03_scripts/10_Views_and_Reusable_SQL/07_Reusable_SQL_Challenge.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/reusable-sql-challenge/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/reusable-sql-challenge/) |

### Chapter 11: Speed and Safety

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 11.1 | Indexes | [SQL](03_scripts/11_Speed_and_Safety/01_Indexes.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/indexes/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/indexes/) |
| 11.2 | Reading a Query Plan with EXPLAIN | [SQL](03_scripts/11_Speed_and_Safety/02_Reading_a_Query_Plan_with_EXPLAIN.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/reading-a-query-plan-with-explain/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/reading-a-query-plan-with-explain/) |
| 11.3 | Transactions | [SQL](03_scripts/11_Speed_and_Safety/03_Transactions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/transactions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/transactions/) |
| 11.4 | Index Types: Composite, Partial, Covering and GIN | [SQL](03_scripts/11_Speed_and_Safety/04_Index_Types_Composite_Partial_Covering_and_GIN.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/index-types-composite-partial-covering-and-gin/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/index-types-composite-partial-covering-and-gin/) |
| 11.5 | Locks, Isolation Levels and MVCC | [SQL](03_scripts/11_Speed_and_Safety/05_Locks_Isolation_Levels_and_MVCC.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/locks-isolation-levels-and-mvcc/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/locks-isolation-levels-and-mvcc/) |
| 11.6 | Maintenance: VACUUM, ANALYZE and Statistics | [SQL](03_scripts/11_Speed_and_Safety/06_Maintenance_VACUUM_ANALYZE_and_Statistics.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/maintenance-vacuum-analyze-and-statistics/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/maintenance-vacuum-analyze-and-statistics/) |
| 11.7 | Partitioning Basics | [SQL](03_scripts/11_Speed_and_Safety/07_Partitioning_Basics.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/partitioning-basics/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/partitioning-basics/) |
| 11.8 | Writing Faster Queries | [SQL](03_scripts/11_Speed_and_Safety/08_Writing_Faster_Queries.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/writing-faster-queries/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/writing-faster-queries/) |

### Chapter 12: Working with Real Data

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 12.1 | Importing and Exporting CSV | [SQL](03_scripts/12_Working_with_Real_Data/01_Importing_and_Exporting_CSV.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/importing-and-exporting-csv/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/importing-and-exporting-csv/) |
| 12.2 | Designing a Schema | [SQL](03_scripts/12_Working_with_Real_Data/02_Designing_a_Schema.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/designing-a-schema/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/designing-a-schema/) |
| 12.3 | Normalisation in Plain English | [SQL](03_scripts/12_Working_with_Real_Data/03_Normalisation_in_Plain_English.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/normalisation-in-plain-english/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/normalisation-in-plain-english/) |
| 12.4 | Using AI to Write and Debug SQL | [SQL](03_scripts/12_Working_with_Real_Data/04_Using_AI_to_Write_and_Debug_SQL.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/using-ai-to-write-and-debug-sql/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/using-ai-to-write-and-debug-sql/) |

### Chapter 13: Project: Brewhouse Sales Analysis

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 13.1 | Project Brief | [SQL](03_scripts/13_Project_Brewhouse_Sales_Analysis/01_Project_Brief.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/project-brief/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/project-brief/) |
| 13.2 | Part 1: Revenue Over Time | [SQL](03_scripts/13_Project_Brewhouse_Sales_Analysis/02_Part_1_Revenue_Over_Time.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/part-1-revenue-over-time/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/part-1-revenue-over-time/) |
| 13.3 | Part 2: Customers | [SQL](03_scripts/13_Project_Brewhouse_Sales_Analysis/03_Part_2_Customers.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/part-2-customers/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/part-2-customers/) |
| 13.4 | Part 3: Products | [SQL](03_scripts/13_Project_Brewhouse_Sales_Analysis/04_Part_3_Products.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/part-3-products/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/part-3-products/) |
| 13.5 | Part 4: Turn It into a Report | [SQL](03_scripts/13_Project_Brewhouse_Sales_Analysis/05_Part_4_Turn_It_into_a_Report.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/part-4-turn-it-into-a-report/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/part-4-turn-it-into-a-report/) |
| 13.6 | Project Solution and Next Steps | [SQL](03_scripts/13_Project_Brewhouse_Sales_Analysis/06_Project_Solution_and_Next_Steps.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/project-solution-and-next-steps/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/project-solution-and-next-steps/) |

### Chapter 14: Data Cleaning and Quality

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 14.1 | Meet the Streamly Dataset | [SQL](03_scripts/14_Data_Cleaning_and_Quality/01_Meet_the_Streamly_Dataset.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/meet-the-streamly-dataset/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/meet-the-streamly-dataset/) |
| 14.2 | Profiling a Table | [SQL](03_scripts/14_Data_Cleaning_and_Quality/02_Profiling_a_Table.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/profiling-a-table/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/profiling-a-table/) |
| 14.3 | Finding and Removing Duplicates | [SQL](03_scripts/14_Data_Cleaning_and_Quality/03_Finding_and_Removing_Duplicates.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/finding-and-removing-duplicates/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/finding-and-removing-duplicates/) |
| 14.4 | Standardising Text, Dates and Categories | [SQL](03_scripts/14_Data_Cleaning_and_Quality/04_Standardising_Text_Dates_and_Categories.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/standardising-text-dates-and-categories/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/standardising-text-dates-and-categories/) |
| 14.5 | Missing Values and Outliers | [SQL](03_scripts/14_Data_Cleaning_and_Quality/05_Missing_Values_and_Outliers.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/missing-values-and-outliers/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/missing-values-and-outliers/) |
| 14.6 | Validating Data with Constraints and Checks | [SQL](03_scripts/14_Data_Cleaning_and_Quality/06_Validating_Data_with_Constraints_and_Checks.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/validating-data-with-constraints-and-checks/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/validating-data-with-constraints-and-checks/) |
| 14.7 | Data Cleaning Challenge | [SQL](03_scripts/14_Data_Cleaning_and_Quality/07_Data_Cleaning_Challenge.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/data-cleaning-challenge/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/data-cleaning-challenge/) |

### Chapter 15: Analytics Patterns

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 15.1 | Calendar Tables and Filling Gaps | [SQL](03_scripts/15_Analytics_Patterns/01_Calendar_Tables_and_Filling_Gaps.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/calendar-tables-and-filling-gaps/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/calendar-tables-and-filling-gaps/) |
| 15.2 | Year-over-Year and Period Comparisons | [SQL](03_scripts/15_Analytics_Patterns/02_Year_over_Year_and_Period_Comparisons.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/year-over-year-and-period-comparisons/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/year-over-year-and-period-comparisons/) |
| 15.3 | Cohort Retention | [SQL](03_scripts/15_Analytics_Patterns/03_Cohort_Retention.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/cohort-retention/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/cohort-retention/) |
| 15.4 | Funnels and Conversion | [SQL](03_scripts/15_Analytics_Patterns/04_Funnels_and_Conversion.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/funnels-and-conversion/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/funnels-and-conversion/) |
| 15.5 | RFM Customer Segmentation | [SQL](03_scripts/15_Analytics_Patterns/05_RFM_Customer_Segmentation.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/rfm-customer-segmentation/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/rfm-customer-segmentation/) |
| 15.6 | Gaps and Islands | [SQL](03_scripts/15_Analytics_Patterns/06_Gaps_and_Islands.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/gaps-and-islands/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/gaps-and-islands/) |
| 15.7 | Sessionisation | [SQL](03_scripts/15_Analytics_Patterns/07_Sessionisation.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/sessionisation/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/sessionisation/) |
| 15.8 | Pareto and ABC Analysis | [SQL](03_scripts/15_Analytics_Patterns/08_Pareto_and_ABC_Analysis.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/pareto-and-abc-analysis/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/pareto-and-abc-analysis/) |
| 15.9 | Top N per Group and Latest Row per Group | [SQL](03_scripts/15_Analytics_Patterns/09_Top_N_per_Group_and_Latest_Row_per_Group.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/top-n-per-group-and-latest-row-per-group/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/top-n-per-group-and-latest-row-per-group/) |
| 15.10 | Analytics Patterns Challenge | [SQL](03_scripts/15_Analytics_Patterns/10_Analytics_Patterns_Challenge.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/analytics-patterns-challenge/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/analytics-patterns-challenge/) |

### Chapter 16: Data Modeling and Warehousing

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 16.1 | OLTP vs. OLAP | [SQL](03_scripts/16_Data_Modeling_and_Warehousing/01_OLTP_vs_OLAP.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/oltp-vs-olap/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/oltp-vs-olap/) |
| 16.2 | Star Schema: Facts and Dimensions | [SQL](03_scripts/16_Data_Modeling_and_Warehousing/02_Star_Schema_Facts_and_Dimensions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/star-schema-facts-and-dimensions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/star-schema-facts-and-dimensions/) |
| 16.3 | Slowly Changing Dimensions | [SQL](03_scripts/16_Data_Modeling_and_Warehousing/03_Slowly_Changing_Dimensions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/slowly-changing-dimensions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/slowly-changing-dimensions/) |
| 16.4 | Building a Small Warehouse from the Shop Data | [SQL](03_scripts/16_Data_Modeling_and_Warehousing/04_Building_a_Small_Warehouse_from_the_Shop_Data.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/building-a-small-warehouse-from-the-shop-data/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/building-a-small-warehouse-from-the-shop-data/) |
| 16.5 | Denormalisation and When to Break the Rules | [SQL](03_scripts/16_Data_Modeling_and_Warehousing/05_Denormalisation_and_When_to_Break_the_Rules.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/denormalisation-and-when-to-break-the-rules/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/denormalisation-and-when-to-break-the-rules/) |

### Chapter 17: Administration and Security

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 17.1 | psql Essentials | [SQL](03_scripts/17_Administration_and_Security/01_psql_Essentials.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/psql-essentials/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/psql-essentials/) |
| 17.2 | Schemas and the Search Path | [SQL](03_scripts/17_Administration_and_Security/02_Schemas_and_the_Search_Path.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/schemas-and-the-search-path/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/schemas-and-the-search-path/) |
| 17.3 | Users, Roles and GRANT | [SQL](03_scripts/17_Administration_and_Security/03_Users_Roles_and_GRANT.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/users-roles-and-grant/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/users-roles-and-grant/) |
| 17.4 | Row-Level Security | [SQL](03_scripts/17_Administration_and_Security/04_Row_Level_Security.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/row-level-security/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/row-level-security/) |
| 17.5 | Backup and Restore with pg_dump | [SQL](03_scripts/17_Administration_and_Security/05_Backup_and_Restore_with_pg_dump.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/backup-and-restore-with-pg-dump/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/backup-and-restore-with-pg-dump/) |
| 17.6 | Extensions | [SQL](03_scripts/17_Administration_and_Security/06_Extensions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/extensions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/extensions/) |

### Chapter 18: SQL in the Real World

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 18.1 | Connecting Excel, Power BI and Metabase | [SQL](03_scripts/18_SQL_in_the_Real_World/01_Connecting_Excel_Power_BI_and_Metabase.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/connecting-excel-power-bi-and-metabase/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/connecting-excel-power-bi-and-metabase/) |
| 18.2 | SQL with Python and pandas | [SQL](03_scripts/18_SQL_in_the_Real_World/02_SQL_with_Python_and_pandas.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/sql-with-python-and-pandas/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/sql-with-python-and-pandas/) |
| 18.3 | Parameterised Queries and SQL Injection | [SQL](03_scripts/18_SQL_in_the_Real_World/03_Parameterised_Queries_and_SQL_Injection.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/parameterised-queries-and-sql-injection/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/parameterised-queries-and-sql-injection/) |
| 18.4 | Moving to MySQL and SQL Server | [SQL](03_scripts/18_SQL_in_the_Real_World/04_Moving_to_MySQL_and_SQL_Server.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/moving-to-mysql-and-sql-server/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/moving-to-mysql-and-sql-server/) |

### Chapter 19: Project: Streamly Growth Analysis

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 19.1 | Project 2 Brief | [SQL](03_scripts/19_Project_Streamly_Growth_Analysis/01_Project_2_Brief.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/project-2-brief/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/project-2-brief/) |
| 19.2 | Part 1: Clean the Data | [SQL](03_scripts/19_Project_Streamly_Growth_Analysis/02_Part_1_Clean_the_Data.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/part-1-clean-the-data/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/part-1-clean-the-data/) |
| 19.3 | Part 2: Growth and Retention | [SQL](03_scripts/19_Project_Streamly_Growth_Analysis/03_Part_2_Growth_and_Retention.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/part-2-growth-and-retention/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/part-2-growth-and-retention/) |
| 19.4 | Part 3: Funnel and Segments | [SQL](03_scripts/19_Project_Streamly_Growth_Analysis/04_Part_3_Funnel_and_Segments.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/part-3-funnel-and-segments/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/part-3-funnel-and-segments/) |
| 19.5 | Part 4: Revenue and Churn | [SQL](03_scripts/19_Project_Streamly_Growth_Analysis/05_Part_4_Revenue_and_Churn.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/part-4-revenue-and-churn/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/part-4-revenue-and-churn/) |
| 19.6 | Part 5: Present the Findings | [SQL](03_scripts/19_Project_Streamly_Growth_Analysis/06_Part_5_Present_the_Findings.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/part-5-present-the-findings/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/part-5-present-the-findings/) |
| 19.7 | Project 2 Solution | [SQL](03_scripts/19_Project_Streamly_Growth_Analysis/07_Project_2_Solution.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/project-2-solution/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/project-2-solution/) |

### Chapter 20: SQL Interview Preparation

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
| 20.1 | How SQL Interviews Work | [SQL](03_scripts/20_SQL_Interview_Preparation/01_How_SQL_Interviews_Work.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/how-sql-interviews-work/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/how-sql-interviews-work/) |
| 20.2 | Interview Questions: Basics and Joins | [SQL](03_scripts/20_SQL_Interview_Preparation/02_Interview_Questions_Basics_and_Joins.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/interview-questions-basics-and-joins/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/interview-questions-basics-and-joins/) |
| 20.3 | Interview Questions: Aggregation and Subqueries | [SQL](03_scripts/20_SQL_Interview_Preparation/03_Interview_Questions_Aggregation_and_Subqueries.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/interview-questions-aggregation-and-subqueries/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/interview-questions-aggregation-and-subqueries/) |
| 20.4 | Interview Questions: Window Functions | [SQL](03_scripts/20_SQL_Interview_Preparation/04_Interview_Questions_Window_Functions.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/interview-questions-window-functions/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/interview-questions-window-functions/) |
| 20.5 | Interview Questions: Design, Performance and Theory | [SQL](03_scripts/20_SQL_Interview_Preparation/05_Interview_Questions_Design_Performance_and_Theory.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/interview-questions-design-performance-and-theory/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/interview-questions-design-performance-and-theory/) |
| 20.6 | Live Coding and Take-Home Habits | [SQL](03_scripts/20_SQL_Interview_Preparation/06_Live_Coding_and_Take_Home_Habits.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/live-coding-and-take-home-habits/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/live-coding-and-take-home-habits/) |
| 20.7 | Mock Interview: Three Problems Live | [SQL](03_scripts/20_SQL_Interview_Preparation/07_Mock_Interview_Three_Problems_Live.sql) | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/mock-interview-three-problems-live/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/mock-interview-three-problems-live/) |

### Conclusion

| # | Lesson | Script | Playground | Lesson page |
|---|---|---|---|---|
|  | Course Conclusion |  | [Run](https://www.codepion.com/exercises/udemy-sql-course/playground/course-conclusion/) | [Open](https://www.codepion.com/exercises/udemy-sql-course/lessons/course-conclusion/) |

## Learn with me

- **Watch the full course on Udemy:** *link coming when the course is published.*
- **Practise in your browser:** https://www.codepion.com/playground/
- **Exercises and quizzes:** https://www.codepion.com/exercises/udemy-sql-course/

## License

The SQL scripts and setup files are under the [MIT License](LICENSE). The datasets and documents are under
[CC BY-NC 4.0](01_datasets/LICENSE.md): free to share and adapt for non-commercial use, with credit.

## About

Created by Issam at Development Island, with the Codepion engine: short lessons, no fluff, and a playground for every lesson.
