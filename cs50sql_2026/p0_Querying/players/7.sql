/*
In 7.sql, write a SQL query to count the number of players who bat (or batted) right-handed and throw (or threw) left-handed, or vice versa.
Executing 7.sql results in a table with 1 columns and 1 row.
*/

SELECT COUNT("id") FROM "players"
WHERE "bats" IS 'R' AND "throws" IS 'L'
OR "bats" IS 'L' AND "throws" IS 'R'
;
