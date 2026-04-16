Dear reader,

you can reset the holy_tokio.db by simple writing './reset.sh' in your terminal and pressing enter.
This will delete the current holy_tokio.db and create a new one with the same name.
Afterward the schema.sql will be piped into sqlite3 and the new holy_tokio.db is set up.
In order to tets my database I included some very very very small testdata sets that can be found under helper.
These files will be insertet into the database. The tables date_trip and site_trip will also get some mock data to work with.
The queries from the queries.sql will also be executed by reset.sh.

Have a nice day