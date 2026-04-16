-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- ============================
-- add data
-- ============================
-- add new date_trip
INSERT INTO date_trip ("district_id", "planned_for")
VALUES
(5, '2026-03-12'),
(5, '2026-03-14')
;

-- add new district
INSERT INTO district ("name")
VALUES ('Suginami')
;

-- add new holy_site
INSERT INTO holy_site("name", "type", "religion", "has_goshuin", "district_id")
VALUES ('Asagaya Shinmeigu','shrine','Shinto',FALSE, 6)
;

-- add new site_trip
INSERT INTO site_trip ("trip_id", "site_id", "visited", "got_goshuin")
VALUES (8, 6, FALSE, 'has no goshuin')
;

-- ============================
-- update tables
-- ============================
-- update date_trip
UPDATE date_trip
SET "planned_for" = '2026-03-15'
WHERE "planned_for" = '2026-03-14'
    AND "district_id" = 5
;

-- update holy_site
UPDATE holy_site
SET "has_goshuin" = TRUE
WHERE "name" = 'Asagaya Shinmeigu'
;

-- update site_trip
UPDATE site_trip
SET "visited" = TRUE
WHERE "trip_id" = 5
    AND "site_id" = 5
;

-- ============================
-- delete data
-- ============================
-- delete new date_trip
DELETE FROM date_trip
WHERE "planned_for" = '2026-03-12'
;

-- delete new site_trip
DELETE FROM site_trip
WHERE "trip_id" = 7
;

-- ============================
-- queries
-- ============================
-- show all holy site with districts
SELECT
hs."name" AS "Holy Site",
d."name" AS "Distrct"
FROM holy_site as hs
JOIN district as d
    ON hs."district_id" = d."id"
;

-- show planned trips that are not conducted yet
SELECT *
FROM planned_not_visited
;

-- show name and district of all holy sites that offer a goshuin
SELECT * FROM holy_sites_has_goshuin;

-- show holy site that offer a stamp but are not in site_trip
SELECT hs."name", hs."has_goshuin", d."name" AS district
FROM holy_site AS hs
JOIN district AS d
    ON hs."district_id" = d."id"
LEFT JOIN site_trip AS st
    ON hs."id" = st."site_id"
WHERE hs."has_goshuin" = TRUE
    AND st."site_id" IS NULL
;
