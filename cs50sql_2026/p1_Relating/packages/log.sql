
-- *** The Lost Letter ***
-- checking if recieving address is correct
SELECT * FROM "addresses" WHERE "address" IS '900 Somerville Avenue';
SELECT * FROM "addresses" WHERE "address" IS '2 Finnegan Street';
SELECT * FROM "addresses" WHERE "address" LIKE '%Finn%';

-- *** The Devious Delivery ***
-- find package without "FROM" address --> to_address_id is 50
SELECT * FROM "packages" WHERE "from_address_id" IS NULL;
-- find intended delivery address with id 50
 SELECT * FROM "addresses" WHERE "id" IS (
    SELECT "to_address_id" FROM "packages" WHERE "from_address_id" IS NULL);
-- find actual drop off address
SELECT * FROM "scans" WHERE "package_id" IS '5098';
SELECT * FROM "addresses" WHERE "id" IS '348';
-- all in one query with subqueries
 SELECT * FROM "addresses" WHERE "id" = (
    SELECT "address_id" FROM "scans" WHERE "package_id" = (
        SELECT "id" FROM "packages" WHERE "from_address_id" IS NULL)
    AND "action" = "Drop");

-- *** The Forgotten Gift ***
-- check if addresses are valid
SELECT * FROM "addresses" WHERE "address" = '109 Tileston Street' OR "address" = '728 Maple Place';
-- check if package was picked up from 109 Tileston Street and get package_id --> 9523
SELECT * FROM "scans" WHERE "address_id" = (
    SELECT "id" FROM "addresses" WHERE "address" IS "109 Tileston Street");
-- find content of package --> flowers
SELECT * FROM "packages" WHERE "from_address_id" = (
    SELECT "address_id" FROM "scans" WHERE "action" = 'Pick' AND "address_id" = (
        SELECT "id" FROM "addresses" WHERE "address" IS '109 Tileston Street')
   );
-- see what happend to package --> droped off by 11 and picked up by 17
SELECT * FROM "scans" WHERE "package_id" IS (
        SELECT "package_id" FROM "scans" WHERE "action" = 'Pick' AND "address_id" = (
            SELECT "id" FROM "addresses" WHERE "address" IS '109 Tileston Street')
            );

-- get name of driver 17 --> Mikel
SELECT * FROM "scans" RIGHT JOIN "drivers" ON "drivers"."id" = "scans"."driver_id"
WHERE "package_id" IS (
        SELECT "package_id" FROM "scans" WHERE "action" = 'Pick' AND "address_id" = (
            SELECT "id" FROM "addresses" WHERE "address" IS '109 Tileston Street')
            );

-- get name of driver 17 --> Mikel / alternative version
SELECT scans.*, drivers."name"  FROM "scans" RIGHT JOIN "drivers" ON "drivers"."id" = "scans"."driver_id"
WHERE "package_id" IS (
        SELECT "package_id" FROM "scans" WHERE "action" = 'Pick' AND "address_id" = (
            SELECT "id" FROM "addresses" WHERE "address" IS '109 Tileston Street')
            );
