USE mavenmovies;

SELECT
    YEAR(payment_date) AS payment_year,
    MONTH(payment_date) AS payment_month,
    COUNT(*) AS payment_count,
    SUM(amount) AS monthly_revenue
FROM payment
GROUP BY
    YEAR(payment_date),
    MONTH(payment_date)
ORDER BY monthly_revenue DESC
LIMIT 1;

SELECT
    SUM(CASE
        WHEN YEAR(payment_date) = 2005
         AND MONTH(payment_date) = 7
        THEN amount
        ELSE 0
    END) AS july_2005_revenue,

    SUM(amount) AS total_revenue,

    100.0 * SUM(CASE
        WHEN YEAR(payment_date) = 2005
         AND MONTH(payment_date) = 7
        THEN amount
        ELSE 0
    END) / SUM(amount) AS july_revenue_percentage

FROM payment;


SELECT
    YEAR(payment_date) AS payment_year,
    MONTH(payment_date) AS payment_month,
    COUNT(*) AS payment_count,
    SUM(amount) AS monthly_revenue,
    AVG(amount) AS average_payment
FROM payment
GROUP BY
    YEAR(payment_date),
    MONTH(payment_date)
ORDER BY
    payment_year,
    payment_month;
    
    

SELECT
    SUM(CASE
        WHEN YEAR(payment_date) = 2005
         AND MONTH(payment_date) = 7
        THEN amount
        ELSE 0
    END) AS july_2005_revenue,

    SUM(CASE
        WHEN YEAR(payment_date) = 2005
         AND MONTH(payment_date) = 6
        THEN amount
        ELSE 0
    END) AS june_2005_revenue,

    100.0 * (
        SUM(CASE
            WHEN YEAR(payment_date) = 2005
             AND MONTH(payment_date) = 7
            THEN amount
            ELSE 0
        END)
        -
        SUM(CASE
            WHEN YEAR(payment_date) = 2005
             AND MONTH(payment_date) = 6
            THEN amount
            ELSE 0
        END)
    ) / SUM(CASE
        WHEN YEAR(payment_date) = 2005
         AND MONTH(payment_date) = 6
        THEN amount
        ELSE 0
    END) AS percentage_inc_revenue

FROM payment;

    
