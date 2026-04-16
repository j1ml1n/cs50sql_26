example on how to use subqueries step by step:
- without subq:
SELECT "id" FROM "books" WHERE "title" = 'The Birthday Party';

- with one subq:
SELECT "author_id" FROM "authored" WHERE "book_id" = (
    SELECT "id" FROM "books" WHERE "title" = 'The Birthday Party';
);

- with two subq:
SELECT "title" FROM "books" WHERE "id" IN (
    SELECT "book_id" FROM "authored" WHERE "author_id" = (
        SELECT "id" FROM "authors" WHERE "name" = 'Fernanda Melchor'
    )
);


use JOIN --> using only JOIN is same as using INNER JOIN

SELECT * FROM "sea_lions"
    JOIN "migrations" ON "migrations"."id" = "sea_lions"."id"
    /*
    INNER JOIN "migrations" ON "migrations"."id" = "sea_lions"."id"
    --> tables "sea_lions" and "migrations" are joined according to values in colums "id"
    An INNER JOIN returns only rows where both tables have matching values based on the join condition.
    */
;

OUTER JOINs are
LEFT JOIN   --> will set prio on "left" table eg "migrations"."id"
RIGHT JOIN  --> will set prio on "right" table eg "sea_lions"."id"
FULL JOIN   --> keeps all rows from both tables, matching where possible.

use LEFT JOIN
SELECT * FROM "sea_lions"
    LEFT JOIN "migrations" ON "migrations"."id" = "sea_lions"."id"
    /*
    will set prio on "left" table here "sea_lions"
    left table is the first table in sql
    so ALL sea_lions will be in output
    regardless if data are present in "migrations" or not
    */
;

use RIGHT JOIN
SELECT * FROM "sea_lions"
    RIGHT JOIN "migrations" ON "migrations"."id" = "sea_lions"."id"
    /*
    will set prio on "right" table here "migrations"
    right table is the second table in sql
    so all migrations will be in output
    regardless if data are present in "sea_lions" or not
    */
;

use FULL JOIN
SELECT * FROM "sea_lions"
    FULL JOIN "migrations" ON "migrations"."id" = "sea_lions"."id"
    /*
    keeps all rows from both tables, matching where possible.
    */
;

use NATURAL JOIN
SELECT * FROM "sea_lions"
    NATURAL JOIN "migrations"
    /*
    Automatically joins all columns with the same name in both tables IF you do not specify using ON.
    Can be risky, because if tables gain a new same-named column, the join changes unexpectedly.
    Warning:
    Avoid NATURAL JOIN in production; it makes SQL harder to read and fragile.
    */
;

#################################
#################################
#################################

SETs --> INTERSECT, UNION, EXCEPT
INTERSECT --> Authors INTERSECT Translator  >>> you can be both Author or Translator
UNION     --> Authors UNION Translator      >>> you can be either Author or Translator
EXCEPT    --> Authors EXCEPT Translator     >>> you can only be an Author

SELECT "name" FROM "authors"
    UNION
    SELECT "name" FROM "translators"
;

/* will create a colum "Profession" containing the given string */
SELECT 'authors' AS "Profession", "name" FROM "authors"
    UNION
    SELECT 'translators' AS "Profession" "name" FROM "translators"
;

SELECT "name" FROM "authors"
    INTERSECT
    SELECT "name" FROM "translators"
;

SELECT "name" FROM "authors"
    EXCEPT
    SELECT "name" FROM "translators"
;

#################################
####### Hinweise bei SETs #######
#################################

Situation	                        JOIN sinnvoll?	    SET sinnvoll?
Tabellen verbinden	                ja	                nein
Schnitt/Union von Ergebnissen	    nein	            ja
Duplikate behalten	                ja	                nein (INTERSECT/EXCEPT)
Duplikate entfernen	                nein	            ja
Logisch-mengenorientiert gedacht    nein                ja
Performance kritisch	            best	            okay aber manchmal langsam

Wann SET-Operatoren sinnvoll sind
1. Wenn du wirklich mengenlogisch denkst
„Gib mir die Teams, die sowohl in Tabelle A als auch Tabelle B vorkommen.“
→ Das ist exakt ein Schnitt zweier Mengen → INTERSECT
Beispiel:
    SELECT player_id FROM goals
    INTERSECT
    SELECT player_id FROM assists;
Das sagt sofort: „Spieler, die Tore UND Assists haben.“
Das ist viel klarer als ein GROUP BY / HAVING oder ein komplizierter JOIN.

2. Wenn du Duplikate automatisch entfernen willst
SET-Operatoren (außer UNION ALL) arbeiten wie ein DISTINCT.
    SELECT team_id FROM performances
    INTERSECT
    SELECT team_id FROM performances WHERE ...
→ Kein Duplicate-Handling nötig.
Wenn du duplikatfreie Ergebnisse brauchst, sind SET-Operatoren ideal.

3. Wenn JOINs zu komplex oder schlecht lesbar würden
Manchmal werden mehrere JOINs + Bedingungen das Query unübersichtlich machen.
Ein SET-Operator dagegen kann die Absicht klar ausdrücken:
    SELECT id FROM users WHERE paid = 1
    INTERSECT
    SELECT id FROM users WHERE active = 1;
Lesbar, einfach, logisch.

#################################
#################################
#################################

GROUPs   --> GROUP BY, HAVING
GROUP BY --> will group output based on values in specific column
HAVING   --> will specify

SELECT "book_id", AVG("rating") AS "average rating"
FROM "ratings"
GROUP BY "book_id"
;

SELECT "book_id", ROUND(AVG("rating"), 2) AS "average rating"
FROM "ratings"
GROUP BY "book_id"
    /* WHERE "average rating" > 4.0; --> would not work since rating was grouped
HAVING "average rating" > 4.0
;

SELECT "book_id", ROUND(AVG("rating"), 2) AS "average rating"
FROM "ratings"
GROUP BY "book_id"
    /* WHERE "average rating" > 4.0; --> would not work since rating was grouped
HAVING "average rating" > 4.0
ORDER BY "average rating" DESC
;
