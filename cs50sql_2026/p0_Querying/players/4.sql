/*
In 4.sql, write a SQL query to find the first and last names of players who were not born in the United States.
Sort the results alphabetically by first name, then by last name.
Executing 4.sql results in a table with 2 columns and 2814 rows.
*/

SELECT "first_name", "last_name" FROM "players"
WHERE "birth_country" <> 'USA'
ORDER BY "first_name" ASC, "last_name" ASC
;

/*
SELECT COUNT("first_name") FROM "players"
WHERE "birth_country" <> 'USA'
;
*/
