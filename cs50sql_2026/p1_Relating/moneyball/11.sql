/*
You need a player that can get hits. Who might be the most underrated?
In 11.sql,
write a SQL query to find the 10 least expensive players per hit in 2001.

Your query should return a table with three columns,
    one for the players’ first names,
    one of their last names, and
    one called “dollars per hit”.

You can calculate the “dollars per hit” column by
    dividing a player’s 2001 salary
    by the number of hits they made in 2001.
Recall you can use AS to rename a column.
Dividing a salary by 0 hits will result in a NULL value.
    Avoid the issue by filtering out players with 0 hits.

Sort the table by the “dollars per hit” column,
    least to most expensive.
    If two players have the same “dollars per hit”, order by
    first name, followed by last name, in alphabetical order.
As in 10.sql, ensure that the salary’s year and the performance’s year match.
You may assume, for simplicity,
that a player will only have one salary and one performance in 2001.
*/

/*
-- cal. AVG(salary) per player in 2001
SELECT AVG(sa.salary), sa.year, pl.id
FROM salaries AS sa
JOIN players AS pl
ON pl.id = sa.player_id
WHERE sa.year = 2001
AND pl.id IN (2234, 9320, 15912)
GROUP BY pl.id
ORDER BY pl.id DESC
LIMIT 5
;

-- cal. number of hits in 2001 per player
SELECT pf.H, pf.year, pl.id
FROM performances AS pf
JOIN players AS pl
ON pl.id = pf.player_id
WHERE pf.year = 2001
AND pf.H != 0
AND pl.id IN (2234, 9320, 15912)
ORDER BY pl.id DESC
LIMIT 5
;
*/

SELECT
    pl.first_name,
    pl.last_name,
    (sa.salary/pf.H) AS "dollars per hit"
FROM players AS pl
JOIN salaries AS sa
ON sa.player_id = pl.id
JOIN performances AS pf
ON pf.player_id = pl.id
AND pf.year = sa.year
WHERE sa.year = 2001
-- AND pf.H != 0
AND pf.H > 0
GROUP BY pl.id
ORDER BY
    "dollars per hit" ASC,
    pl.first_name ASC,
    pl.last_name ASC
LIMIT 10
;
