/*
In 8.sql, write a SQL query to find the average height and weight, rounded to two decimal places, of baseball players who debuted on or after January 1st, 2000.
Return the columns with the name “Average Height” and “Average Weight”, respectively.
Executing 8.sql results in a table with 2 columns and 1 row.
*/

SELECT
ROUND(AVG("height"), 2) AS 'Average Height',
ROUND(AVG("weight"), 2) AS 'Average Weight'
FROM "players"
WHERE "debut" >= '2000-01-01'
;
