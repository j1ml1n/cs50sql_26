/*
A parent wants to send their child to a district with many other students.
In 8.sql, write a SQL query to display the names of all school districtsand the number of pupils enrolled in each.
*/

SELECT d.name AS 'District name',
e.pupils AS 'Number of pupils'
FROM districts AS d
JOIN expenditures AS e
ON d."id" = e."district_id"
WHERE d.name NOT LIKE '%non-op%'
GROUP BY d.name
-- ORDER BY e.pupils DESC, d.name ASC
;
