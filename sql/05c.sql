/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film
        WHERE title IN ('ACADEMY DINOSAUR', 'AGENT TRUMAN', 'AMERICAN CIRCUS')
    )
)
GROUP BY f.title
HAVING count(DISTINCT fa.actor_id) >= 3
ORDER BY f.title;
