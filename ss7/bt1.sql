create database ss7;
use ss7;
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publication_year INT,
    available_quantity INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Readers (
    reader_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Borrowing (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    reader_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Returning (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    borrow_id INT UNIQUE,
    return_date DATE NOT NULL,
    FOREIGN KEY (borrow_id) REFERENCES Borrowing(borrow_id)
);

CREATE TABLE Fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    return_id INT,
    fine_amount DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (return_id) REFERENCES Returning(return_id)
);

INSERT INTO Categories (category_name) VALUES
('Science'), ('Literature'), ('History'), ('Technology'), ('Psychology');

INSERT INTO Books (title, author, publication_year, available_quantity, category_id) VALUES
('The History of Vietnam', 'John Smith', 2001, 10, 1),
('Python Programming', 'Jane Doe', 2020, 5, 4),
('Famous Writers', 'Emily Johnson', 2018, 7, 2),
('Machine Learning Basics', 'Michael Brown', 2022, 3, 4),
('Psychology and Behavior', 'Sarah Davis', 2019, 6, 5);

INSERT INTO Readers (name, phone_number, email) VALUES
('Alice Williams', '123-456-7890', 'alice.williams@email.com'),
('Bob Johnson', '987-654-3210', 'bob.johnson@email.com'),
('Charlie Brown', '555-123-4567', 'charlie.brown@email.com');

INSERT INTO Borrowing (reader_id, book_id, borrow_date, due_date) VALUES
(1, 1, '2025-02-19', '2025-02-15'),
(2, 2, '2025-02-03', '2025-02-17'),
(3, 3, '2025-02-02', '2025-02-16'),
(1, 2, '2025-03-10', '2025-02-24'),
(2, 3, '2025-05-11', '2025-02-25'),
(2, 3, '2025-02-11', '2025-02-25');

INSERT INTO Returning (borrow_id, return_date) VALUES
(1, '2025-03-14'),
(2, '2025-02-28'),
(3, '2025-02-15'),
(4, '2025-02-20'),
(5, '2025-02-20');

INSERT INTO Fines (return_id, fine_amount) VALUES
(1, 5.00),
(2, 0.00),
(3, 2.00);

UPDATE Readers SET name = 'Nguyễn Văn An' WHERE reader_id = 1;

DELETE FROM Books WHERE book_id = 2;
