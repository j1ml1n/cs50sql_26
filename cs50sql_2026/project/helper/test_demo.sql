-- ============================
-- import test data
-- ============================
.mode csv
.import helper/testdata_district.csv tmp1
.import helper/testdata_holySite.csv tmp2

INSERT INTO district
("name")
SELECT
"name"
FROM tmp1;

INSERT INTO holy_site
("name", "type", "religion", "has_goshuin", "district_id")
SELECT
"name", "type", "religion", "has_goshuin", "district_id"
FROM tmp2;

DROP TABLE tmp1;
DROP TABLE tmp2;

-- ============================
-- create date_trips
-- ============================
INSERT INTO date_trip ("district_id", "planned_for")
VALUES
(1, '2026-02-28'),
(2, '2026-03-01'),
(3, '2026-03-10'),
(4, '2026-03-20'),
(5, '2026-03-31'),
(1, '2026-04-01');

-- ============================
-- create site_trips
-- ============================
INSERT INTO site_trip ("trip_id", "site_id", "visited", "got_goshuin")
VALUES
(1, 5, TRUE, 'yes'),
(2, 3, TRUE, 'yes'),
(4, 4, TRUE, 'no'),
(3, 1, TRUE, 'yes'),
(5, 2, TRUE, 'has no goshuin'),
(5, 5, FALSE, 'yes');

