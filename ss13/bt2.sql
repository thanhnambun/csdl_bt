CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    stock INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, price, stock) VALUES
('Laptop Dell', 1500.00, 10),
('iPhone 13', 1200.00, 8),
('Samsung TV', 800.00, 5),
('AirPods Pro', 250.00, 20),
('MacBook Air', 1300.00, 7);

set autocommit = 0;
drop procedure orders_procedure;
delimiter // 
 create procedure orders_procedure(p_product_id  int ,p_quantity int )
 begin 
	start transaction ;
    if (select stock from products where product_id = p_product_id) < p_quantity then 
		rollback;
	else 
		insert into orders(product_id,quantity,total_price)
        values (p_product_id,p_quantity,(select price from products where product_id = p_product_id )*p_quantity);
         
         update products
         set stock = stock-p_quantity
         where product_id = p_product_id ; 
         commit;
	end if;
 end;
// delimiter ;

call orders_procedure(1,2);

select * from orders;




