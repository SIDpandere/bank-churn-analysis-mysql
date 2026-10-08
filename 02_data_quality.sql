USE bank_churn;
SELECT COUNT(*) total_customers, SUM(exited) churned,
       ROUND(100*AVG(exited),2) churn_rate_pct FROM customers;
SELECT SUM(credit_score IS NULL) null_credit, SUM(age IS NULL) null_age,
       SUM(balance IS NULL) null_balance FROM customers;
SELECT customer_id, COUNT(*) c FROM customers GROUP BY customer_id HAVING c > 1;
