 CREATE database TEST1;
 USE TEST1;
select version();
select curdate();
create table SanPham(
	MaSP Int,
    TenSP varchar(100) NOT NULL,
    GiaBan DECIMAL(10, 2) not null,
    SoLuong int,
    PRIMARY KEY (MaSP)
)

SELECT * FROM SanPham