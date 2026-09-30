-- ============================================
-- Maven Movies SQL Analysis
-- Day 4: Aggregation
-- ============================================

USE mavenmovies;


-- 1. Customers per store
SELECT
    store_id,
    COUNT(customer_id) AS customer_count
FROM customer
GROUP BY store_id;


-- 2. Customers per store - highest first
SELECT
    store_id,
    COUNT(customer_id) AS customer_count
FROM customer
GROUP BY store_id
ORDER BY customer_count DESC;


-- 3. Active customers per store
SELECT
    store_id,
    COUNT(*) AS active_customers
FROM customer
WHERE active = 1
GROUP BY store_id;


-- 4. Total revenue
SELECT
    SUM(amount) AS total_revenue
FROM payment;


-- 5. Revenue per customer
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC;


-- 6. Average payment
SELECT
    AVG(amount) AS average_payment
FROM payment;


-- 7. Revenue per staff member
SELECT
    staff_id,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY staff_id
ORDER BY total_revenue DESC;


-- 8. Highest-spending customers
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC;


-- 9. Payment count and revenue per staff member
SELECT
    staff_id,
    COUNT(payment_id) AS payment_count,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY staff_id
ORDER BY payment_count;
