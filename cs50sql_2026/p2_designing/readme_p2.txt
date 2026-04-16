### Designing Databases
".schema file" shows all columns of a sqlite3.db file
".schema" will show all commands used to to create a given db in location
use .quit to exit sqlite3 file.db,00

Normalizing
to reduce redundancy in databases
there are different "normal forms" [1, 2, 3, etc.]


### Erstellen von neuen file.db OHNE primare and sec keys
sqlite3 mbta.db --> leere db wird erstellt
    CREATE TABLE "riders" (
        "id",
        "name");

    CREATE TABLE "stations" (
        "id",
        "name",
        "line");

    CREATE TABLE "visits" (
        "rider_id",
        "station_id");

um eine TABLE zu löschen nutzt man
    DROP TABLE "station"


### nötig um "Data Types" and "Storage Classes" richtig zu nutzen
in sqlite3 gibt es 5 storage Classes
    - NULL
    - INTEGER
    - REAL is equal to float
    - TEXT
    - BLOB 00 pictures, videos, music
    --> there is something like NUMMERIC = INTEGER + REAL
um eine TABLE zu löschen nutzt man 'DROP TABLE "station"'


### erstellen eines wiederverwendbaren .schema files
außerhalb von sqlite3 use 'code schema.sql' um ein file.sql zu erstellen
hier kann man nun ein Script schreiben, z.B.
    CREATE TABLE "riders" (
        "id" INTEGER,
        "name" TEXT
    );

    CREATE TABLE "stations" (
        "id",
        "name",
        "line"
    );

    CREATE TABLE "visits" (
        "rider_id",
        "station_id"
    );

um das script nun in sqlite3 anzuwenden brauchen wir ein neues file.db
$ sqlite3 mbta.db
sqliter> .read schema.sql
sqliter> .schema 'will know show the db-schema created by the script'
sqliter> SELECT * FROM "riders" 'will return nothing since mbta.db is empty'


### Erstellen von neuen file.db MIT 'primary key' and 'foreign keys'
'primary key'  => ❌ darf nicht NULL sein, ❌ darf nicht doppelt vorkommen
'foreign keys' => 🔗 eine Referenz auf einen Primary Key in einer anderen Tabelle,
                  🔗 sorgt für referentielle Integrität, verhindert „verwaiste“ Datensätze

    CREATE TABLE "riders" (
        "id" INTEGER,
        "name" TEXT,
        PRIMARY KEY("id")
    );

    CREATE TABLE "stations" (
        "id" INTEGER,
        "name" TEXT,
        "line" TEXT,
        PRIMARY KEY("id")
    );

    CREATE TABLE "visits" (
        "rider_id",
        "station_id"
        -- PRIMARY KEY("rider_id", "station_id")                  --version 1
        FOREIGN KEY("rider_id") REFERENCES "riders"("id"),     --version2
        FOREIGN KEY("station_id") REFERENCES "stations"("id"), --version2
    );


### Verwendung von Column Constraints
sqlite3 verwendet 3 Arten von Constraints die Columns weiter einschränken
CHECK
DEFAULT
NOT NULL
UNIQUE

    CREATE TABLE "riders" (
        "id" INTEGER, --> PRIMARY KEY applies NOT NULL
        "name" TEXT,
        PRIMARY KEY("id") --> PRIMARY KEY applies UNIQUE
    );

    CREATE TABLE "stations" (
        "id" INTEGER PRIMARY KEY,
        "name" TEXT NOT NULL UNIQUE,
        "line" TEXT NOT NULL,
        -- PRIMARY KEY("id")
    );

    CREATE TABLE "visits" (
        "id",
        "rider_id",
        "station_id"
        -- PRIMARY KEY("rider_id", "station_id") --version 1
        --> FOREIGN KEY applies NOT NULL
        FOREIGN KEY("rider_id") REFERENCES "riders"("id"),
        FOREIGN KEY("station_id") REFERENCES "stations"("id"),
    );


### ALTERING Tables
DELETE Table with drop              >>> DROP TABLE "riders";
                                    will delete "riders" from mbta.db
RENAME Table with ALTER ... RENAME  >>> ALTER TABLE "visits" RENAME TO "swipes";
                                    will rename "riders" to swipes
MODIFY Table with ALTER ... ADD     >>> ALTER TABLE "swipes" ADD COLUMN "ttpe" TEXT;
                                    will add column "ttpe" to "swipes"
RENAME Column with ALTER ... RENAME >>> ALTER TABLE "swipes" RENAME COLUMN "ttpe" TO "type";
