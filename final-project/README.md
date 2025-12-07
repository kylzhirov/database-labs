# my-webserver

The web-server at this current time represents
the authorization/registration of a user through browser as UserAgent. Using JDBC (Java PostgreSQL Driver)

## Prerequisites:

1. Git
2. Maven
3. Java JDK 17+
4. PostreSQL

## Steps to run a project:

1. Connect to PostgreSQL:
```bash
psql -U postgres
```
2. Create the database (auth_db is used by default)
```
CREATE DATABASE auth_db;
```
3. Start through Maven
```bash
git clone https://github.com/kylzhirov/database-labs
cd database-labs
cd final-project/oauth_sql
mvn spring-boot:run
```

