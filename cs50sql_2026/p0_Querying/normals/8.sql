/*
In 8.sql, write a SQL query to find the 10 locations with the lowest normal ocean surface temperature, sorted coldest to warmest.
If two locations have the same normal ocean surface temperature, sort by latitude, smallest to largest.
Include latitude, longitude, and surface temperature columns.

Executing 8.sql results in a table with 3 columns and 10 rows.
*/
SELECT "latitude", "longitude", "0m" FROM "normals"
ORDER BY "0m" ASC, "latitude" ASC
LIMIT 10;
