-- In 5.sql, find the title of the holiday episode that aired on December 31st, 2004.
-- SELECT COUNT("title") FROM "episodes" WHERE "air_date" = '2004-12-31';
SELECT "title" FROM "episodes" WHERE "air_date" = '2004-12-31';
-- should result in a table with 1 column and 1 row.
