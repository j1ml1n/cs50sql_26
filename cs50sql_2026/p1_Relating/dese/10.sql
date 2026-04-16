/*
In Massachusetts, school district expenditures are in part determined by local taxes on property (e.g., home) values.
In 10.sql, write a SQL query to find the 10 public school districts with the highest per-pupil expenditures.
Your query should return the names of the districts and the per-pupil expenditure for each.
*/

SELECT
d.name,
-- d.type,
e.per_pupil_expenditure
FROM districts AS d
JOIN expenditures AS e
ON d.id = e.district_id
WHERE d.type LIKE '%ublic%'
GROUP BY d.name
ORDER BY e.per_pupil_expenditure DESC, d.name ASC
LIMIT 10
;
