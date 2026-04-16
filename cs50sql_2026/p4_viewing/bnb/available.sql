CREATE VIEW available AS
SELECT
l."id", l."property_type",
l."host_name",l."accommodates", a."date"
FROM listings AS l
JOIN availabilities AS a
ON a."listing_id" = l."id"
WHERE "available" = 'TRUE';

--SELECT * FROM available LIMIT 5;
--DROP VIEW available;

