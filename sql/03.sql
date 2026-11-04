/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */
SELECT country, sum(amount) AS total_payments
FROM payment
JOIN rental USING (rental_id)
JOIN customer ON rental.customer_id = customer.customer_id
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)
GROUP BY country
ORDER BY total_payments DESC;
