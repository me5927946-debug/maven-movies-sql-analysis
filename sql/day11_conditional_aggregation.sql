```sql
-- ============================================
-- Maven Movies SQL Analysis
-- Day 11: Conditional Aggregation
-- ============================================

USE mavenmovies;

-- Exercise 1: Customer activity summary
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END)
        AS active_customers,
    SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END)
        AS inactive_customers
FROM customer;


-- Exercise 2: Count payments by category
SELECT
    SUM(CASE WHEN amount < 2 THEN 1 ELSE 0 END)
        AS small_payments,
    SUM(CASE WHEN amount >= 2 AND amount <= 4 THEN 1 ELSE 0 END)
        AS medium_payments,
    SUM(CASE WHEN amount > 4 THEN 1 ELSE 0 END)
        AS large_payments
FROM payment;


-- Exercise 3: Revenue by payment category
SELECT
    SUM(CASE WHEN amount < 2 THEN amount ELSE 0 END)
        AS small_revenue,
    SUM(CASE WHEN amount >= 2 AND amount <= 4 THEN amount ELSE 0 END)
        AS medium_revenue,
    SUM(CASE WHEN amount > 4 THEN amount ELSE 0 END)
        AS large_revenue
FROM payment;


-- Exercise 4: Payment KPI report
SELECT
    COUNT(*) AS total_payments,
    SUM(amount) AS total_revenue,
    SUM(CASE WHEN amount > 4 THEN 1 ELSE 0 END)
        AS count_large_payments,
    SUM(CASE WHEN amount > 4 THEN amount ELSE 0 END)
        AS revenue_large_payments,
    AVG(amount) AS avg_amount
FROM payment;


-- Exercise 5: Customer activity percentage
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END)
        AS active_customers,
    SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END)
        AS inactive_customers,
    100.0 * SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END)
        / COUNT(*) AS active_percentage
FROM customer;
```
