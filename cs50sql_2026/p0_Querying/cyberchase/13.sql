-- In 13.sql, write a SQL query to explore a question of your choice. This query should:
-- Involve at least one condition, using WHERE with AND or OR
-- SELECT "title", "air_date" FROM "episodes" WHERE "title" LIKE 'A %' OR "title" LIKE '%cyber%' ORDER BY "air_date" ASC;
-- SELECT COUNT("title") FROM "episodes" WHERE "title" LIKE 'A %' OR "title" LIKE '%cyber%' ORDER BY "air_date" ASC;

-- feeling comfortable
-- 1. Write a SQL query to find the titles of episodes that have aired during the holiday season, usually in December in the United States.
-- Your query should output a table with a single column for the title of each episode.
-- Try to find a better solution than LIKE if you can!
SELECT "title" AS "title comfi 1.1", "air_date"  FROM "episodes" WHERE "air_date" LIKE '20__-12-__';


-- feeling comfortable
-- 2. Write a SQL query to find, for each year, the first day of the year that PBS released a Cyberchase episode.
-- Your query should output a table with two columns, one for the year and one for the earliest month and day an episode was released that year.
-- SELECT "title" AS "title comfi 2.1", "air_date"  FROM "episodes" WHERE "air_date" LIKE '20__-12-__';
