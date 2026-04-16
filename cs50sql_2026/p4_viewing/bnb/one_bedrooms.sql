CREATE VIEW one_bedrooms AS
SELECT "id", "property_type", "host_name", "accomodates"--, "bedrooms"
FROM listings
WHERE "bedrooms" = 1;

--SELECT * FROM one_bedrooms LIMIT 5;
--DROP VIEW one_bedrooms;

/*
In one_bedrooms.sql, write a SQL statement to create a view named one_bedrooms.
This view should contain all listings that have exactly one bedroom.
Ensure the view contains the following columns:

id, which is the id of the listing from the listings table.
property_type, from the listings table.
host_name, from the listings table.
accommodates, from the listings table.
*/
