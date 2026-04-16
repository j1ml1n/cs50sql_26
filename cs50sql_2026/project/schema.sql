-- In this SQL file, write (and comment!) the schema of your database,
-- including the CREATE TABLE,
-- ============================
-- Database schema for managing trips to temples and shrines in tokyo
-- ============================
-- This database stores district, holy sites, planned trips,
-- and which sites are visited during each trip.
-- The tables are connected using primary keys and foreign keys.
-- ============================

-- ============================
-- Table_1: district
-- ============================
-- This table stores all district.
-- Each district has a unique id and a unique name.
CREATE TABLE IF NOT EXISTS district (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    PRIMARY KEY ("id")
);

-- ============================
-- Table_2: date_trip
-- ============================
-- This table stors planned trips.
-- Each trip belongs to one distrcit.
-- district_id is a foreign key that references district(id).
-- planned_for stores the date as TEXT in format yyyy-mm-dd.
CREATE TABLE IF NOT EXISTS date_trip (
    "id" INTEGER,
    "district_id" INTEGER NOT NULL,
    "planned_for" TEXT DEFAULT NULL, -- DATE in format yyyy-mm-dd
    PRIMARY KEY ("id"),
    FOREIGN KEY ("district_id") REFERENCES district("id")
);

-- ============================
-- Table_3: holy_site
-- ============================
-- This table stores information about holy sites.
-- Each holy site belongs to one district.
-- has_goshuin indicates if the site offers goshuin stamps or not.
CREATE TABLE IF NOT EXISTS holy_site (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "type" TEXT NOT NULL
        CHECK ("type" IN ('temple', 'shrine')),
    "religion" TEXT NOT NULL,
    "has_goshuin" BOOLEAN NOT NULL DEFAULT(FALSE),
    "district_id" INTEGER NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("district_id") REFERENCES district("id")
);

-- ============================
-- Table_4: site_trip
-- ============================
-- This is a junction table between trip and holy_site.
-- It stores which holy sites belong to which trip.
-- visited indicates if the site was actually visited.
-- got_goshuin is used to store information if a stamp was collected, if available, or not
-- UNIQUE(trip_id, site_id) ensures the same site is not added twice to the same trip.
CREATE TABLE IF NOT EXISTS site_trip (
    "id" INTEGER,
    "trip_id" INTEGER NOT NULL,
    "site_id" INTEGER NOT NULL,
    "visited" BOOLEAN DEFAULT (FALSE),
    "got_goshuin" TEXT NOT NULL DEFAULT 'has no goshuin'
            CHECK ("got_goshuin" IN ('yes', 'no', 'has no goshuin')),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("trip_id") REFERENCES date_trip("id"),
    FOREIGN KEY ("site_id") REFERENCES holy_site("id"),
    UNIQUE ("trip_id", "site_id")
);


-- CREATE INDEX,
-- ============================
-- Add indexes on foreign key columns to speed up joins
-- ============================
CREATE INDEX IF NOT EXISTS "trip_districtId" ON date_trip("district_id");
CREATE INDEX IF NOT EXISTS "holySite_districtId" ON holy_site("district_id");
CREATE INDEX IF NOT EXISTS "siteTrip_tripId" ON site_trip("trip_id");
CREATE INDEX IF NOT EXISTS "siteTrip_siteId" ON site_trip("site_id");
-- indexes on district("name"), holy_site("name") not needed
-- both are automatically created due to UNIQUE constrain


-- CREATE VIEW,
-- ============================
-- View_1: trips_to_district
-- ============================
-- table that shows all trips that have a date and the target districts name
CREATE VIEW IF NOT EXISTS trips_to_district AS
SELECT
    dt."planned_for" AS on_date,
    d."name" AS to_district
FROM date_trip AS dt
JOIN district AS d
    ON d."id" = dt."district_id"
WHERE dt."planned_for" IS NOT NULL
ORDER BY dt."planned_for" ASC
;

-- ============================
-- View_2: planned_not_visited
-- ============================
-- table that shows all trips that have a date as well information of the site
-- but that were not taken yet - 'visited' is false
CREATE VIEW IF NOT EXISTS planned_not_visited AS
SELECT
    dt."planned_for" AS on_date,
    hs."name" AS holy_site,
    d."name" AS district,
    st."visited" AS saw_site
FROM date_trip AS dt
JOIN site_trip AS st
    ON dt."id" = st."trip_id"
JOIN district AS d
    ON dt."district_id" = d."id"
JOIN holy_site AS hs
    ON st."site_id" = hs."id"
WHERE dt."planned_for" IS NOT NULL
    AND st."visited" = FALSE
;

-- ============================
-- View_3: not_planned_for_trip
-- ============================
-- table that shows holy site along with district that are not assigned for a trip
CREATE VIEW IF NOT EXISTS not_planned_for_trip AS
SELECT
    hs."name" AS holy_site,
    d."name" AS district
FROM holy_site AS hs
JOIN district AS d
    ON d."id" = hs."district_id"
LEFT JOIN site_trip AS st
    ON st."site_id" = hs."id"
WHERE st."site_id" IS NULL
;

-- ============================
-- View_4: collected_goshuin
-- ============================
-- table that shows the name and type of all holy sites the user has a goshuin from
CREATE VIEW IF NOT EXISTS collected_goshuin AS
SELECT
    hs."name" AS holy_site,
    hs."type",
    st."got_goshuin"
FROM holy_site AS hs
JOIN site_trip AS st
    ON st."site_id" = hs."id"
WHERE st."got_goshuin" = 'yes'
;

-- ============================
-- View_5: holy_sites_has_goshuin
-- ============================
-- table that shows the name and district of all holy sites that offer a goshuin
CREATE VIEW IF NOT EXISTS holy_sites_has_goshuin AS
SELECT
    hs."name" AS holy_site,
    d."name" AS in_district,
    hs."type",
    hs."has_goshuin"
FROM district AS d
JOIN holy_site AS hs
    ON hs."district_id" = d."id"
WHERE hs."has_goshuin" = TRUE
;


-- ============================
-- Trigger_1: check_date_fornat_insert
-- ============================
-- Before a new row is insered into date_trip this trigger will check if the string
-- matches a given format yyyy-mm-dd  and is not NULL
-- and will raise in Error if it does not
CREATE TRIGGER IF NOT EXISTS check_date_format_insert
BEFORE INSERT ON date_trip
FOR EACH ROW
WHEN NEW.planned_for IS NOT NULL -- needed else planned_id could not use NULL per default
BEGIN
  SELECT
    CASE
      WHEN NEW.planned_for GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
           AND date(NEW.planned_for) IS NOT NULL
      THEN 1
      ELSE RAISE(ABORT, 'Error: planned_for must be yyyy-mm-dd')
    END;
END;


-- ============================
-- Trigger_2: check_date_format_update
-- ============================
-- Before a value in column 'planned_for' in table date_trip is updated this trigger
-- will check if the string matches a given format yyyy-mm-dd and is not NULL
-- and will raise in Error if it does not
CREATE TRIGGER IF NOT EXISTS check_date_format_update
BEFORE UPDATE OF "planned_for" ON date_trip
FOR EACH ROW
WHEN NEW.planned_for IS NOT NULL -- needed else planned_id could not be set to NULL again
BEGIN
  SELECT
    CASE
      WHEN NEW.planned_for GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
           AND date(NEW.planned_for) IS NOT NULL
      THEN 1
      ELSE RAISE(ABORT, 'Error: planned_for must be yyyy-mm-dd')
    END;
END;

-- ============================
-- Trigger_3: check_gotGoshuin_visitedTrue
-- ============================
-- If site_trip.got_goshuin is updated from 'no' to 'yes,
-- it will be checked if site_trip.visited is TRUE
CREATE TRIGGER IF NOT EXISTS check_gotGoshuin_visitedTrue
BEFORE UPDATE OF got_goshuin ON site_trip
FOR EACH ROW
WHEN NEW.got_goshuin = 'yes' AND OLD.got_goshuin != 'yes'
BEGIN
    SELECT CASE
        WHEN NEW.visited = FALSE
        THEN RAISE(ABORT, 'Error: Cannot set got_goshuin to "yes" when visited is FALSE')
    END;
END;

-- ============================
-- Trigger_4: update_hasGoshuin_gotGoshuin
-- ============================
-- If holy_site.has_goshuin is updated from FALSE to TRUE,
-- then all site_trip rows for this site are updated:
-- got_goshuin changes from 'has no goshuin' to 'no'.
CREATE TRIGGER IF NOT EXISTS update_hasGoshuin_gotGoshuin
AFTER UPDATE OF has_goshuin ON holy_site
FOR EACH ROW
WHEN OLD.has_goshuin = FALSE AND NEW.has_goshuin = TRUE
BEGIN
    UPDATE site_trip
    SET "got_goshuin" = 'no'
    WHERE "site_id" = NEW."id"
      AND "got_goshuin" = 'has no goshuin';
END;

-- ============================
-- Trigger_5: default_goshuin_on_insert
-- ============================
-- after a new row is inserted into site_trip this trigger is used to help with consistency
-- if the inserted site_it belongs to a site were holy_site.has_goshuin is TRUE
-- the default value of site_id.got_goshuin 'has no goshuin' is replaced with 'no'
CREATE TRIGGER IF NOT EXISTS default_goshuin_on_insert
AFTER INSERT ON site_trip
FOR EACH ROW
WHEN NEW.got_goshuin = 'has no goshuin'
     AND EXISTS (
         SELECT 1
         FROM holy_site hs
         WHERE hs.id = NEW.site_id
           AND hs.has_goshuin = TRUE
     )
BEGIN
    UPDATE site_trip
    SET got_goshuin = 'no'
    WHERE id = NEW.id;
END;

