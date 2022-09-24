-- first run create_mavenmovies.sql from database_script folder to create the database in your MySQL

use mavenmovies;

-- 1. How many payments did each staff member handle?

SELECT staff_id, COUNT(payment_id) AS 'Payment_ID', SUM(amount) 'Total Amount' 
FROM payment 
GROUP BY staff_id;

-- 2. What is the average replacement cost per rating?

SELECT rating, round(avg(replacement_cost),2) AS 'Average of Rep_cost' 
FROM film 
GROUP BY rating;

-- 3. What are the customer ids of the top 5 customers by total spend

SELECT customer_id, SUM(amount) AS 'Amount Spended' 
FROM payment 
GROUP BY customer_id 
ORDER BY SUM(amount) 
DESC LIMIT 5;

-- 4. Customer_ids of the customers who have 40 or more transactions?

SELECT customer_id, COUNT(payment_id) AS 'No of payment done' 
FROM payment 
GROUP BY customer_id 
HAVING COUNT(payment_id) >= 40 
ORDER BY 2 
DESC; 

-- 5. What are the customer ids of customers who have spent more than $100 in payment transactions with our staff_id member 2?

SELECT customer_id, SUM(amount) AS 'Amount' 
FROM payment 
WHERE staff_id = 2 
GROUP BY customer_id 
HAVING SUM(amount)>100 
ORDER BY 2 
DESC;
