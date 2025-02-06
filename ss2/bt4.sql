USE TEST1;
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    StartDate DATE ,
    Salary int default 5000,
    PRIMARY KEY (EmployeeID)
);
