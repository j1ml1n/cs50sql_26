/*
Some cities have more public schools than others.
In 4.sql, write a SQL query to find the 10 cities with the most public schools.
Your query should return the names of the cities and the number of public schools within them,
ordered from greatest number of public schools to least.
If two cities have the same number of public schools, order them alphabetically.
*/


-- version with short db-names
SELECT "city", COUNT("city") AS 'Number ob schools' FROM schools
WHERE "type" LIKE 'Public %'
GROUP BY "city"
ORDER BY COUNT("city") DESC, "city" ASC
LIMIT 10;

/*
SELECT districts."city", COUNT(schools."type") AS 'Number of public schools'
FROM districts
JOIN schools ON districts."id" = schools."district_id"
WHERE schools."type" LIKE "Public %"
GROUP BY districts."city"
ORDER BY COUNT(schools."type") DESC, districts."city" ASC
LIMIT 10;
*/
