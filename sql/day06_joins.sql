-- ============================================
-- Maven Movies SQL Analysis
-- Day 6: JOINs
-- ============================================

USE mavenmovies;


-- Exercise 1: Customer + Address
SELECT
    customer_id,
    first_name,
    city_id
FROM customer
INNER JOIN address
    ON customer.address_id = address.address_id;


-- Exercise 2: Customer + Address + City
SELECT
    customer.customer_id,
    customer.first_name,
    city.city
FROM customer
INNER JOIN address
    ON customer.address_id = address.address_id
INNER JOIN city
    ON address.city_id = city.city_id;


-- Exercise 3: Customer + Address + City + Country
SELECT
    c.customer_id,
    c.first_name,
    ci.city,
    cu.country
FROM customer AS c
INNER JOIN address AS a
    ON c.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS cu
    ON ci.country_id = cu.country_id;


-- Exercise 4: Number of customers per country
SELECT
    cu.country,
    COUNT(c.customer_id) AS customer_count
FROM customer AS c
INNER JOIN address AS a
    ON c.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS cu
    ON ci.country_id = cu.country_id
GROUP BY cu.country
ORDER BY customer_count DESC;


-- Exercise 5: Countries with more than 20 customers
SELECT
    cu.country,
    COUNT(c.customer_id) AS customer_count
FROM customer AS c
INNER JOIN address AS a
    ON c.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS cu
    ON ci.country_id = cu.country_id
GROUP BY cu.country
HAVING customer_count > 20
ORDER BY customer_count DESC;


-- Exercise 7: Number of customers per city
SELECT
    COUNT(c.customer_id) AS customer_count,
    ci.city
FROM customer AS c
INNER JOIN address AS a
    ON c.address_id = a.address_id
INNER JOIN city AS ci
    ON ci.city_id = a.city_id
GROUP BY ci.city
ORDER BY customer_count DESC;


-- Exercise 8: Revenue by country
SELECT
    SUM(p.amount) AS total_revenue,
    cu.country
FROM customer AS c
INNER JOIN address AS a
    ON c.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS cu
    ON ci.country_id = cu.country_id
INNER JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY cu.country
ORDER BY total_revenue DESC;
