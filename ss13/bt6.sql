create table enrollments_history (
	hisstory_id int auto_increment primary key,
    student_id int ,
    course_id INT,
    action varchar(50),
    timestamp datetime,
	FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
DELIMITER //

CREATE PROCEDURE subj_courses(
    IN p_student_name VARCHAR(50), 
    IN p_course_name VARCHAR(100)
)
BEGIN
    DECLARE v_student_id INT;
    DECLARE v_course_id INT;
    DECLARE v_available_seats INT;
    DECLARE v_enrolled INT;
    DECLARE v_action VARCHAR(50);

    SELECT student_id INTO v_student_id FROM students WHERE student_name = p_student_name LIMIT 1;

    SELECT course_id, available_seats INTO v_course_id, v_available_seats 
    FROM courses WHERE course_name = p_course_name LIMIT 1;

    IF v_student_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student not found';
    ELSEIF v_course_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Course not found';
    ELSE

        SELECT COUNT(*) INTO v_enrolled FROM enrollments 
        WHERE student_id = v_student_id AND course_id = v_course_id;

        START TRANSACTION;
        
        IF v_enrolled > 0 THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Already enrolled in this course';
        ELSEIF v_available_seats > 0 THEN
  
            INSERT INTO enrollments(student_id, course_id) 
            VALUES (v_student_id, v_course_id);
            
            UPDATE courses SET available_seats = available_seats - 1 WHERE course_id = v_course_id;
            
            SET v_action = 'Enrollment Success';
            INSERT INTO enrollments_history(student_id, course_id, action, timestamp)
            VALUES (v_student_id, v_course_id, v_action, NOW());

            COMMIT;
        ELSE
            SET v_action = 'Enrollment Failed - No Seats';
            INSERT INTO enrollments_history(student_id, course_id, action, timestamp)
            VALUES (v_student_id, v_course_id, v_action, NOW());
            ROLLBACK;
        END IF;
    END IF;
END;
// DELIMITER ;

CALL subj_courses('Nguyễn Văn An', 'Lập trình C');
SELECT * FROM enrollments;
SELECT * FROM courses;
SELECT * FROM enrollments_history;

