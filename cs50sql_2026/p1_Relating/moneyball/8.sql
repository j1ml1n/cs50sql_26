/*
How much would the A’s need to pay to get
the best home run hitter this past season?
In 8.sql, write a SQL query to find
    the 2001 salary
    of the player
    who hit the most home runs
    in 2001.

Your query should return a table with
one column, the salary of the player.
*/

/*
SELECT sa.salary
FROM performances AS pf
JOIN salaries AS sa
  ON sa.player_id = pf.player_id
 AND sa.year = pf.year
WHERE pf.year = 2001
ORDER BY pf.HR DESC
LIMIT 1;
*/

SELECT
sa.salary
FROM players AS pl
JOIN performances AS pf
ON pf.player_id = pl.id
JOIN salaries AS sa
ON sa.player_id = pl.id
WHERE sa.year = 2001
AND pf.year = 2001
AND pf.HR = (
    SELECT MAX(HR)
    FROM performances
    WHERE year = 2001
)
;
