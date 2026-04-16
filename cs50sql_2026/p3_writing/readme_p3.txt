Create, Read, Update, Delete. INSERT INTO. CSVs. .import. DELETE FROM. Foreign Key Constraints. UPDATE. Triggers. Soft Deletions.


### repeat from before - use .read
use .read to use a schema.sql file to tables inside of file.db


### use INSERT to add data in table
INSERT INTO "collections" ("id", "title", "accession_number", "acquired")   --> specifies columns to write value to |  NOTE "id" is primary key value
VALUE (1, 'Profusion of flowers', '56.257', '1956-04-12');                  --> values to write in columns

## primary key value can be left out - will be set in automatically
INSERT INTO "collections" ("title", "accession_number", "acquired")         --> specifies columns to write value to |  NOTE "id" is primary key value
VALUE ('Farmers working at dawn', '11.6152', '1911-08-03');                     --> values to write in columns

## insert identical values in columns that are set to 'UNIQUE' will raise an error; not data - even correct data will be inserted
## insert NULL values in columns that are set to 'NOT NULL' will raise an error; not data - even correct data will be inserted
## insert multable rows at ones with INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUE
('Spring outing', '14.76', '1914-01-08'),
('Profusion of flowers', '56.496', NULL),
('Peonies and butterfly', '06.1899', '1906-01-01');


### using csv files to insert data using ".import"
## with predefined table --> primary key is predefined or contained in file.csv as id
can be used with empty file.db that already has defined table or without predefined table
regular command structure '.import --csv --skip 1 filename.csv target_table_in_file.db'

## with predefined table --> no id data given in file.csv
1. create temporary tablke
    regular command structure '.import --csv filename.csv temp'
2. insert temp into collection
    INSERT INTO "collections" ("title", "accession_number", "acquired")
    SELECT "title", "accession_number", "acquired" FROM "temp";
3. drop temp table
    DROP TABLE "temp";

### DELETE rows using condition
regular command structure 'DELETE FROM table WHERE condition;'


### FOREIGN KEY constrains
if data is referenced between different tables it's kind of tricky to delet data the right way
1. delete affiliation / reference table (if one is used) --> reference table uses two or more foreign keys
    --> subquery is needed to delet correct row from reference table
2. delete data target row from desired table

if designing file.db a columns behaviour upon using DELETE can be specified e.g.
    FOREIGN KEY("artist_id") REFERENCES "artists"("id")
    ON DELETE RESTRICT --> if element it referenced, no deletion is possible
    ON DELETE NO ACTION --> if DELETE is used, nothing will happen
    ON DELETE SET NULL --> will set deleted value to NULL
    ON DELETE SET DEFAULT --> will set deleted value to the default value
    ON DELETE CASCADE --> will also delete every affiliation in other tables


### UPDATE reference columns using subqueries
regular command structure 'UPDATE table SET column0 = value0, ... WHERE condition;'
in order update referenced values you need to subqueries to update e.g.
UPDATE "created" SET "artist_id" = (
    SELECT "id" FROM "artists"
    WHERE "name" = 'Li Yin'
)
WHERE "collection_id" = (
    SELECT "id" FROM "collections"
    WHERE "title" = 'Farmers working at dawn'
);

if data from file.csv needs to be cleaned, sqlite3 can be used to some extend
a. trim spaces in data
  
    UPDATE "votes" SET "title" = trim("title");
b. set everything to upper or lower case
    UPDATE "votes" SET "title" = upper("title");
c. correcting some misspelling without using LIKE
    UPDATE "votes" SET "title" = 'FARMERS WORKING AT DAWN'
    WHERE "title" = 'FARMERS WORKING';
d. better version of c. using LIKE
    UPDATE "votes" SET "title" = 'FARMERS WORKING AT DAWN'
    WHERE "title" LIKE 'Fa%';

### TRIGGER
can be used to implement automatic update of tables within a file.db upon creation
regular command structure
    CREATE TRIGGER name
    BEFORE DELETE ON table
    FOR EACH ROW
    BEGIN
        ...;
    END;

eg auto-update using triggers
the follwing triggers will be added when executing .read in a schema.sql
CREATE TRIGGER "sell"
BEFORE DELETE ON "collections"
FOR EACH ROW
BEGIN
    INSERT INTO "transactions" ("title", "action")
    VALUE (OLD."title", 'sold'); --> OLD.something means to keep original value
END;

CREATE TRIGGER "buy"
AFTER INSERT ON "collections"
FOR EACH ROW
BEGIN
    INSERT INTO "transactions" ("title", "action")
    VALUE (NEW."title", 'brought'); --> NEW.something means to insert title
END;

## when using soft-deletion a row is not deleted, instead a column 'deleted' is set from 0 to 1 or from true to false depending in implementation
using this technic one always need to considere regulation like "right to be forgotten" or user private data regimes
