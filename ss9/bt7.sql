create view view_customer_status 
as select 
			customerNumber, 
            customerName, 
            creditLimit, 
            case 
				when creditLimit > 100000 then 'High'
                when creditLimit BETWEEN 50000 AND 100000 THEN 'Medium'
                else'low'
            end as status
from customers;

select * from view_customer_status;
 select status ,count(customerNumber)
 from view_customer_status
 group by status
order by count(customerNumber) desc ;