create index idx_creaditLimit on customers(creditLimit );

EXPLAIN ANALYZE
select c.customerNumber,c.customerName,creditLimit, c.city,c.creditLimit,o.country
from employees e 
join customers c on e. employeeNumber = c.salesRepEmployeeNumber
join offices o on e.officeCode = o.officeCode
where creditLimit between 50000 and 100000
order by creditLimit desc
limit 5;
