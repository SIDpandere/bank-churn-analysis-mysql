# Bank Customer Churn Analysis | MySQL

Analysed a real churn dataset of **10,000 bank customers** using **joins, subqueries, CTEs and window functions** to identify patterns linked to customer churn.

## Tech
MySQL 8+ (window functions and CTEs need 8.0+) · MySQL Workbench

## Project structure
| File | Purpose |
|---|---|
| `sql/01_schema.sql` | Database, lookup tables, load and clean into `customers` |
| `sql/02_data_quality.sql` | Row counts, nulls, duplicates, overall churn rate |
| `sql/03_joins.sql` | Churn by country, age band, country x gender |
| `sql/04_subqueries.sql` | Above-average balance churners, above-average segments |
| `sql/05_ctes.sql` | Risk segmentation with single and multi-CTE queries |
| `sql/06_window_functions.sql` | RANK, ROW_NUMBER, NTILE, running totals, partition averages |
| `presentation/Bank_Churn_Analysis.pptx` | Project presentation |

## How to run
1. Download `Churn_Modelling.csv` into `data/`.
2. Run the SQL files in order (01 to 06).

## Key findings
- Overall churn is about 20% of customers.
- Germany churns at roughly double the rate of France and Spain.
- Female customers and inactive members churn noticeably more.
- Customers aged 40-59 and those holding 3-4 products are the highest-risk segments.

## Author
Siddharth Pandere · [GitHub](https://github.com/SIDpandere) · [LinkedIn](https://linkedin.com/in/siddharthpandere)
