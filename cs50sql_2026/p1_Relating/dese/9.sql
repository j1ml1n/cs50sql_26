/*
Another parent wants to send their child to a district with few other students.
In 9.sql, write a SQL query to find the name (or names)
of the school district(s) with the single least number of pupils.
Report only the name(s).
*/

SELECT
d.name AS 'District name'
-- e.pupils AS 'Number of pupils'
FROM districts AS d
JOIN expenditures AS e
ON d."id" = e."district_id"
WHERE d.name NOT LIKE '%non-op%'
AND e.pupils = (
    SELECT MIN(pupils) FROM expenditures
)
GROUP BY d.name
ORDER BY e.pupils ASC, d.name ASC
;
