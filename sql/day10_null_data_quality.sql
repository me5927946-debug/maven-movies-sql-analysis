
-- ============================================
-- Maven Movies SQL Analysis
-- Day 10: NULL Values and Data Quality
-- ============================================

USE mavenmovies;

-- Exercise 1: Find customers with missing emails
SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM customer
WHERE email IS NULL;

-- Exercise 2: Count customers with missing emails
SELECT
    COUNT(*) AS missing_email_count
FROM customer
WHERE email IS NULL;

-- Exercise 3: Count customers with recorded emails
SELECT
    COUNT(*) AS customers_with_email
FROM customer
WHERE email IS NOT NULL;

-- Exercise 4: Understand NULL in aggregates
SELECT
    COUNT(*) AS total_payment_rows,
    COUNT(amount) AS recorded_amount_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM payment;

-- Exercise 5: Display a fallback for missing emails
SELECT
    customer_id,
    first_name,
    COALESCE(email, 'No email provided') AS email_display
FROM customer;

-- Exercise 6: Replace missing amounts in query output
SELECT
    payment_id,
    customer_id,
    amount,
    COALESCE(amount, 0) AS amount_adjusted
FROM payment;

-- Exercise 7: Count missing and recorded payment amounts
SELECT
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END)
        AS missing_amount_count,
    SUM(CASE WHEN amount IS NOT NULL THEN 1 ELSE 0 END)
        AS recorded_amount_count
FROM payment;

-- Exercise 8: Customer email data-quality summary
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END)
        AS customers_with_missing_email,
    SUM(CASE WHEN email IS NOT NULL THEN 1 ELSE 0 END)
        AS customers_with_email
FROM customer;
