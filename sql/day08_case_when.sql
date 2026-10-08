-- ============================================
-- Maven Movies SQL Analysis
-- Day 8: CASE WHEN
-- ============================================

USE mavenmovies;


-- Exercise 1: Classify individual payments
SELECT
    payment_id,
    customer_id,
    amount,
    CASE
        WHEN amount <= 2 THEN 'Low'
        WHEN amount <= 5 THEN 'Medium'
        ELSE 'High'
    END AS payment_category
FROM payment
ORDER BY amount DESC;


-- Exercise 2: Classify customers by total spending
SELECT
    customer_id,
    SUM(amount) AS total_spent,
    CASE
        WHEN SUM(amount) < 100 THEN 'Low'
        WHEN SUM(amount) <= 150 THEN 'Medium'
        ELSE 'High'
    END AS customer_segment
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC;


-- Exercise 3: Customer value classification
SELECT
    customer_id,
    SUM(amount) AS total_spent,
    CASE
        WHEN SUM(amount) < 50 THEN 'Very Low'
        WHEN SUM(amount) < 100 THEN 'Low'
        WHEN SUM(amount) <= 150 THEN 'Medium'
        ELSE 'High'
    END AS customer_value
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC;


-- Exercise 4: Classify films by rental price
SELECT
    film_id,
    title,
    rental_rate,
    CASE
        WHEN rental_rate = 0.99 THEN 'Cheap'
        WHEN rental_rate = 2.99 THEN 'Standard'
        WHEN rental_rate = 4.99 THEN 'Premium'
    END AS price_category
FROM film
ORDER BY rental_rate DESC;


-- Exercise 5: Count films in each price category
SELECT
    CASE
        WHEN rental_rate = 0.99 THEN 'Cheap'
        WHEN rental_rate = 2.99 THEN 'Standard'
        WHEN rental_rate = 4.99 THEN 'Premium'
    END AS price_category,
    COUNT(*) AS film_count
FROM film
GROUP BY
    CASE
        WHEN rental_rate = 0.99 THEN 'Cheap'
        WHEN rental_rate = 2.99 THEN 'Standard'
        WHEN rental_rate = 4.99 THEN 'Premium'
    END;


-- Exercise 6: Count customers in each spending segment
SELECT
    customer_value,
    COUNT(*) AS customer_count
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_spent,
        CASE
            WHEN SUM(amount) < 50 THEN 'Very Low'
            WHEN SUM(amount) < 100 THEN 'Low'
            WHEN SUM(amount) <= 150 THEN 'Medium'
            ELSE 'High'
        END AS customer_value
    FROM payment
    GROUP BY customer_id
) AS customer_segments
GROUP BY customer_value;


-- Final Business Exercise:
-- Total revenue by payment category
SELECT
    CASE
        WHEN amount < 2 THEN 'Small'
        WHEN amount <= 4 THEN 'Medium'
        ELSE 'Large'
    END AS payment_category,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY
    CASE
        WHEN amount < 2 THEN 'Small'
        WHEN amount <= 4 THEN 'Medium'
        ELSE 'Large'
    END
ORDER BY total_revenue DESC;
