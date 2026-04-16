-- In 4.sql, write a query to find the titles of episodes that do not yet have a listed topic.
SELECT "title" FROM "episodes" WHERE "topic" IS NULL;
-- SELECT COUNT("title") AS "sum all topics" FROM "episodes";
-- SELECT COUNT("title") AS "sum topic is NULL" FROM "episodes" WHERE "topic" IS NULL;
-- SELECT COUNT("title") AS "sum topic is not NULL" FROM "episodes" WHERE "topic" IS NOT NULL;
-- SELECT COUNT("title") FROM "episodes" WHERE "topic" IS NULL;
-- should result in a table with 1 column and 26 rows.
