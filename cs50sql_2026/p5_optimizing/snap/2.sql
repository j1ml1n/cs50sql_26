--CREATE INDEX "message_expires_id"
--ON "messages"("expires_timestamp");

--EXPLAIN QUERY PLAN
SELECT "expires_timestamp"
FROM messages
WHERE "id" = 151;
