SELECT
    revenue_summary.top_10_revenue,
    revenue_summary.total_revenue,
    100.0 * revenue_summary.top_10_revenue
        / revenue_summary.total_revenue
        AS top_10_revenue_percentage
FROM (
    SELECT
        (
            SELECT SUM(top10.total_spent)
            FROM (
                SELECT
                    customer_id,
                    SUM(amount) AS total_spent
                FROM payment
                GROUP BY customer_id
                ORDER BY total_spent DESC
                LIMIT 10
            ) AS top10
        ) AS top_10_revenue,

        (
            SELECT SUM(amount)
            FROM payment
        ) AS total_revenue
) AS revenue_summary;


SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT
            customer_id,
            SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
)
ORDER BY total_spent DESC;

SELECT COUNT(*) AS above_average_customer_count
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > (
        SELECT AVG(customer_totals.total_spent)
        FROM (
            SELECT
                customer_id,
                SUM(amount) AS total_spent
            FROM payment
            GROUP BY customer_id
        ) AS customer_totals
    )
) AS above_average_customers;


