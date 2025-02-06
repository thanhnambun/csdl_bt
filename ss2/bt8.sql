create database bt8;
use bt8;
create table Grade (
	idPoint int ,
	idStudent varchar(20),
    pointStudent DECIMAL(3,1) CHECK (pointStudent BETWEEN 0 AND 10),
    primary key(idPoint),
    FOREIGN KEY (idStudent) REFERENCES Student(idStudent)
)
--  bảng bên trên ch có khóa chính và phần khóa ngoại chưa có câu lệnh để kết nối với bảng sinh viên thông qua phần idStudent , chưa có điều kiện của phẩn điểm và sai kiểu dữ liệu của điểm 
	