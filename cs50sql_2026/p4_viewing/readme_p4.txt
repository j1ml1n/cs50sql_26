viewing databases with SQL
goal simplify reading file.db
View: A virtual table defined by a query

# use longlist.db for this lecture
# interation to get 2 column table
-- SELECT "id" FROM "authors" WHERE "name" = 'Frernanda Melchor';
-- SELECT "book_id" FROM "authored" WHERE "author_id" = (
--    SELECT "id" FROM "authors"
--    WHERE "name" = 'Frernanda Melchor');
SELECT "title" FROM "books"
WHERE "id" IN (
    SELECT "book_id" FROM "authored"
    WHERE "author_id" = (
        SELECT "id" FROM "authors"
        WHERE "name" = 'Frernanda Melchor'
    )
);

# BETTER do something else:
SELECT "name", "title" FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "books"."id" = "authored"."book_id";
# ATTENTION: a view is more-less just a safed query
# VIEWs hold no data themself, that's why u can not update them
# you can only update the data below

# What if you want to creat a View as part of your schema?
# do the following
CREATE VIEW "longlist" AS
SELECT "name", "title" FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "books"."id" = "authored"."book_id";

# in order to use the VIEW "longlist", just use basic SQL
SELECT * FROM "longlist" WHERE "name" LIKE 'Melchor';
# you can even use ORDER BY or something else

# Aggregation of Data with VIEW
CREATE VIEW "average_book_ratings" AS
SELECT "book_id", "title", "year", ROUND(AVG("rating), 2) AS "rating"
FROM "ratings"
JOIN "books" ON "ratings","book_id" = "books"."id"
GROUP BY "book_id";

# VIEWs are stored in the file.db by default
# in order to use temporary view do the following
CREATE TEMPORARY VIEW "avg_rating_by_year" AS
SELECT "year", ROUND(AVG("rating"), 2) AS "rating"
FROM "avg_book_ratings"
GROUP BY "year";
# this temp view can be queried like a normal view
# temp views are not stored in file.db

# Common Table Expression (CTE)
# a VIEW that only exists for a SINGLE query
# simply said, it's even more temp then temp view
WITH name AS (
    SELECT ...
), ...
SELECT ... FROM name;
eg
WITH "avg_book_ratings" AS (
    SELECT "book_id", "title", "year", ROUND(ACG("rating"), 2) AS "rating"
    FROM "ratings"
    JOIN "books" ON "ratings"."book_id" = "books"."id"
    GROUP BY "book_id"
)
SELEC "year", ROUND(AVG("rating"), 2) AS "rating"
FROM "avg_book_ratings"
GROUP BY "year";

# split data into logical pieces using Partitioning
# with VIEWs
CREATE VIEW "2021" AS
SELECT "id", "title" FROM "books"
WHERE "year" = 2021;

# use VIEWs for security architectur - need to know princip
# example remove pii - personal identifiable information
# eg we have a table with columns id, origin, destination, rider
# in order to not give pii to someone we should anonymize the data
# and give a hint that we did this to indicate that the set was altered
# good for traceability and legal reasons. Do somethign like this with
CREATE VIEW "analysis" AS
SELECT "id", "origin", "destination", 'Anonymous' AS "rider"
FROM "rides";
# ALL values in "rider" will be displayed as 'Anonymous'
# but were NOT overritten
# in other SQL-world one could set ACCESS rules
# so that people only can access a certain table

# hpw to use SOFT DELETIONS
# if soft deletion is used, a VIEW could be used to only show none-delete data to a user
CREATE VIEW "current_collections"
SELECT * FROM "colletions"
WHERE "deleted" = 0;

# Use Triggers with VIEWs
# since we can't UPDATE VIEWs, only the data we need to use triggers
# eg
CREATE TRIGGER name
INSTEAD OF DELETE ON vieww
FOR EACH ROW
BEGIN
    ...;
END;

CREATE TRIGGER "delete"
INSTEAD OF DELETE ON "current_collections"
FOR EACH ROW
BEGIN
    UPDATE "collections" SET "deleted" = 1
    WHERE "id" = OLD."id" -- OLD is a keyword == lastSelectedObject
END;

# de-delete soft-deletion
CREATE TRIGGER "insert_when_exists"
INSTEAD OF INSERT ON "current_collections"
FOR EACH ROW
WHEN NEW."accession_number" IN (
    SELECT "accession_number" FROM "collections"
)
BEGIN
    UPDATE "collections" SET "deleted" = 0
    WHERE "accession_number" = NEW."accession_number"
END;


CREATE TRIGGER "insert_when_exists"
INSTEAD OF INSERT ON "current_collections"
FOR EACH ROW
WHEN NEW."accession_number" IN (
    SELECT "accession_number" FROM "collections"
)
BEGIN
    UPDATE "collections" SET "deleted" = 0
    WHERE "accession_number" = NEW."accession_number"
END;
