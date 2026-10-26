USE mavenmovies;

SELECT
    customer_id,
    SUM(amount) AS total_spent,
    ROW_NUMBER() OVER (
        ORDER BY SUM(amount) DESC
    ) AS customer_rank
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

SELECT
    customer_id,
    SUM(amount) AS total_spent,

    ROW_NUMBER() OVER (
        ORDER BY SUM(amount) DESC
    ) AS row_num,

    RANK() OVER (
        ORDER BY SUM(amount) DESC
    ) AS spending_rank,

    DENSE_RANK() OVER (
        ORDER BY SUM(amount) DESC
    ) AS dense_spending_rank

FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 15;

USE mavenmovies;

SELECT
    customer_id,
    SUM(amount) AS total_spent,

    SUM(SUM(amount)) OVER () AS total_revenue,

    100.0 * SUM(amount) /
        SUM(SUM(amount)) OVER () AS revenue_contribution_pct

FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

USE mavenmovies;

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
),

ranked_customers AS (
    SELECT
        customer_id,
        total_spent,
        ROW_NUMBER() OVER (
            ORDER BY total_spent DESC, customer_id ASC
        ) AS customer_rank
    FROM customer_spending
)

SELECT
    SUM(CASE
        WHEN customer_rank <= 10 THEN total_spent
        ELSE 0
    END) AS top_10_revenue,

    (SELECT SUM(amount)
     FROM payment) AS total_revenue,

    100.0 * SUM(CASE
        WHEN customer_rank <= 10 THEN total_spent
        ELSE 0
    END) / (SELECT SUM(amount) FROM payment)
        AS revenue_contribution_pct

FROM ranked_customers;


USE mavenmovies;

WITH customer_spending AS (
    SELECT
        c.store_id,
        c.customer_id,
        SUM(p.amount) AS total_spent
    FROM customer AS c
    INNER JOIN payment AS p
        ON c.customer_id = p.customer_id
    GROUP BY
        c.store_id,
        c.customer_id
),

ranked_customers AS (
    SELECT
        store_id,
        customer_id,
        total_spent,
        RANK() OVER (
            PARTITION BY store_id
            ORDER BY total_spent DESC
        ) AS store_rank
    FROM customer_spending
)

SELECT
    store_id,
    customer_id,
    total_spent,
    store_rank
FROM ranked_customers
WHERE store_rank <= 3
ORDER BY store_id, store_rank, customer_id;


USE mavenmovies;

WITH monthly_revenue AS (
    SELECT
        YEAR(payment_date) AS payment_year,
        MONTH(payment_date) AS payment_month,
        SUM(amount) AS monthly_revenue
    FROM payment
    GROUP BY
        YEAR(payment_date),
        MONTH(payment_date)
)

SELECT
    payment_year,
    payment_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY payment_year, payment_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue
FROM monthly_revenue
ORDER BY payment_year, payment_month;





