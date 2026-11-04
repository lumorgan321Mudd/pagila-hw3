/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH bacall1 AS (
    SELECT fa2.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2 USING (film_id)
    WHERE fa1.actor_id = (SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL')
      AND fa2.actor_id <> fa1.actor_id
),
bacall2 AS (
    SELECT fa2.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2 USING (film_id)
    WHERE fa1.actor_id IN (SELECT actor_id FROM bacall1)
      AND fa2.actor_id <> fa1.actor_id
)
SELECT (first_name || ' ' || last_name) AS "Actor Name"
FROM actor
WHERE actor_id IN (SELECT actor_id FROM bacall2)
  AND actor_id NOT IN (SELECT actor_id FROM bacall1)
  AND actor_id <> (SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL')
ORDER BY "Actor Name";
