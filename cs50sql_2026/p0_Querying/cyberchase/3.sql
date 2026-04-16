-- In 3.sql, find the production code for the episode “Hackerized!”.
SELECT "production_code" FROM "episodes" WHERE "title" = "Hackerized!";
-- SELECT COUNT("production_code") FROM "episodes" WHERE "title" = "Hackerized!";
-- shoudl result in a table with 1 column and 1 row.
