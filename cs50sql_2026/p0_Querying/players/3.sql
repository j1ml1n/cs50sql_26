/*
In 3.sql, write a SQL query to find the ids of rows for which a value in the column debut is missing.
 Executing 3.sql results in a table with 1 column and 213 rows
*/

SELECT "id" FROM "players"
WHERE "debut" IS NULL
;

/*
SELECT COUNT("id") FROM "players"
WHERE "debut" IS NULL
;
*/
