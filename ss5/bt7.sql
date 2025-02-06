use ss5 ;

SELECT s.name AS student_name, s.email, c.course_name, e.enrollment_date
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
WHERE s.email IS NULL OR e.enrollment_date BETWEEN '2025-01-12' AND '2025-01-18'
ORDER BY s.name ASC;

SELECT c.course_name, c.fee, s.name AS student_name, e.enrollment_date
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
LEFT JOIN students s ON e.student_id = s.student_id
WHERE c.fee > 1000000  OR e.course_id is null
ORDER BY c.fee desc , c.course_name asc ;

select 
    s.name as student_name, 
    s.email, 
    c.course_name, 
    e.enrollment_date
from students s
left join courses c on e.course_id = c.course_id
left join enrollments e on s.student_id = e.student_id
where s.email is null or c.fee > 1000000
order by s.name asc, c.course_name asc;

