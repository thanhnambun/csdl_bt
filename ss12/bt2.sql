create table price_changes(
	change_id int auto_increment primary key ,
    product varchar(100) not null,
    old_price decimal(10,2) not null,
    new_price decimal(10,2) not null 
);
 delimiter // 
	create trigger AFTER_UPDATE_price_changes
    after update on orders 
    FOR EACH ROW
    begin 
		insert into price_changes(product,old_price,new_price)
        values(	OLD.product,OLD.price,new.price);
    end
// delimiter ;

UPDATE orders
SET price = 810.00
WHERE product = 'Smartphone';

select* from price_changes;
show table status where name = 'orders';


