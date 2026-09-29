-- ============================================
-- Maven Movies SQL Analysis
-- Day 3: SQL Basics
-- ============================================

USE mavenmovies;


-- 1. Number of customers named JAMES
SELECT COUNT(*) AS james_customers
FROM customer
WHERE first_name = 'JAMES';


-- 2. Active customers named MARY
SELECT COUNT(*) AS active_mary_customers
FROM customer
WHERE active = 1
  AND first_name = 'MARY';


-- 3. Films with rental rate of $0.99
SELECT COUNT(*) AS films_099
FROM film
WHERE rental_rate = 0.99;


-- 4. Films with rental rate of $4.99
SELECT COUNT(*) AS films_499
FROM film
WHERE rental_rate = 4.99;


-- 8. Inactive customers
SELECT COUNT(*) AS inactive_customers
FROM customer
WHERE active = 0;


-- Customer activity summary
SELECT
    COUNT(CASE WHEN active = 1 THEN 1 END) * 100.0 / COUNT(*) 
        AS active_percentage
FROM customer;
SELECT DISTINCT COUNT(*)
FROM country;
