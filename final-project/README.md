# my-webserver

Prerequisites:

1. Java JDK 8+
2. PostgreSQL database
3. PostgreSQL JDBC driver

Compile Command:
javac *.java

Include jdbc Driver path example:
java -cp "/usr/share/jdbc-postgresql/lib/jdbc-postgresql.jar:." DatabaseConnection

Connect to PostgreSQL:

psql -U postgres

Create the database (used by default)
CREATE DATABASE auth_db;
