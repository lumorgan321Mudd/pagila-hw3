/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
WITH film_rentals AS (
    SELECT f.film_id, f.title, count(*) AS total_rentals
    FROM film f
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
    GROUP BY f.film_id, f.title
),
category_film_rentals AS (
    SELECT c.name,
           fr.title,
           fr.total_rentals,
           rank() OVER (PARTITION BY c.name ORDER BY fr.total_rentals DESC) AS rank
    FROM category c
    JOIN film_category fc USING (category_id)
    JOIN film_rentals fr USING (film_id)
)
SELECT name, title, total_rentals AS "total rentals"
FROM category_film_rentals
WHERE rank <= 5
ORDER BY name, rank;
