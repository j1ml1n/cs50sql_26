/*
In 3.sql, choose a location of your own and write a SQL query to find the normal temperature at 0 meters, 100 meters, and 200 meters.
You might find Google Earth helpful if you’d like to find some coordinates to use!
--> Leipzig 51.33962 12.37129
3.sql is up to you!
*/

SELECT "0m", "100m", "200m" FROM "normals"
WHERE "latitude" = '51.3'
AND "longitude" = '12.4';
