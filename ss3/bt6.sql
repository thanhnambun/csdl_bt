create table Book(
	book_id int auto_increment,
    title varchar(255) not null ,
    price decimal(10,2) not null,
    stock int not null,
    primary key(book_id)
);

INSERT INTO Book (title, price, stock)

VALUES

('To Kill a Mockingbird', 120.00, 10),

('1984', 90.00, 3),

('The Great Gatsby', 150.00, 20),

('Moby Dick', 200.00, 5),

('Pride and Prejudice', 50.00, 8);

select * from Book ;

select * from Book where price = 1000;
delete from book where  title like '%Pride%';
