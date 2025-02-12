create view view_orders_summary 
as select 
			c.customerNumber ,
            c.customername,
            count(o.orderNumber) as total_orders 
from customers c
join orders o on o.customerNumber= c.customerNumber
group by c.customerNumber;

select 
			c.customerNumber ,
            c.customername,
            count(o.orderNumber) as total_orders 
from customers c
join orders o on o.customerNumber= c.customerNumber
group by c.customerNumber
having total_orders>3;