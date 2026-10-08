USE bank_churn;
-- Churners with balance above the bank average
SELECT customer_id, surname, balance FROM customers
WHERE exited = 1 AND balance > (SELECT AVG(balance) FROM customers)
ORDER BY balance DESC LIMIT 20;

-- Countries with churn above the bank-wide rate
SELECT g.country, ROUND(100*AVG(c.exited),2) churn_pct
FROM customers c JOIN geography g USING (geography_id)
GROUP BY g.country HAVING AVG(c.exited) > (SELECT AVG(exited) FROM customers);

-- Product counts with above-average churn (derived table)
SELECT num_products, churn_pct FROM (
  SELECT num_products, ROUND(100*AVG(exited),2) churn_pct
  FROM customers GROUP BY num_products) t
WHERE churn_pct > (SELECT 100*AVG(exited) FROM customers);

-- EXISTS: countries having inactive churners
SELECT g.country FROM geography g WHERE EXISTS (
  SELECT 1 FROM customers c WHERE c.geography_id = g.geography_id
  AND c.exited = 1 AND c.is_active_member = 0);
