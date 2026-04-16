-- check if it everything workeed
SELECT * FROM users
WHERE "username" = 'admin';

-- alter password in abmin account
UPDATE users SET "password" = '982c0381c279d139fd221fce974916e7'
WHERE "username" == 'admin';

-- erase triggered inserts into user_logs vor update and deletion
    --> seperate step not needed
    --> trail can be thrown off by adding false date

-- add false data; replace new password hash in user_logs with pwHash of emily33
UPDATE user_logs SET "new_password" = (
    SELECT "password" FROM users WHERE
    "username" = 'emily33'
)
WHERE "type" = 'update'
AND "old_username" = 'admin';

-- check if it everything workeed
SELECT * FROM users
WHERE "username" = 'emily33';

SELECT * FROM user_logs
WHERE "type" = 'update'
AND "new_username" = 'admin';
