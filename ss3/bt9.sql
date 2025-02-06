create table Customers (
	customer_id int auto_increment,
	name_customer varchar(255) not null,
    email_customer varchar(255) not null ,
    phone varchar(255)not null,
    primary key (customer_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('Pending', 'Shipped', 'Completed', 'Cancelled') NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

INSERT INTO Customers (name_customer, email, phone)

VALUES

('Nguyen Van A', 'nguyenvana@example.com', '1234567890'),

('Tran Thi B', 'tranthib@example.com', '0987654321'),

('Le Van C', 'levanc@example.com', '0912345678'),

('Pham Thi D', 'phamthid@example.com', '0898765432'),

('Hoang Van E', 'hoangvane@example.com', '0812345678'); 

 

INSERT INTO Orders (order_date, total_amount, status_oders, customer_id)

VALUES

('2025-01-01', 200.00, 'Pending', 1),

('2025-01-02', 150.50, 'Shipped', 1),

('2025-01-03', 300.75, 'Completed', 2),

('2025-01-04', 450.00, 'Pending', 3),

('2025-01-05', 120.00, 'Cancelled', 2),

('2025-01-06', 99.99, 'Pending', 4),

('2025-01-07', 75.50, 'Shipped', 4),

('2025-01-08', 500.00, 'Completed', 3),

('2025-01-09', 60.00, 'Pending', 1),

('2025-01-10', 250.00, 'Completed', 3);

update customers
set phone = '0000000000'
where name_customer like 'Nguyen%';

DELETE FROM Customers 
WHERE customer_id IN (
    SELECT c.customer_id
    FROM Customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
    HAVING COALESCE(SUM(o.total_amount), 0) < 100
);
UPDATE Orders 
SET status = 'Cancelled' 
WHERE total_amount < 50 AND status = 'Pending';

