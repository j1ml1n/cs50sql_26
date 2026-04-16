/*
In 1.sql, write a SQL query to find the hometown (including city, state, and country) of Jackie Robinson.
Executing 1.sql results in a table with 3 columns and 1 row.
*/

SELECT "birth_city", "birth_state", "birth_country" FROM "players"
WHERE "first_name" IS 'Jackie' AND "last_name" IS 'Robinson'
;
