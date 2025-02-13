use ss11_2;

create view View_Track_Details 
as select t.name, ab.title,a.name,t.UnitPrice
        from album ab
		join artist a on a. ArtistId = ab.ArtistId 
        join track t on t.albumid = ab.albumid
        where t.UnitPrice > 0.99 ;
select * from View_Track_Details;

CREATE VIEW View_Customer_Invoice 
AS 
SELECT 
    c.CustomerId, 
    CONCAT(c.LastName, ' ', c.FirstName) AS Fullname,
    c.Email,
    COALESCE(SUM(i.Total), 0) AS Total_Spending,
    CONCAT(e.LastName, ' ', e.FirstName) AS Support_Rep
FROM customer c 
JOIN invoice i ON c.CustomerId = i.CustomerId
join employee e on c.SupportRepId = e.EmployeeId
GROUP BY c.CustomerId, c.LastName, c.FirstName, c.Email, s.LastName, s.FirstName;

select * from View_Customer_Invoice;

create view View_Top_Selling_Tracks  
as select t.TrackId,t.name,g.Name,count(il.InvoiceLineId) as Total_Sales 
from track t 
join genre g on t.GenreId = g.GenreId
join invoiceline il on t.TrackId = il.TrackId
GROUP BY t.TrackId, t.Name, g.Name
ORDER BY Total_Sales DESC;

select * from View_Top_Selling_Tracks;

CREATE INDEX idx_Track_Name ON Track(Name) USING BTREE;
SELECT * FROM Track WHERE Name LIKE '%Love%';
EXPLAIN SELECT * FROM Track WHERE Name LIKE '%Love%';

create index idx_Invoice_Total on Invoice(Total);
select total from invoice where Total between 20 and 100 ;
EXPLAIN select total from invoice where invoice between 20 and 100 ;

DELIMITER // 
CREATE PROCEDURE GetCustomerSpending (CustomerId_in INT)
BEGIN
    SELECT COALESCE(Total_Spending, 0)
    FROM View_Customer_Invoice
    WHERE CustomerId = CustomerId_in;
END;
// 
DELIMITER ;

call GetCustomerSpending(1)

delimiter // 
	create procedure SearchTrackByKeyword (p_Keyword varchar(100))
    begin 
		SELECT * FROM Track WHERE Name LIKE CONCAT('%', p_Keyword, '%');
    end;
// delimiter ;
CALL SearchTrackByKeyword('lo');

delimiter //
	create procedure GetTopSellingTracks (p_MinSales int, p_MaxSales int)
    begin 
		select * 
        from View_Top_Selling_Tracks
        where Total_Sales > p_MinSales and Total_Sales < p_MaxSales;
    end;
// delimiter ;

call GetTopSellingTracks(4,6);


DROP VIEW IF EXISTS View_Track_Details;
DROP VIEW IF EXISTS View_Customer_Invoice;
DROP VIEW IF EXISTS View_Top_Selling_Tracks;
DROP INDEX idx_Track_Name ON Track;
DROP INDEX idx_Invoice_Total ON Invoice;
DROP PROCEDURE IF EXISTS GetCustomerSpending;
DROP PROCEDURE IF EXISTS SearchTrackByKeyword;
DROP PROCEDURE IF EXISTS GetTopSellingTracks;




