/*
It’s a bit of a slow day in the office. Though Satchel no longer plays, in 5.sql, write a SQL query to find all teams that Satchel Paige played for.

Your query should return a table with a single column, one for the name of the teams.
*/


SELECT DISTINCT t.name
FROM teams t
JOIN performances p ON p.team_id = t.id
JOIN players pl ON pl.id = p.player_id
WHERE pl.first_name = 'Satchel'
AND pl.last_name  = 'Paige';


/*
SELECT name FROM teams
WHERE id IN (
    SELECT team_id
    FROM performances
    INTERSECT
    SELECT team_id
    FROM performances
    WHERE player_id IN (
        SELECT id FROM players
        WHERE first_name = 'Satchel'
          AND last_name = 'Paige'
    )
)
;
*/

/*
SELECT name
FROM teams
WHERE id IN (
    SELECT team_id FROM performances
    INTERSECT
    SELECT p.team_id
    FROM performances p
    JOIN players pl ON pl.id = p.player_id
    WHERE pl.first_name = 'Satchel'
      AND pl.last_name = 'Paige'
);
*/
