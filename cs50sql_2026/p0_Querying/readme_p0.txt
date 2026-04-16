sqlite3
- enter file.de via sqlite3 Longlist.de
- how to get all tables in a file.db --> Looking at schema; later in course
- table or column names are written in "…" --> just best practice
- strings are written in '...' --> just best practice
- in sql '!=' (not equal to) is the same as '<>' (not equal to)
- […] WHERE NOT […] is equal to […] WHERE […] !=/<>
- '_' will match a single charater
	[…] WHERE 'title' LIKE 'P_re' --> will get all strings containing 'P*re'
	[…] WHERE 'title' LIKE 'P_r_' --> will get all strings containing 'P*r*'
	[…] WHERE 'title' LIKE 'T___' --> will get all strings containing 'T***'

- '%' will match any number of characters --> works like a Wildcard
	[…] WHERE 'title' LIKE '%love%' --> will get all strings containing 'love'
	[…] WHERE 'title' LIKE 'The %' --> will get all titles with 'The ' at the start
	[…] WHERE 'title' LIKE 'The %love%' --> str Needs to contain 'The ' and 'love'

- in order to use ranges use '<', '>', '>=', '<=' or use […] BETWEEN … AND …
- SELEC "title", "rating" FROM "longlist" ORDER BY "rating" [DESC/ASC] LIMIT 10;
	 ORDER BY "rating" DESC LIMIT 10;
	 ORDER BY "rating" ASC, "votes" DESC LIMIT 10;

- SELECT column_name FROM table_name
  WHERE column_name BETWEEN low_value AND high_value;

Equivalent to:
- WHERE column_name >= low_value AND column_name <= high_value;

- Aggregation mit COUNT, AVG, MIN, MAX,SUM
	SELECT AVG("rating") FROM "longlist";
	SELECT ROUND(AVG("rating"), 2) FROM "longlist"; --> rundet output auf .2f
	SELECT ROUND(AVG("rating"), 2) AS 'avg rating 'FROM "longlist"; --> rename output  	header

- get unique values using DISTINCT
	SELECT DISTINCT "publisher" FROM "longlist"; --> get all unique publisher (33)

- exit sqlite promt .quit

