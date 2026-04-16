/*
Hits are great, but so are RBIs!
In 12.sql, write a SQL query to find the players among
the 10 least expensive players per hit and
among the 10 least expensive players per RBI in 2001.

Your query should return a table with two columns,
    one for the players’ first names and
    one of their last names.

You can calculate a player’s salary per RBI
    by dividing their 2001 salary by their number of RBIs in 2001.
You may assume, for simplicity,that a player
    will only have
    one salary and
    one performance in 2001.
Order your results by player ID,
least to greatest (or alphabetically by last name, as both are the same
in this case!). Keep in mind the lessons you’ve learned in 10.sql and 11.sql!
*/

/*
-- least expensive players per hit in 2001
-- with salaries & performance
SELECT sa.player_id
FROM salaries AS sa
JOIN performances AS pf
ON pf.player_id = sa.player_id
AND pf.year = sa.year
WHERE sa.year = 2001
-- used to exclude 0 hits
AND pf.H > 0
ORDER BY
-- cal expense by Hit
(sa.salary/pf.H),
sa.player_id ASC
LIMIT 10
;
*/


-- least expensive players per RBI in 2001
-- with salaries & performance
/*
SELECT RBI FROM performances
WHERE RBI > 0
ORDER BY RBI ASC
LIMIT 5;

SELECT sa.player_id
FROM salaries AS sa
JOIN performances AS pf
ON pf.player_id = sa.player_id
AND pf.year = sa.year
WHERE sa.year = 2001
-- used to exclude RBI of NULL and 0
AND pf.RBI > 0
ORDER BY
-- cal expense by RBI
(sa.salary/pf.RBI),
sa.player_id ASC
LIMIT 10
;
--*/

/*
-- using INTERSECT to solve
-- checker said to many statements at once
WITH
least_per_hit AS (
    SELECT s.player_id
    FROM salaries s
    JOIN performances pf
      ON pf.player_id = s.player_id
     AND pf.year = s.year
    WHERE s.year = 2001
      AND pf.H > 0
    ORDER BY (1.0 * s.salary / pf.H) ASC, s.player_id ASC
    LIMIT 10
),
least_per_rbi AS (
    SELECT s.player_id
    FROM salaries s
    JOIN performances pf
      ON pf.player_id = s.player_id
     AND pf.year = s.year
    WHERE s.year = 2001
      AND pf.RBI > 0
    ORDER BY (1.0 * s.salary / pf.RBI) ASC, s.player_id ASC
    LIMIT 10
)
SELECT first_name, last_name
FROM players
WHERE id IN (
    SELECT player_id FROM least_per_hit
    INTERSECT
    SELECT player_id FROM least_per_rbi
)
ORDER BY id ASC;
*/

-- using WITH statement to solve
-- if calculation seems to be off, try using 'n * 1.0' to cast float-division
WITH
least_per_hit AS (
    SELECT p.id
    FROM players p
    JOIN salaries s
      ON s.player_id = p.id
    JOIN performances pf
      ON pf.player_id = p.id
     AND pf.year = s.year
    WHERE s.year = 2001
      AND pf.H > 0
    ORDER BY (s.salary/pf.H) ASC, p.id ASC
    LIMIT 10
),
least_per_rbi AS (
    SELECT p.id
    FROM players p
    JOIN salaries s
      ON s.player_id = p.id
    JOIN performances pf
      ON pf.player_id = p.id
     AND pf.year = s.year
    WHERE s.year = 2001
      AND pf.RBI > 0
    ORDER BY (s.salary/pf.RBI) ASC, p.id ASC
    LIMIT 10
)
SELECT p.first_name, p.last_name
FROM players p
WHERE p.id IN (SELECT id FROM least_per_hit)
  AND p.id IN (SELECT id FROM least_per_rbi)
ORDER BY p.id ASC;
