use classicmodels;

select orderNumber, orderDate,status
from orders 
where year(orderDate) = 2003 and status = 'Shipped';

EXPLAIN ANALYZE SELECT * FROM idx_orderDate_status ;

create index idx_orderDate_status on orders(orderDate,status);

EXPLAIN ANALYZE SELECT * FROM idx_orderDate_status ;

select customerNumber, customerName,phone
from customers 
where phone = '2035552570';

EXPLAIN ANALYZE SELECT * FROM customers ;

CREATE UNIQUE INDEX idx_customerNumber ON customers(phocustomerNumberne);

CREATE UNIQUE INDEX idx_phone ON customers(phone);

EXPLAIN ANALYZE SELECT * FROM idx_customerNumber  ;
EXPLAIN ANALYZE SELECT * FROM idx_phone  ;

DROP INDEX idx_order  ON orders;

DROP INDEX Date_status  ON orders;

DROP INDEX idx_customerNumber   ON customers;

DROP INDEX idx_phone   ON customers;