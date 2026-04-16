/*
In 1.sql, write a SQL query to find the normal ocean surface temperature in the Gulf of Maine, off the coast of Massachusetts.
To find this temperature, look at the data associated with 42.5° of latitude and -69.5° of longitude.
Recall that you can find the normal ocean surface temperature in the 0m column, which stands for 0 meters of depth!

Executing 1.sql results in a table with 1 column and 1 row.
*/
SELECT "0m" FROM "normals"
WHERE "latitude" = '42.5'
AND "longitude" = '-69.5';

