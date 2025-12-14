# my-webserver

The web-server provides basic REST API to osu!api v2 using JDBC as Java PostgreSQL Driver

## Presentation link:
https://docs.google.com/presentation/d/11-lgp5LCS4vznQynKOkzeYpcF3V8gwvHp5Yzwnf5AnU/edit?usp=sharing

## Prerequisites:

1. Git
2. Maven
3. Java JDK 17+
4. PostgreSQL

## Steps to run a project:

0. Set environment variables:
    ####     0.1 Database password
        export DB_PASSWORD="your_password"
    #### 0.2 Api keys
        # PATH: database-labs/final-project/oauth_sql/src/main/resources/application.properties
            osu.client.id=your_client_id
            osu.client.secret=your_client_secret
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
