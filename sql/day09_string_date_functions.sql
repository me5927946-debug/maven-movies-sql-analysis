
-- ============================================
-- Maven Movies SQL Analysis
-- Day 9: String and Date Functions
-- ============================================

USE mavenmovies;

-- Exercise 1: Combine customer names and uppercase first names
SELECT
    customer_id,
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name,
    UPPER(first_name) AS first_name_upper
FROM customer;

-- Exercise 2: Find films containing LOVE
SELECT
    film_id,
    title,
    LENGTH(title) AS title_length
FROM film
WHERE title LIKE '%LOVE%'
ORDER BY title_length DESC;

-- Exercise 3: Clean titles and convert to lowercase
SELECT
    film_id,
    title,
    TRIM(title) AS clean_title,
    LOWER(title) AS title_lower
FROM film;

-- Exercise 4: Extract the first three and last two characters
SELECT
    film_id,
    title,
    SUBSTRING(title, 1, 3) AS first_three_letters,
    RIGHT(title, 2) AS last_two_letters
FROM film;

-- Exercise 5: Extract year and month from rental dates
SELECT
    rental_id,
    rental_date,
    YEAR(rental_date) AS rental_year,
    MONTH(rental_date) AS rental_month
FROM rental;

-- Exercise 6: Count rentals per month across all years
SELECT
    MONTH(rental_date) AS rental_month,
    COUNT(*) AS rental_count
FROM rental
GROUP BY MONTH(rental_date)
ORDER BY rental_month ASC;

-- Exercise 7: Count rentals per year and month
SELECT
    YEAR(rental_date) AS rental_year,
    MONTH(rental_date) AS rental_month,
    COUNT(*) AS rental_count
FROM rental
GROUP BY YEAR(rental_date), MONTH(rental_date)
ORDER BY rental_year ASC, rental_month ASC;

-- Exercise 8: Find rentals during July 2005
SELECT
    rental_id,
    rental_date,
    customer_id
FROM rental
WHERE rental_date >= '2005-07-01'
  AND rental_date < '2005-08-01'
ORDER BY rental_date ASC;

-- Exercise 9: Count rentals per year
SELECT
    YEAR(rental_date) AS rental_year,
    COUNT(*) AS rental_count
FROM rental
GROUP BY YEAR(rental_date)
ORDER BY rental_count DESC;
