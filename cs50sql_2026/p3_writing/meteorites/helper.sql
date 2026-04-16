-- check for empty values ('')
SELECT
    -- SUM("name"      = '') AS "name_''",
    --SUM("id"        = '') AS "id_''",
    --SUM("class"     = '') AS "class_''",
    SUM("mass"      = '') AS "mass_''",
    --SUM("discovery" = '') AS "discovery_''",
    SUM("year"      = '') AS "year_''",
    SUM("lat"       = '') AS "lat_''",
    SUM("long"      = '') AS "long_''"
FROM tmp;

-- check for NULL values to see if replacing worked
SELECT
    --SUM("name"      IS NULL) AS "name_NULL",
    --SUM("id"        IS NULL) AS "id_NULL",
    --SUM("class"     IS NULL) AS "class_NULL",
    SUM("mass"      IS NULL) AS "mass_NULL",
    --SUM("discovery" IS NULL) AS "discovery_NULL",
    SUM("year"      IS NULL) AS "year_NULL",
    SUM("lat"       IS NULL) AS "lat_NULL",
    SUM("long"      IS NULL) AS "long_NULL"
FROM tmp;

-- count values with +.3f decimal numbers
SELECT
COUNT("mass") AS "mass_3+",
COUNT("lat") AS "lat_3+",
COUNT("long") AS "long_3+"
FROM tmp
-- WHERE "mass" GLOB '*.*???*'
-- GLOB specific expression *[any number of char], ?[excatly one char]
--LIKE specific expression%[any number of char], _[excatly one char]
WHERE "mass" LIKE '%.___%'
OR "long" LIKE '%.___%'
OR "lat" LIKE '%.___%'
;

-- count values named "Relict"
SELECT COUNT("nametype") AS "nametype_Relict"
FROM tmp WHERE "nametype" = "Relict";
