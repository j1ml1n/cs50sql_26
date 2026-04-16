/*
In 10.sql, write SQL query to answer a question of your choice. This query should:
    Make use of AS to rename a column
    Involve at least condition, using WHERE
    Sort by at least one column using ORDER BY
10.sql is up to you!
*/

SELECT "first_name", "last_name" AS 'Players from Germany' FROM "players"
WHERE "birth_country" IS 'Germany'
ORDER BY "first_name" ASC, "last_name" ASC
;
