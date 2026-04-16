/*
In 2.sql, write a SQL query to find the side (e.g., right or left) Babe Ruth hit.
Executing 2.sql results in a table with 1 column and 1 row.
*/

SELECT "bats" FROM "players"
WHERE "first_name" IS 'Babe' AND "last_name" IS 'Ruth'
;
