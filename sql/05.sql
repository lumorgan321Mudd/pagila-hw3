/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
)
ORDER BY f.title;
