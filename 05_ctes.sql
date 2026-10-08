USE bank_churn;
-- Risk segments
WITH segments AS (
  SELECT c.*, g.country,
    CASE WHEN age >= 40 THEN 'Senior' ELSE 'Younger' END age_group,
    CASE WHEN is_active_member = 1 THEN 'Active' ELSE 'Inactive' END activity
  FROM customers c JOIN geography g USING (geography_id))
SELECT country, age_group, activity, COUNT(*) customers,
       ROUND(100*AVG(exited),2) churn_pct
FROM segments GROUP BY country, age_group, activity ORDER BY churn_pct DESC;

-- Multi-CTE: segments above the overall churn rate
WITH overall AS (SELECT AVG(exited) rate FROM customers),
seg AS (SELECT num_products, is_active_member, COUNT(*) n, AVG(exited) rate
        FROM customers GROUP BY num_products, is_active_member)
SELECT s.num_products, s.is_active_member, s.n, ROUND(100*s.rate,2) churn_pct,
       ROUND(100*(s.rate-o.rate),2) pts_above_overall
FROM seg s CROSS JOIN overall o
WHERE s.rate > o.rate AND s.n >= 30 ORDER BY pts_above_overall DESC;
