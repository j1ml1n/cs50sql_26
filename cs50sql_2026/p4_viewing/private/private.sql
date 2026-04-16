CREATE TABLE temp_decode (
    "id" INTEGER PRIMARY KEY,
    "sentence_id" INTEGER NOT NULL,
    "substr" TEXT NOT NULL,
    FOREIGN KEY ("sentence_id") REFERENCES sentences("id")
);

INSERT INTO "temp_decode" ("sentence_id", "substr")
VALUES
    (14, (SELECT substr("sentence", 98, 04) FROM sentences WHERE "id" = 14)),   -- 14	98	4
    (114, (SELECT substr("sentence", 03, 05) FROM sentences WHERE "id" = 114)),  -- 114	3	5
    (618, (SELECT substr("sentence", 72, 09) FROM sentences WHERE "id" = 618)),  -- 618	72	9
    (630, (SELECT substr("sentence", 07, 03) FROM sentences WHERE "id" = 630)),  -- 630	7	3
    (932, (SELECT substr("sentence", 12, 05) FROM sentences WHERE "id" = 932)),  -- 932	12	5
    (2230, (SELECT substr("sentence", 50, 07) FROM sentences WHERE "id" = 2230)), -- 2230	50	7
    (2346, (SELECT substr("sentence", 44, 10) FROM sentences WHERE "id" = 2346)), -- 2346	44	10
    (3041, (SELECT substr("sentence", 14, 05) FROM sentences WHERE "id" = 3041)) -- 3041	14	5
;

CREATE VIEW message AS
SELECT "substr" AS "phrase" FROM temp_decode;
SELECT * FROM message;

-- comment out for checker except
-- DROP TABLE temp_decoded;
-- DROP VIEW message;
