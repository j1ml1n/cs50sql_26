/*
6.sql DESE wants to assess which schools achieved a 100% graduation rate.
In 6.sql, write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.
*/

/*
SELECT
s."name" AS "School name",
s."city" AS "City name",
s."type",
g."graduated" AS "% graduates"
FROM graduation_rates AS g
LEFT JOIN schools AS s
ON s."id" = g."school_id"
WHERE g."graduated" IS 100
*/

SELECT
s."name"
FROM graduation_rates AS g
LEFT JOIN schools AS s
ON s."id" = g."school_id"
WHERE g."graduated" IS 100
