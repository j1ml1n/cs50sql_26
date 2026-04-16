# reduce storage space & query exeTime
# on IMDb as e.g.
# +200K ratings,
# +400K movies,
# +1400K stars

# in sqlite3 use
.timer on -- to measure execution time

# searching a database can be done in ..
# scans --> complete file.db will be scanned
# after that the results are returned

# faster search can be archieved using index
# indexes will gain speed by using up more space
Index is a structure used to speed up
the retrieval of data sometimes up to +10times
# 1. search index for quicker finding
    CREATE INDEX name
    ON table (column0, ...);

CREATE INDEX "title_index"
ON "movies" ("title");

# check if an index is used by sqlite
EXPLAIN QUERY PLAN
SELECT * FROM "movies" WHERE "title" = 'Cars';

# remove index
DROP INDEX "title_index";

# create multi-table index
CREATE INDEX "person_index"
ON "stars" ("person_id");
CREATE INDEX "name_index"
ON "people" ("name");

# other tool to boost speed
Covering Index --> base. index with multiable infos
time saving can speed up by using more disk space
An index in which queried data can be
retrieved from the index itself

CREATE INDEX "person_index"
ON "stars" ("person_id", "movie_id")

# save some time but by using way less space
# use partial indexes
real indexes use binary-trees
so the tree itself and inserting is little tricky
so we trade speed for space; to flip this we have
Partial Index include only a subset of rows from a table
eg:
CREATE INDEX name
ON table (column0, ...)
WHERE condition;

CREATE INDEX "recents"
ON "movies" ("title")
WHERE "year" = 2023;

# save even more space with Vacuum
use terminal command 'du -b' to get size of a file.db
or any file for that matter
after deleting indexes, tables or views
use VACCUM; to realy set them free
will be dealocated in the system


# another trick to maintain concurrency in databases
# used when system is under a lot of traffic
Transaction is a unit of work in a database
helps with synchronize execution of consistan dataset at all time
like to updates on different rows at the same time
eg
BEGIN TRANSACTION;
UPDATE "accouts" SET "balance" = "balance" + 10
WHERE "id" = 2;
UPDATE "accouts" SET "balance" = "balance" - 10
WHERE "id" = 1;
ROLLBACK; --> when sqlite3 raises an error & to cancel transaction
COMMIT; --> to trigger actions


# TRANSACTIONs could be use to target hackers
# by guarding against Race Conditions

# in oder to lock data that is currently worked on use
Locks like 'UNLOCKED', 'SHARED', 'EXCLUSIVE' ...
BEGIN EXCLUSIVE TRANSACTION; in one terminal
if YOU open another terminal trying to work on the same file.db
this would not be possible
