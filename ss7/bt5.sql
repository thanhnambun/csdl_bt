use ss7;

select b.title,b.author,c.category_name
from books b
join categories c on b.category_id = c.category_id
order by b.title;

select r.name, count(bo.borrow_id)
from Borrowing bo
join books b on b.book_id = bo.book_id
join readers r on bo.reader_id= r.reader_id
group by r.name;

SELECT 
    r.name AS reader_name, 
    avg(f.fine_amount)
FROM Readers r
JOIN Borrowing b ON r.reader_id = b.reader_id
JOIN Returning rt ON b.borrow_id = rt.borrow_id
JOIN Fines f ON rt.return_id = f.return_id
group by r.name;

SELECT title, available_quantity 
FROM Books 
WHERE available_quantity = (SELECT MAX(available_quantity) FROM Books);

SELECT 
    r.name AS reader_name, 
    f.fine_amount
FROM Readers r
JOIN Borrowing b ON r.reader_id = b.reader_id
JOIN Returning rt ON b.borrow_id = rt.borrow_id
JOIN Fines f ON rt.return_id = f.return_id
where f.fine_amount>0;

select b.title,count(bo.borrow_id)
from Borrowing bo
join books b on b.book_id = bo.book_id
group by b.title
order by count(bo.borrow_id) desc
limit 1;

SELECT b.title AS TenSach, r.name AS TenBanDoc, br.borrow_date AS NgayMuon
FROM Books b
JOIN Borrowing br ON b.book_id = br.book_id
JOIN Readers r ON br.reader_id = r.reader_id
LEFT JOIN Returning rt ON br.borrow_id = rt.borrow_id
WHERE rt.return_id IS NULL
ORDER BY br.borrow_date;

SELECT b.title AS TenSach, r.name AS TenBanDoc, br.due_date AS Ngaytra
FROM Books b
JOIN Borrowing br ON b.book_id = br.book_id
JOIN Readers r ON br.reader_id = r.reader_id
LEFT JOIN Returning rt ON br.borrow_id = rt.borrow_id
WHERE rt.return_id IS not NULL
ORDER BY br.borrow_date;

select b.title,b.publication_year,count(bo.borrow_id)
from books b
join Borrowing bo on b.book_id = bo.book_id
group by b.title,b.book_id
order by count(bo.borrow_id)
limit 1;
