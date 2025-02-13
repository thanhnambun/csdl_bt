create index Single_column on  Customers(PhoneNumber);
EXPLAIN SELECT * FROM Customers WHERE PhoneNumber = '0901234567';

create index Composite  on Employees(BranchID ,Salary);
EXPLAIN SELECT * FROM Employees WHERE BranchID = 1 AND Salary > 20000000;

create index Unique_account on  accounts(AccountID ,CustomerID );

SHOW INDEX FROM Customers;
SHOW INDEX FROM Employees;
SHOW INDEX FROM Accounts;

DROP INDEX Single_column ON Customers;
DROP INDEX Composite ON Employees;
DROP INDEX Unique_account ON Accounts;


