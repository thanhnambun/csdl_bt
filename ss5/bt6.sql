
USE ss5;

CREATE TABLE Guests (
    GuestID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100),
    Gender ENUM('Nam', 'Nu')
);

CREATE TABLE Rooms (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    RoomNumber VARCHAR(10) NOT NULL,
    RoomType ENUM('Standard', 'Deluxe', 'Suite') NOT NULL,
    PricePerNight DECIMAL(10, 2) NOT NULL,
    Status ENUM('Available', 'Occupied', 'Reserved') NOT NULL
);

CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    GuestID INT NOT NULL,
    RoomID INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

INSERT INTO Guests (FullName, PhoneNumber, Email, Gender)
VALUES
    ('Nguyen Van A', '0901234567', 'nguyenvana@example.com', 'Nam'),
    ('Tran Thi B', '0912345678', 'tranthib@example.com', 'Nu'),
    ('Pham Van C', '0923456789', NULL, 'Nam'),
    ('Le Thi D', '0934567890', 'lethid@example.com', 'Nu');


INSERT INTO Rooms (RoomNumber, RoomType, PricePerNight, Status)
VALUES
    ('101', 'Standard', 500000, 'Available'),
    ('102', 'Deluxe', 1000000, 'Available'),
    ('201', 'Suite', 2000000, 'Available'),
    ('102', 'Deluxe', 1000000, 'Occupied'), 
    ('101', 'Standard', 500000, 'Reserved'); 

INSERT INTO Bookings (GuestID, RoomID, CheckInDate, CheckOutDate, TotalPrice)
VALUES
    (1, 2, '2025-01-10', '2025-01-12', 2000000), 
    (2, 3, '2025-01-15', '2025-01-18', 6000000), 
    (3, 1, '2025-01-20', '2025-01-22', 1000000), 
    (4, 2, '2025-01-18', '2025-01-20', 2000000), 
    (1, 1, '2025-01-23', '2025-01-25', 1000000); 

select g.fullname,g.email,r.roomtype, b.CheckInDate
from Bookings b
 join Guests g on b.GuestID= g.GuestID
 join Rooms r on b.RoomID = r.roomid
 WHERE r.RoomType = 'Deluxe'
AND b.CheckInDate BETWEEN '2025-01-01' AND '2025-01-31'
 order by CheckInDate asc
 limit 5;
 
select g.GuestID,r.RoomNumber,r.roomtype
from Bookings b
 join Guests g on b.GuestID= g.GuestID
 join Rooms r on b.RoomID = r.roomid
WHERE g.Email IS NOT NULL
ORDER BY r.RoomType ASC, r.RoomNumber ASC
LIMIT 5;

select g.fullname,g.email,g.PhoneNumber
from Bookings b
 join Guests g on b.GuestID= g.GuestID
 join Rooms r on b.RoomID = r.roomid
WHERE g.Email !='nu'
GROUP BY g.GuestID
HAVING COUNT(b.BookingID) >= 2;

select g.fullname,g.email,r.roomtype
from Bookings b
 join Guests g on b.GuestID= g.GuestID
 join Rooms r on b.RoomID = r.roomid
WHERE b.TotalPrice > 1000000 and g.PhoneNumber != '0901234567';