/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
)
GROUP BY f.title
HAVING count(DISTINCT fa.actor_id) >= 2
ORDER BY f.title;
