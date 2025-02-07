use ss6;

select CustomerName,ProductName,sum(Quantity) as TotalQuantity
from Orders
group by CustomerName ,ProductName
having sum(Quantity) >1;

select CustomerName ,OrderDate, sum(Quantity) as Quantity
from Orders
group by OrderDate , CustomerName
having Quantity >2;

select CustomerName ,OrderDate, sum(Quantity * Price) as TotalSpent
from Orders
group by OrderDate , CustomerName
having sum(Quantity * Price) > 20000000;