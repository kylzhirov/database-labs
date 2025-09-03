-- -- find all courses for a specific student
SELECT c.course_code, c.course_name, c.credits, se.grade
FROM courses c
JOIN student_enrollments se ON c.course_id = se.course_id
JOIN students s ON se.student_id = s.student_id
WHERE s.email = 'alice@university.edu';
