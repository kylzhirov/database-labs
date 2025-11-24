-- create data
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    faculty VARCHAR(100)
);

-- insert data
INSERT INTO students (name, email) VALUES
    (1, 'Alymbek', 'alymbek@example.com', 'AMI'),
    (2, 'Timur', 'timur@example.com', 'SFW'),
    (3, 'Beka', 'beka@example.com', 'SFW');


-- View data
SELECT * FROM students;

DROP TABLE students;
