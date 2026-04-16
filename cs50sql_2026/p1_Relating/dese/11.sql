/*
Is there a relationship between school expenditures and graduation rates?
In 11.sql, write a SQL query to display
    the names of schools,
    their per-pupil expenditure,
    and their graduation rate.
Sort the
    schools from greatest per-pupil expenditure to least.
If two schools have the same per-pupil expenditure, sort by school name.
You should assume a school spends the same amount per-pupil their district as a whole spends.
*/

SELECT s.name, e.per_pupil_expenditure, g.graduated
FROM schools AS s
JOIN expenditures AS e ON e.district_id = s.district_id
JOIN graduation_rates AS g ON g.school_id = s.id
ORDER BY e.per_pupil_expenditure DESC, s.name ASC
-- LIMIT 10
;

/*
SELECT d.name, e.per_pupil_expenditure
FROM districts AS d
LEFT JOIN expenditures AS e ON e.district_id = d.id
WHERE d.name LIKE '%non%'
LIMIT 10
;
*/
