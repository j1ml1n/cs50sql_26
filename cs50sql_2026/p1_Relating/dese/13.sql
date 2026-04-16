/*
In 13.sql, write a SQL query to answer a question you have about the data! The query should:
Involve at least one JOIN or subquery

1 Q: How much money do private schols spend per pupil compared to public?
2 Q: Is the graduation level higher in charter schools
*/

SELECT s.district_id, s.type, g.graduated, e.per_pupil_expenditure
FROM schools s
JOIN graduation_rates g ON g.school_id = s.id
JOIN expenditures e ON e.district_id = s.district_id
ORDER BY e.per_pupil_expenditure DESC, g.graduated DESC
LIMIT 10
;
