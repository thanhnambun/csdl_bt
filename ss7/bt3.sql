use ss7;

select *
from books;

select *
from readers;

select r.name,b.title,bo.borrow_date
from Borrowing bo
join books b on b.book_id = bo.book_id
join readers r on bo.reader_id= r.reader_id;

select b.title,b.author,c.category_name
from books b
join categories c on b.category_id = c.category_id;

SELECT 
    r.name AS reader_name, 
    f.fine_amount, 
    rt.return_date
FROM Readers r
JOIN Borrowing b ON r.reader_id = b.reader_id
JOIN Returning rt ON b.borrow_id = rt.borrow_id
JOIN Fines f ON rt.return_id = f.return_id;

UPDATE Books 
SET available_quantity = 15 
WHERE book_id = 1;

DELETE FROM Readers 
WHERE reader_id = 2;

INSERT INTO Readers (reader_id, name, phone_number, email) 
VALUES (2, 'Bob Johnson', '987-654-3210', 'bob.johnson@email.com');
