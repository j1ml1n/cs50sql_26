CREATE TABLE "users" (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL -- hashed in real life application
);


CREATE TABLE "education" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE,
    "type" TEXT NOT NULL,
    "location"TEXT NOT NULL,
    "founding_year" TEXT NOT NULL
);


CREATE TABLE "companies" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE,
    "industry" TEXT NOT NULL,
    "location" TEXT NOT NULL
);


CREATE TABLE "people_connections" (
    "id" INTEGER PRIMARY KEY,
    "user_idA" INTEGER,
    "user_idB" INTEGER,
    FOREIGN KEY ("user_idA") REFERENCES "users"("id"),
    FOREIGN KEY ("user_idB") REFERENCES "users"("id")
);


CREATE TABLE "schools_connections" (
    "id" INTEGER PRIMARY KEY,
    "user_id" INTEGER,
    "education_id" INTEGER,
    "startDate" TEXT NOT NULL, -- 'yyyy-mm-dd'
    "endDate" TEXT NOT NULL, -- 'yyyy-mm-dd'
    "typeDegree" TEXT NOT NULL,
    "statusDegree" TEXT -- degree earned or persued
    CHECK ("status_degree" in ('earned', 'persued')),
    FOREIGN KEY ("education_id") REFERENCES "education"("id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("id")
);


CREATE TABLE "companies_connections" (
    "id" INTEGER PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "companie_id" INTEGER NOT NULL,
    "startDate" TEXT NOT NULL, -- 'yyyy-mm-dd'
    "endDate" TEXT NOT NULL, -- 'yyyy-mm-dd'
    "title" TEXT NOT NULL, -- title or role in company
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("companie_id") REFERENCES "companies"("id")
);
