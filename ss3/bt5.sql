use ss3;
create table Employees(
	employee_id int auto_increment,
    employee_name varchar(255) not null,
    employee_email varchar(255) not null unique,
    department varchar(255) not null,
    salary decimal(10,2) check(salary > 0),
	primary key(employee_id)
);

INSERT INTO Employees 
VALUES 
(1,'Nguyen Van A', 'nguyenvana@example.com', 'Sales', 50000), 
(2,'Le Thi B', 'lethib@example.com', 'IT', 60000), 
(3,'Tran Van C', 'tranvanc@example.com', 'HR', 45000), 
(4,'Pham Thi D', 'phamthid@example.com', 'Marketing', 55000);


select * from employees where department = 'Sales';
 update Employees
 set salary = salary*1.1
 where department = 'Marketing';
 
select * from employees where department = 'Marketing';