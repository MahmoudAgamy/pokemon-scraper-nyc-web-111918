
CREATE      READ    UPDATE    DELETE

# SYNTAX KEYWORD ORDER
  SELECT
  FROM
  JOIN
    ON
  WHERE
  GROUP BY
  HAVING
  ORDER BY
  LIMIT


sqlite> sqlite3 pet_database.db
sqlite> CREATE TABLE cats (
        id INTEGER PRIMARY KEY,
				name TEXT,
				age INTEGER
			);

sqlite> ALTER TABLE cats ADD COLUMN breed TEXT;

sqlite> DROP TABLE cats; # will delete the table


# UPDATE
UPDATE characters
SET species = "Martian"
WHERE id = (SELECT MAX(ID) FROM characters);


####### SQLITE3
  CREATE TABLE table_name;

# unique
  SELECT DISTINCT name FROM cats;

  SELECT * FROM bears WHERE name IS NULL;

# Sorting
  SELECT column_name FROM table_name ORDER BY column_name ASC|DESC;
  SELECT * FROM cats ORDER BY age DESC; # note: asc is the default

  SELECT name, motto
  FROM characters
  ORDER BY (LENGTH(motto)) DESC
  LIMIT 1

  SELECT column_name, column_name
FROM table_name
ORDER BY column_name ASC|DESC, column_name ASC|DESC;

# LIMIT
  SELECT * FROM cats ORDER BY age DESC LIMIT 1; # limit 1 will get us the first row only. limit 2,3,.....

# Between
  SELECT column_name(s) FROM table_name WHERE column_name BETWEEN value1 AND value2;

# insert
  INSERT INTO cats (name, age, breed) VALUES (NULL, NULL, "Tabby");
  SELECT * FROM cats WHERE name IS NULL;

# count
  SELECT COUNT(owner_id) FROM cats WHERE owner_id = 1; # return an integer

# grouping
  SELECT breed, COUNT(breed) FROM cats GROUP BY breed;

# 2 tables
  SELECT cats.name FROM cats;
  SELECT cats.name, dogs.name FROM cats, dogs;

# Aggregate Functions
Aggregate functions perform a calculation on specified values, queried from a database table. We will cover the following aggregators here:
AVG
SUM
COUNT
MIN
MAX

# in the terminal
sqlite3 # access the sqlite system OR
  sqlite3 test_sqlite.db # to access it and create the database at the sametime
sqlite> #<= means you are in
sqlite> .quit # to exit, NOTE .quit doesn't need ; to terminate
sqlite> test_sqlite.db # creates a database called test_sqlite.db and you should see this file in your working directory
sqlite> create table test_table(id); # creates table inside the current database with column (id), NOTE terminated with ;

####### in the terminal
sqlite> sqlite3 pet_database.db
sqlite> CREATE TABLE cats (
        id INTEGER PRIMARY KEY,
				name TEXT,
				age INTEGER
			);

sqlite> ALTER TABLE cats ADD COLUMN breed TEXT;

sqlite> DROP TABLE cats; # will delete the table

# JOIN
SELECT column_name(s)
FROM first_table
INNER JOIN second_table
ON first_table.column_name = second_table.column_name;

A LEFT OUTER JOIN query returns all rows from the left, or first, table,
regardless of whether or not they met the JOIN condition. The query will
also return the matched data from the right, or second, table.
SELECT column_name(s)
FROM first_table
LEFT JOIN second_table
ON first_table.column_name=second_table.column_name;

The RIGHT OUTER JOIN is the reverse of the LEFT OUTER JOIN. It will return
all data from the right, or second, table and the matched data from the
left, or first table.

FULL OUTER JOIN queries will combine the result of both a LEFT and RIGHT
OUTER JOIN. In other words, they will return all the data from both the
first and second tables.


SELECT column(s)
FROM table_one
INNER JOIN table_two
ON table_one.column_name = table_two.column_name
WHERE table_two.column_name = condition;


We can tell our SQL queries and aggregate functions to group and sort our data using a number of clauses:
ORDER BY()
LIMIT
GROUP BY()
HAVING and WHERE
ASC/DESC

SELECT SUM(cats.net_worth)
FROM owners
INNER JOIN cats_owners
ON owners.id = cats_owners.owner_id
JOIN cats ON cats_owners.cat_id = cats.id
WHERE cats_owners.owner_id = 2;

BAD SQL:
SELECT employee, SUM(bonus) FROM employee_bonus
GROUP BY employee WHERE SUM(bonus) > 1000;

GOOD SQL:
SELECT employee, SUM(bonus) FROM employee_bonus
GROUP BY employee HAVING SUM(bonus) > 1000;

Also note syntax differences: HAVING is after GROUP BY and WHERE is before GROUP BY changing the order will produce a syntax error.



HAVING SUM(pledges.amount) >= projects.funding_goal

# LEFT OUTER JOIN
SELECT * FROM teachers
   LEFT OUTER JOIN students on teachers.id = students.teacher_id;

# RIGHT OUTER JOIN
SELECT * from teachers
   RIGHT OUTER JOIN students on teachers.id = students.teacher_id;

# FULL OUTER JOIN
SELECT * from teachers
   FULL OUTER JOIN students on teachers.id = students.teacher_id;

####### Datatypes
TEXT
INTEGER
REAL # Anything that's a plain old decimal like 1.3 or 2.25. SQLite will store decimals up to 15 characters long. You can store 1.2345678912345 or 1234.5678912345
BLOB # It is generally used for holding binary data



```bash
sqlite> .help
.backup ?DB? FILE      Backup DB (default "main") to FILE
.bail ON|OFF           Stop after hitting an error.  Default OFF
.databases             List names and files of attached databases
.dump ?TABLE? ...      Dump the database in an SQL text format
                         If TABLE specified, only dump tables matching
                         LIKE pattern TABLE.
.echo ON|OFF           Turn command echo on or off
.exit                  Exit this program
.explain ?ON|OFF?      Turn output mode suitable for EXPLAIN on or off.
                         With no args, it turns EXPLAIN on.
.header(s) ON|OFF      Turn display of headers on or off
.help                  Show this message
.import FILE TABLE     Import data from FILE into TABLE
.indices ?TABLE?       Show names of all indices
                         If TABLE specified, only show indices for tables
                         matching LIKE pattern TABLE.
.log FILE|off          Turn logging on or off.  FILE can be stderr/stdout
.mode MODE ?TABLE?     Set output mode where MODE is one of:
                         csv      Comma-separated values
                         column   Left-aligned columns.  (See .width)
                         html     HTML <table> code
                         insert   SQL insert statements for TABLE
                         line     One value per line
                         list     Values delimited by .separator TEXT
                         tabs     Tab-separated values
                         tcl      TCL list elements
.nullvalue TEXT      Print TEXT in place of NULL values
.output FILENAME       Send output to FILENAME
.output stdout         Send output to the screen
.prompt MAIN CONTINUE  Replace the standard prompts
.quit                  Exit this program
.read FILENAME         Execute SQL in FILENAME
.restore ?DB? FILE     Restore content of DB (default "main") from FILE
.schema ?TABLE?        Show the CREATE statements
                         If TABLE specified, only show tables matching
                         LIKE pattern TABLE.
.separator TEXT      Change separator used by output mode and .import
.show                  Show the current values for various settings
.stats ON|OFF          Turn stats on or off
.tables ?TABLE?        List names of tables
                         If TABLE specified, only list tables matching
                         LIKE pattern TABLE.
.timeout MS            Try opening locked tables for MS milliseconds
.vfsname ?AUX?         Print the name of the VFS stack
.width NUM1 NUM2 ...   Set column widths for "column" mode
.timer ON|OFF          Turn the CPU timer measurement on or off
