use ss13;
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    available_seats INT NOT NULL
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (student_name) VALUES ('Nguyễn Văn An'), ('Trần Thị Ba');

INSERT INTO courses (course_name, available_seats) VALUES 
('Lập trình C', 25), 
('Cơ sở dữ liệu', 22);


delimiter // 
	create procedure sub_courses(p_student_name varchar(50),p_course_name VARCHAR(100) )
    begin
		start transaction;
		if(select count(student_id) from students where student_name = p_student_name) =0 then
			rollback;
		else
			if(select available_seats from courses where course_name = p_course_name ) > 0 then 
			
				insert into enrollments(student_id,course_id)
				values((select student_id from students where student_name = p_student_name),
						(select course_id from courses where course_name = p_course_name));
				update courses
				set available_seats=available_seats-1
				where course_name = p_course_name;
				 commit;
			else 
				rollback;
			end if;
		end if;
    end;
// delimiter ;








