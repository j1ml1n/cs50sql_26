--EXPLAIN QUERY PLAN
SELECT
"to_user_id"
--"from_user_id",
--COUNT("from_user_id")
FROM messages
--JOIN users AS u
WHERE "from_user_id" = (
    SELECT "id"
    FROM users
    WHERE "username" = 'creativewisdom377'
)
GROUP BY "to_user_id"
ORDER BY COUNT("from_user_id") DESC
LIMIT 3
;
