-- in order for '.read 1.sql' to work, you need to run 'sqlite3 file.db' before
-- In 1.sql, write a SQL query to list the titles of all episodes in Cyberchase’s original season, Season 1.
SELECT "title" FROM "episodes" WHERE "season" IS '1';
-- SELECT COUNT("title") FROM "episodes" WHERE "season" IS '1';
-- shoudl result in a table with 1 column and 26 rows.
