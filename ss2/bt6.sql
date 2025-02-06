use test1;
insert into Employee(EmployeeID, FullName, StartDate, Salary)
values 
(1, 'Nam', '2008-01-16', 5000),
(2, 'Nam1', '2008-01-16', 6000),
(3, 'Nam2', '2000-01-16', 7000);

SELECT * FROM Employee;

update Employee
set Salary = 7000
where EmployeeID = 1;

delete from Employee
where EmployeeID = 3;
