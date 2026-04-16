-- 1. Any empty values in meteorites.csv are represented by NULL in the meteorites table.
    -- Keep in mind that the mass, year, lat, and long columns have empty values in the CSV.
    -- set '' to NULL
--UPDATE tmp SET "mass" = NULL WHERE "mass" = '';
--UPDATE tmp SET "year" = NULL WHERE "year" = '';
--UPDATE tmp SET "long" = NULL WHERE "long" = '';
--UPDATE tmp SET "lat" = NULL WHERE "lat" = '';


-- 2. All columns with decimal values (e.g., 70.4777) should be rounded to the nearest hundredths place (e.g., 70.4777 becomes 70.48).
    -- Keep in mind that the mass, lat, and long columns have decimal values.
UPDATE tmp SET "mass" = ROUND((
    SELECT "mass" FROM tmp
    WHERE "mass" LIKE "%.__%"
), 2)
WHERE "mass" LIKE "%.__%";

UPDATE tmp SET "lat" = ROUND((
    SELECT "lat" FROM tmp
    WHERE "lat" LIKE "%.__%"
), 2)
WHERE "lat" LIKE "%.__%";

UPDATE tmp SET "long" = ROUND((
    SELECT "long" FROM tmp
    WHERE "long" LIKE "%.__%"
), 2)
WHERE "long" LIKE "%.__%";

-- 3. All meteorites with the nametype “Relict” are not included in the meteorites table.


-- 4. The meteorites are sorted by year, oldest to newest, and then—if any two meteorites landed in the same year—by name, in alphabetical order.


-- 5. You’ve updated the IDs of the meteorites from meteorites.csv, according to the order specified in #4.
    -- The id of the meteorites should start at 1, beginning with the meteorite that landed in the oldest year and is the first in alphabetical order for that year.

