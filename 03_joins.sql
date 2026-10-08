USE bank_churn;
-- Churn by country
SELECT g.country, COUNT(*) customers, SUM(c.exited) churned,
       ROUND(100*AVG(c.exited),2) churn_pct
FROM customers c JOIN geography g ON g.geography_id = c.geography_id
GROUP BY g.country ORDER BY churn_pct DESC;

-- Churn by age band (range join)
SELECT a.band, COUNT(*) customers, ROUND(100*AVG(c.exited),2) churn_pct
FROM customers c JOIN age_bands a ON c.age BETWEEN a.min_age AND a.max_age
GROUP BY a.band ORDER BY a.min_age;

-- Country x gender
SELECT g.country, c.gender, ROUND(100*AVG(c.exited),2) churn_pct
FROM customers c JOIN geography g USING (geography_id)
GROUP BY g.country, c.gender ORDER BY g.country, churn_pct DESC;
