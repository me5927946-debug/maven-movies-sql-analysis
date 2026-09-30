SELECT customer_id , COUNT(payment_id) AS payment_count
FROM payment
GROUP BY customer_id
HAVING payment_count > 30
ORDER BY payment_count DESC;

SELECT customer_id , SUM(amount) AS total_spent
FROM payment 
GROUP BY customer_id
HAVING total_spent > 100
ORDER BY total_spent DESC;

SELECT staff_id , COUNT(payment_id) AS payment_count
FROM payment
GROUP BY staff_id
HAVING payment_count > 8000;

SELECT staff_id , SUM(amount) AS total_revenue
FROM payment
GROUP BY staff_id
HAVING total_revenue > 30000
ORDER BY total_revenue DESC;

SELECT customer_id , AVG(amount) AS average_payment
FROM payment
GROUP BY customer_id
HAVING average_payment > 4
ORDER BY average_payment DESC;

SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > 100
ORDER BY total_spent DESC;

SELECT COUNT(*) AS high_value_customers
FROM (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 100
) AS high_value;
