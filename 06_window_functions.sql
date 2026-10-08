USE bank_churn;
-- Rank countries by churn
SELECT country, churn_pct, RANK() OVER (ORDER BY churn_pct DESC) rnk
FROM (SELECT g.country, ROUND(100*AVG(c.exited),2) churn_pct
      FROM customers c JOIN geography g USING (geography_id)
      GROUP BY g.country) t;

-- Top 3 high-balance churners per country
SELECT * FROM (
  SELECT g.country, c.customer_id, c.balance,
         ROW_NUMBER() OVER (PARTITION BY g.country ORDER BY c.balance DESC) rn
  FROM customers c JOIN geography g USING (geography_id)
  WHERE c.exited = 1) x WHERE rn <= 3;

-- Running total of churners by tenure
SELECT tenure, churned, SUM(churned) OVER (ORDER BY tenure) running_churned,
       ROUND(100*churned/SUM(churned) OVER (),2) share_of_churn_pct
FROM (SELECT tenure, SUM(exited) churned FROM customers GROUP BY tenure) t;

-- Credit-score quartiles vs churn
SELECT quartile, COUNT(*) n, ROUND(100*AVG(exited),2) churn_pct FROM (
  SELECT exited, NTILE(4) OVER (ORDER BY credit_score) quartile FROM customers) q
GROUP BY quartile ORDER BY quartile;

-- Balance vs country average
SELECT customer_id, balance,
       ROUND(AVG(balance) OVER (PARTITION BY geography_id),2) country_avg_balance,
       ROUND(balance - AVG(balance) OVER (PARTITION BY geography_id),2) diff
FROM customers LIMIT 20;
