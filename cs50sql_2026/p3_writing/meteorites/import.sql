-- importing meteorites.csv into a temporary table
    --CREATE TABLE tmp (
    --    "name" TEXT, "id" NUMERIC, "nametype" TEXT, "class" TEXT, "mass" NUMERIC,
    --    "discovery" TEXT, "year" NUMERIC, "lat" NUMERIC, "long" NUMERIC );
-- creationg a table to import data into is optinal
-- just use ".import --csv meteorites.csv tmp" instead & tmp will be created automatically
.import --csv meteorites.csv tmp

-- 1. Any empty values in meteorites.csv are represented by NULL in the meteorites table.
    -- Keep in mind that the mass, year, lat, and long columns have empty values in the CSV.
    -- set '' to NULL
-- v1.0
        -- UPDATE tmp SET "mass" = NULL WHERE "mass" = '';
        -- UPDATE tmp SET "year" = NULL WHERE "year" = '';
        -- UPDATE tmp SET "long" = NULL WHERE "long" = '';
        -- UPDATE tmp SET "lat" = NULL WHERE "lat" = '';
-- v2.0
UPDATE tmp SET
    "mass" = NULLIF("mass", ''),
    "year" = NULLIF("year", ''),
    "long" = NULLIF("long", ''),
    "lat"  = NULLIF("lat", '')
WHERE "mass" = ''
  OR "year" = ''
  OR "long" = ''
  OR "lat"  = '';

-- 2. All columns with decimal values (e.g., 70.4777) should be rounded to the nearest hundredths place (e.g., 70.4777 becomes 70.48).
    -- Keep in mind that the mass, lat, and long columns have decimal values.
-- v1.0
    -- UPDATE "meteorites_temp"
    -- SET "lat" = ( SELECT ROUND("lat", 2) FROM "meteorites_temp")
    -- WHERE "id" IN (SELECT "id" FROM "meteorites_temp" WHERE "lat" != ROUND("lat", 2));

-- v2.0
    -- UPDATE tmp SET "mass" = ROUND(
    --     (SELECT "mass" FROM tmp WHERE "mass" LIKE "%.__%"), 2)
    -- WHERE "mass" LIKE "%.__%";

-- v3.0
UPDATE tmp SET
"mass" = ROUND(CAST("mass" AS REAL), 2),
"lat" = ROUND(CAST("lat" AS REAL), 2),
"long" = ROUND(CAST("long" AS REAL), 2)
WHERE "mass" IS NOT NULL
OR "lat" IS NOT NULL
OR "long" IS NOT NULL;

-- 3. All meteorites with the nametype “Relict” are not included in the meteorites table.
DELETE FROM tmp WHERE "nametype" = "Relict";
-- alternativ: use WHERE "nametype" != "Relcit" when inserting into meteorites

-- 4. The meteorites are sorted by year, oldest to newest, and then—if any two meteorites landed in the same year—by name, in alphabetical order.
-- 5. You’ve updated the IDs of the meteorites from meteorites.csv, according to the order specified in #4.
    -- The id of the meteorites should start at 1, beginning with the meteorite that landed in the oldest year and is the first in alphabetical order for that year.
CREATE TABLE meteorites (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL--,
    --PRIMARY KEY("id")
    );

INSERT INTO meteorites
("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT
"name", "class", "mass", "discovery", "year", "lat", "long"
FROM tmp
-- WHERE "nametype" != "Relict"
ORDER BY
"year" ASC, -- oldes to newest
"name" ASC; -- alphabetical order

-- DROP TABLE tmp;
