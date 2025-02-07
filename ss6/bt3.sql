use ss6;

select max(price) as MaxPrice, min(price) as MinPrice
from Orders;

select CustomerName, count(OrderID) as OrderCount
from Orders
group by CustomerName ;

SELECT 
    MIN(OrderDate) AS EarliestDate,
    MAX(OrderDate) AS LatestDate
FROM Orders;
