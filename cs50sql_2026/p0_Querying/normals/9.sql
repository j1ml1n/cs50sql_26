/*
In 9.sql, write a SQL query to find the 10 locations with the highest normal ocean surface temperature, sorted warmest to coldest.
If two locations have the same normal ocean surface temperature, sort by latitude, smallest to largest.
Include latitude, longitude, and surface temperature columns.

Executing 9.sql results in a table with 3 columns and 10 rows.
*/
SELECT "latitude", "longitude", "0m" FROM "normals"
ORDER BY "0m" DESC, "latitude" DESC
LIMIT 10;
