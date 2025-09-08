COPY Students(first_name, last_name, birth_date)
FROM '/home/CoHHa9_MyXa/geass/database-labs/sql-files/students.csv'
DELIMITER ','
CSV HEADER;
