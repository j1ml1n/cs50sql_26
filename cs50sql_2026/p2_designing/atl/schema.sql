CREATE TABLE "passengers" (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL
    -- PRIMARY KEY("id")
    );


CREATE TABLE "checkins" (
    "id" INTEGER PRIMARY KEY,
    "passenger_id",
    "checked_in", -- date & time
    "flight_id",
    -- PRIMARY KEY("id"),
    FOREIGN KEY("passenger_id") REFERENCES "passengers"("id"),
    FOREIGN KEY("flight_id") REFERENCES "flights"("id")
    );


CREATE TABLE "airlines" (
    "id" INTEGER PRIMARY KEY,
    "airline" TEXT NOT NULL,
    "concourses" TEXT CHECK ("concourses" in ('A', 'B', 'C', 'D', 'E', 'F', 'T'))
    -- PRIMARY KEY("id")
    );


CREATE TABLE "flights" (
    "id" INTEGER PRIMARY KEY,
    "airline_id",
    "departing_port" TEXT NOT NULL,
    "heading_port" TEXT NOT NULL,
    "exp_departure", -- date & time
    "exp_arrival", -- date & time
    "name" TEXT NOT NULL,
    -- PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id")
    );
