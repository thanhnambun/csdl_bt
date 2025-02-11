INSERT INTO Departments (department_id, department_name, location) VALUES
(3, 'Finance', 'Building C');

INSERT INTO Employees (employee_id, name, dob, department_id, salary) VALUES
(3,'Alice Williams', '1985-06-15', 1, 5000.00),
( 4,'Bob Johnson', '1990-03-22', 2, 4500.00),
(5,'Charlie Brown', '1992-08-10', 1, 5500.00),
(6,'David Smith', '1988-11-30', NULL, 4700.00);

INSERT INTO Projects (project_id, project_name, start_date, end_date) VALUES
(3,'Project A', '2025-01-01', '2025-12-31'),
(4,'Project B', '2025-02-01', '2025-11-30');
-- Insert sample data into WorkReports table
INSERT INTO WorkReports (report_id, employee_id, report_date, report_content) VALUES
(1, 3, '2025-01-31', 'Completed initial setup for Project A.'),
(2, 4, '2025-02-10', 'Completed HR review for Project A.'),
(3, 5, '2025-01-20', 'Worked on debugging and testing for Project A.'),
(4, 6, '2025-02-05', 'Worked on financial reports for Project B.');

-- Insert sample data into Timesheets table
INSERT INTO Timesheets (timesheet_id, employee_id, project_id, work_date, hours_worked) VALUES
(3, 3, 3, '2025-01-10', 8),
(4, 4, 4, '2025-02-12', 7),
(5, 5, 3, '2025-01-15', 6),
(6, 6, 3, '2025-01-20', 8),
(7, 6, 4, '2025-02-05', 5);

select * from Employees;

select * from Projects;

select e.name, d.department_name from Employees e
join Departments d on d.department_id = e.department_id;

select e.name, w.report_content from Employees e
join WorkReports w on w.employee_id = e.employee_id;

select e.name, p.project_name, t.hours_worked from Employees e
join Timesheets t on t.employee_id = e.employee_id
join Projects p on p.project_id = t.project_id;

select e.name, t.hours_worked
from Employees e
join Timesheets t on e.employee_id = t.employee_id
join Projects p on t.project_id = p.project_id
where p.project_name = 'Project A';

update Employees 
set salary = 6500
where name like '%alice%';

delete from WorkReports 
where employee_id in (
    select employee_id from Employees 
    where name like '%Brown%'
);

insert into Employees (name, dob, department_id, salary) 
values ('James Lee', '1996-05-20', 1, 5000.00);