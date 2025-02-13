create view EmployeeBranch 
as select e.EmployeeID,e.FullName,e.Position,e.Salary,b.BranchName,b.Location
from employees e 
join branch b on b.BranchID = e.BranchID;

create view HighSalaryEmployees
as select EmployeeID ,FullName,Position,Salary
from employees
where Salary > 15000000
with check option;

select * from EmployeeBranch;
select * from HighSalaryEmployees ; 

DROP VIEW IF EXISTS EmployeeBranch;
ALTER TABLE Employees ADD PhoneNumber VARCHAR(15);
CREATE VIEW EmployeeBranch AS
SELECT e.EmployeeID, e.Name, e.Department, e.PhoneNumber, b.BranchName
FROM Employees e
JOIN Branches b ON e.BranchID = b.BranchID;

delete from EmployeeBranch where BranchName ='Chi nhánh Hà Nội';
select * from  Employees;

-- thay đổi dữ liệu của bảng view thì cũng thay đổi dữ liệu của bảng dữ liệu gốc 