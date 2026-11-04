/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
WITH movie_rentals AS (
    SELECT r.customer_id,
           f.film_id,
           max(r.rental_date) AS last_rental,
           bool_or(c.name = 'Action') AS is_action
    FROM rental r
    JOIN inventory i USING (inventory_id)
    JOIN film f USING (film_id)
    JOIN film_category fc USING (film_id)
    JOIN category c USING (category_id)
    GROUP BY r.customer_id, f.film_id
),
ranked AS (
    SELECT customer_id,
           is_action,
           row_number() OVER (PARTITION BY customer_id ORDER BY last_rental DESC) AS rn
    FROM movie_rentals
)
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN ranked rr ON c.customer_id = rr.customer_id
WHERE rr.rn <= 5
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING sum(CASE WHEN rr.is_action THEN 1 ELSE 0 END) >= 4
ORDER BY c.customer_id;
