/*
SELECT
"user_id" AS "uID_test",
"friend_id" AS "fID_test"
FROM friends
WHERE "user_id" = (
    SELECT "id" FROM users
    WHERE "username" = 'lovelytrust487')
OR "user_id" = (
    SELECT "id" FROM users
    WHERE "username" = 'exceptionalinspiration482')
;
*/

/*
SELECT "friend_id", "user_id"
FROM friends
WHERE "user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'lovelytrust487'
);

SELECT "friend_id", "user_id"
FROM friends
WHERE "user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'exceptionalinspiration482'
);
*/

SELECT "friend_id"--, "user_id"
FROM friends
WHERE "user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'lovelytrust487'
)
INTERSECT
SELECT "friend_id"--, "user_id"
FROM friends
WHERE "user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'exceptionalinspiration482'
);
