/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */
SELECT (first_name || ' ' || last_name) AS "Actor Name"
FROM actor
WHERE actor_id IN (
    SELECT fa2.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2 USING (film_id)
    WHERE fa1.actor_id = (SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL')
      AND fa2.actor_id <> fa1.actor_id
)
ORDER BY first_name, last_name;
