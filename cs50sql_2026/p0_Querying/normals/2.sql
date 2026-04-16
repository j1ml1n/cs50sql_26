/*
In 2.sql, write a SQL query to find the normal temperature of the deepest sensor near the Gulf of Maine, at the same coordinate above.
The deepest sensor records temperatures at 225 meters of depth, so you can find this data in the 225m column.

Executing 2.sql results in a table with 1 column and 1 row.
*/

SELECT "225m" FROM "normals"
WHERE "latitude" = '42.5'
AND "longitude" = '-69.5';
