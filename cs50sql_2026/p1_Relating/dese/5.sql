/*
DESE would like you to determine in what cities additional public schools might be needed.
In 5.sql, write a SQL query to find cities with 3 or fewer public schools.
Your query should return the names of the cities and the number of public schools within them,
ordered from greatest number of public schools to least.
If two cities have the same number of public schools, order them alphabetically.
*/

SELECT "city", COUNT("type") AS 'Number of schools'
FROM "schools"
WHERE "type" LIKE 'Public %'
GROUP BY "city"
HAVING COUNT("type") <= 3
ORDER BY COUNT("type") DESC, "city" ASC
