use ss5;

SELECT c.name, c.phone, o.order_id, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'Pending' AND o.total_amount > 300000;

select c.name, c.phone, o.order_id
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
where o.status = 'Completed' or o. status is NULL;

select c.name, c.address , o.order_id , o.status 
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
where o.status = 'Cancelled' or o. status ='Pending';

SELECT c.name, c.phone, o.order_id, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.total_amount BETWEEN 300000 AND 600000;