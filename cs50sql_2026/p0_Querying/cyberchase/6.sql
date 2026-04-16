-- In 6.sql, list the titles of episodes from season 6 (2008) that were released early, in 2007.
SELECT "title" FROM "episodes" WHERE "season" = 6 AND "air_date" <= '2007-__-__';
-- should result in a table with 1 column and 2 rows.
