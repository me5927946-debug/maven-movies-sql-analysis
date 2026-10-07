-- ============================================
-- Maven Movies SQL Analysis
-- Day 7: Subqueries
-- ============================================

USE mavenmovies;


-- Exercise 1: Payments above average
-- Find payments greater than the average payment amount

SELECT
    payment_id,
    customer_id,
    amount
FROM payment
WHERE amount > (
    SELECT AVG(amount)
    FROM payment
)
ORDER BY amount DESC;


-- Exercise 2: Customers who made a payment greater than $8

SELECT
    customer_id,
    first_name,
    last_name
FROM customer
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM payment
    WHERE amount > 8
);


-- Exercise 3: Customers who never made a payment greater than $8

SELECT
    customer_id,
    first_name,
    last_name
FROM customer
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM payment
    WHERE amount > 8
)
ORDER BY customer_id ASC;


-- Exercise 4: Customers whose total spending
-- is greater than the average customer spending

SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT
            customer_id,
            SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS avg_customer_spending
)
ORDER BY total_spent DESC;


-- Exercise 5: Customers who spent more than $150

SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > 150
ORDER BY total_spent DESC;


-- Exercise 6: Customers with above-average
-- number of payments

SELECT
    customer_id,
    COUNT(payment_id) AS payment_count
FROM payment
GROUP BY customer_id
HAVING payment_count > (
    SELECT AVG(payment_count)
    FROM (
        SELECT
            customer_id,
            COUNT(payment_id) AS payment_count
        FROM payment
        GROUP BY customer_id
    ) AS customer_payment_counts
)
ORDER BY payment_count DESC;
