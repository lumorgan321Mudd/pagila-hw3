/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
WITH recent_rentals AS (
    SELECT r.customer_id,
           f.title,
           c.name AS category,
           row_number() OVER (PARTITION BY r.customer_id ORDER BY r.rental_date DESC) AS rn
    FROM rental r
    JOIN inventory i USING (inventory_id)
    JOIN film f USING (film_id)
    JOIN film_category fc USING (film_id)
    JOIN category c USING (category_id)
)
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN recent_rentals rr ON c.customer_id = rr.customer_id
WHERE rr.rn <= 5
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING count(*) FILTER (WHERE rr.category = 'Action') >= 4
ORDER BY c.customer_id;
