CREATE VIEW june_vacancies AS
SELECT
l."id",
l."property_type",
l."host_name",
--a."available", a."date"
COUNT(a."available") AS 'days_vacant'
FROM listings AS l
JOIN availabilities AS a
ON a."listing_id" = l."id"
WHERE a."available" = 'TRUE'
AND a."date" BETWEEN '2023-06-01' AND '2023-06-31'
GROUP BY l."id"
ORDER BY a."date" ASC
;

--SELECT * FROM june_vacancies LIMIT 5;
--DROP VIEW june_vacancies;

/*
June Vacancies
In june_vacancies.sql, write a SQL statement to create a view named june_vacancies.
This view should contain all listings
and the number of days in June of 2023 that they remained vacant.
Ensure the view contains the following columns:

id, which is the id of the listing from the listings table.
property_type, from the listings table.
host_name, from the listings table.
days_vacant, which is the number of days in June of 2023,
that the given listing was marked as available.
*/
