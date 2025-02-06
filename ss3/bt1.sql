create database ss3;
use ss3;
create table Student(
	student_id int not null ,
    student_name varchar(255) not null,
    age int check(age>=18) not null ,
    gender varchar(10) check(gender in ('male', 'female', 'other')) not null,
    registration_date datetime default current_timestamp not null,
    primary key(student_id)
);
insert into Student(student_id,student_name,age,gender,registration_date)
values 
(1,'nguyễn văn a',20,'male','2025-01-15 08:30:00'),
(2,'nguyễn thi b',22,'female','2022-01-15 08:30:00'),
(3,'nguyễn minh c',19,'male','2025-01-15 08:30:00');
select * from Student;

