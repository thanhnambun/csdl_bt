create index idx_customerNumber on payments(customerNumber);

CREATE VIEW view_customer_payments AS
SELECT 
    customerNumber, 
    SUM(amount) AS total_payments, 
    COUNT(paymentDate) AS payment_count
FROM payments
GROUP BY customerNumber;

select * from view_customer_payments;

SELECT 
    c.customerNumber, 
    c.customerName, 
    c.country,
    v.total_payments, 
    v.payment_count,
   ( v.total_payments / v.payment_count) as avverage_payment,
    c.creditLimit
FROM view_customer_payments v
JOIN customers c ON v.customerNumber = c.customerNumber
WHERE v.total_payments > 150000 
AND v.payment_count > 3
ORDER BY v.total_payments DESC
LIMIT 5;

