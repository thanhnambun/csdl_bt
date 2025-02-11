create database thuchanh;
use thuchanh;
create table tbl_users(
	user_id int primary key auto_increment,
    user_name varchar(50) not null,
    user_fullname varchar(100) not null,
    email varchar(100) not null unique,
    user_address varchar(255),
    user_phone varchar(20) not null unique
);

create table tbl_employees(
	emp_id  char(5) primary key,
    user_id int,
    emp_position varchar(50),
    emp_hire_date date,
    salary decimal(10,2) not null check(salary >0),
    emp_status bit,
    foreign key (user_id) references tbl_users(user_id)
);

create table tbl_orders(
	order_id int primary key auto_increment,
    user_id int,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_total_amount decimal(10,2)
);

create table tbl_products(
	pro_id char(5) primary key,
    pro_name varchar(100) unique  not null,
    pro_price decimal(10,2) not null check(pro_price >0),
    pro_quantity int not null default 0,
    status ENUM('còn hàng', 'hết hàng') DEFAULT 'còn hàng'  -- Trạng thái sản phẩm, mặc định là 'còn hàng'
);

create table tbl_order_detail(
	order_detail_id int primary key auto_increment,
    order_id int,
    pro_id char(5),
    order_detail_quantity int not null default 0,
    order_detail_price decimal(10,2) not null check(order_detail_price>0),
    FOREIGN KEY (order_id) REFERENCES tbl_orders(order_id),
    FOREIGN KEY (pro_id) REFERENCES tbl_products(pro_id)
);

-- Thêm cột trạng thái đơn hàng vào bảng tbl_orders
ALTER TABLE tbl_orders ADD COLUMN order_status ENUM('Pending', 'Processing', 'Completed', 'Cancelled') DEFAULT 'Pending';

-- Đổi kiểu dữ liệu cột số điện thoại trong users
ALTER TABLE tbl_users MODIFY COLUMN user_phone VARCHAR(11);

-- Xóa cột email khỏi bảng users
ALTER TABLE tbl_users DROP COLUMN email;

INSERT INTO tbl_users (user_name, user_fullname, user_address, user_phone) VALUES
('john_doe', 'John Doe', '123 Main St', '01234567891'),
('jane_smith', 'Jane Smith', '456 Oak St', '09876543210'),
('alice_wong', 'Alice Wong', '789 Pine St', '03456789123');

INSERT INTO tbl_employees (emp_id, user_id, emp_position, emp_hire_date, salary) VALUES
('E0001', 1, 'Quản lý', '2023-01-01', 1500.00);

INSERT INTO tbl_products (pro_id, pro_name, pro_price, pro_quantity) VALUES
('P0001', 'Laptop Dell', 1000.00, 10),
('P0002', 'Bàn phím cơ', 50.00, 30),
('P0003', 'Chuột gaming', 25.00, 50);

INSERT INTO tbl_orders (user_id, order_total_amount, order_status) VALUES
(2, 1050.00, 'Completed'),
(3, 75.00, 'Processing');

INSERT INTO tbl_order_detail (order_id, pro_id, order_detail_quantity, order_detail_price) VALUES
(1, 'P0001', 1, 1000.00),
(1, 'P0002', 1, 50.00),
(2, 'P0003', 3, 25.00);

INSERT INTO tbl_users (user_name, user_fullname, user_address, user_phone) VALUES
('peter_parker', 'Peter Parker', 'Queens, NY', '01234567892'),
('tony_stark', 'Tony Stark', 'Malibu, CA', '01234567893'),
('bruce_wayne', 'Bruce Wayne', 'Gotham City', '01234567894'),
('steve_rogers', 'Steve Rogers', 'Brooklyn, NY', '01234567895'),
('natasha_romanoff', 'Natasha Romanoff', 'Moscow, Russia', '01234567896'),
('clark_kent', 'Clark Kent', 'Metropolis', '01234567897'),
('diana_prince', 'Diana Prince', 'Themyscira', '01234567898'),
('barry_allen', 'Barry Allen', 'Central City', '01234567899');

INSERT INTO tbl_employees (emp_id, user_id, emp_position, emp_hire_date, salary) VALUES
('E0002', 4, 'Nhân viên bán hàng', '2022-05-10', 1200.00),
('E0003', 5, 'Quản lý kho', '2021-08-15', 2000.00),
('E0004', 6, 'Nhân viên kỹ thuật', '2023-02-01', 1300.00),
('E0005', 7, 'Nhân viên hỗ trợ', '2020-12-20', 1100.00 ),
('E0006', 8, 'Nhân viên bảo trì', '2019-06-05', 1000.00 );

INSERT INTO tbl_products (pro_id, pro_name, pro_price, pro_quantity) VALUES
('P0004', 'MacBook Pro 14', 2000.00, 15),
('P0005', 'iPhone 14 Pro', 1200.00, 30),
('P0006', 'Samsung Galaxy S23', 1100.00, 25),
('P0007', 'PlayStation 5', 500.00, 20),
('P0008', 'Xbox Series X', 550.00, 15),
('P0009', 'iPad Pro M2', 1300.00, 10),
('P0010', 'Logitech MX Master 3', 100.00, 40),
('P0011', 'Razer BlackWidow V3', 150.00, 35);

INSERT INTO tbl_orders (user_id, order_total_amount, order_status) VALUES
(2, 2200.00, 'Completed'),
(3, 1100.00, 'Pending'),
(4, 1600.00, 'Processing'),
(5, 500.00, 'Completed'),
(6, 1300.00, 'Cancelled'),
(7, 650.00, 'Completed'),
(8, 1450.00, 'Pending'),
(2, 700.00, 'Processing');

INSERT INTO tbl_order_detail (order_id, pro_id, order_detail_quantity, order_detail_price) VALUES
(3, 'P0004', 1, 2000.00),
(3, 'P0005', 1, 1200.00),
(4, 'P0006', 1, 1100.00),
(5, 'P0007', 1, 500.00),
(6, 'P0009', 1, 1300.00),
(7, 'P0010', 3, 100.00),
(8, 'P0011', 2, 150.00),
(1, 'P0002', 1, 50.00),
(2, 'P0003', 3, 25.00),
(2, 'P0008', 1, 550.00);

SELECT order_id, order_date, order_total_amount, order_status 
FROM tbl_orders;

select u.user_fullname
from tbl_users u 
join tbl_orders o on u.user_id = o.user_id;

select p.pro_name, count(od.order_detail_quantity)
from tbl_products p
join tbl_order_detail od on p.pro_id = od.pro_id
group by p.pro_id;

select u.user_fullname, count(o.order_id)
from tbl_users u 
join tbl_orders o on u.user_id = o.user_id
group by u.user_id
having count(o.order_id) >1;

select u.user_fullname, sum(o.order_total_amount)
from tbl_users u 
join tbl_orders o on u.user_id = o.user_id
group by u.user_id
order by sum(o.order_total_amount) desc
limit 5 ;

select u.user_name ,e.emp_position , count(o.order_id) as totalOrder  
from tbl_employees e 
join tbl_users u on u.user_id = e.user_id
left join tbl_orders o on o.user_id = e.user_id
group by e.emp_id,u.user_name;

SELECT u.user_fullname,o.order_total_amount AS max_order
FROM tbl_orders o
JOIN tbl_users u ON o.user_id = u.user_id
where o.order_total_amount= (select max(o2.order_total_amount) from tbl_orders o2);

select p.pro_id ,p.pro_name, (p.pro_quantity-od.order_detail_quantity) as stock_exists_quantity
from tbl_products p
left join tbl_order_detail od on p.pro_id = od.pro_id