create database ss11_2;
use ss11_2;

CREATE TABLE Album
(
    AlbumId INT NOT NULL,
    Title VARCHAR(160) CHARACTER SET utf8mb4 NOT NULL,
    ArtistId INT NOT NULL,
    CONSTRAINT PK_Album PRIMARY KEY (AlbumId)
);

CREATE TABLE Artist
(
    ArtistId INT NOT NULL,
    Name VARCHAR(120) CHARACTER SET utf8mb4,
    CONSTRAINT PK_Artist PRIMARY KEY (ArtistId)
);

CREATE TABLE Customer
(
    CustomerId INT NOT NULL,
    FirstName VARCHAR(40) CHARACTER SET utf8mb4 NOT NULL,
    LastName VARCHAR(20) CHARACTER SET utf8mb4 NOT NULL,
    Company VARCHAR(80) CHARACTER SET utf8mb4,
    Address VARCHAR(70) CHARACTER SET utf8mb4,
    City VARCHAR(40) CHARACTER SET utf8mb4,
    State VARCHAR(40) CHARACTER SET utf8mb4,
    Country VARCHAR(40) CHARACTER SET utf8mb4,
    PostalCode VARCHAR(10) CHARACTER SET utf8mb4,
    Phone VARCHAR(24) CHARACTER SET utf8mb4,
    Fax VARCHAR(24) CHARACTER SET utf8mb4,
    Email VARCHAR(60) CHARACTER SET utf8mb4 NOT NULL,
    SupportRepId INT,
    CONSTRAINT PK_Customer PRIMARY KEY (CustomerId)
);

CREATE TABLE Employee
(
    EmployeeId INT NOT NULL,
    LastName VARCHAR(20) CHARACTER SET utf8mb4 NOT NULL,
    FirstName VARCHAR(20) CHARACTER SET utf8mb4 NOT NULL,
    Title VARCHAR(30) CHARACTER SET utf8mb4,
    ReportsTo INT,
    BirthDate DATETIME,
    HireDate DATETIME,
    Address VARCHAR(70) CHARACTER SET utf8mb4,
    City VARCHAR(40) CHARACTER SET utf8mb4,
    State VARCHAR(40) CHARACTER SET utf8mb4,
    Country VARCHAR(40) CHARACTER SET utf8mb4,
    PostalCode VARCHAR(10) CHARACTER SET utf8mb4,
    Phone VARCHAR(24) CHARACTER SET utf8mb4,
    Fax VARCHAR(24) CHARACTER SET utf8mb4,
    Email VARCHAR(60) CHARACTER SET utf8mb4,
    CONSTRAINT PK_Employee PRIMARY KEY (EmployeeId)
);

CREATE TABLE Genre
(
    GenreId INT NOT NULL,
    Name VARCHAR(120) CHARACTER SET utf8mb4,
    CONSTRAINT PK_Genre PRIMARY KEY (GenreId)
);

CREATE TABLE Invoice
(
    InvoiceId INT NOT NULL,
    CustomerId INT NOT NULL,
    InvoiceDate DATETIME NOT NULL,
    BillingAddress VARCHAR(70) CHARACTER SET utf8mb4,
    BillingCity VARCHAR(40) CHARACTER SET utf8mb4,
    BillingState VARCHAR(40) CHARACTER SET utf8mb4,
    BillingCountry VARCHAR(40) CHARACTER SET utf8mb4,
    BillingPostalCode VARCHAR(10) CHARACTER SET utf8mb4,
    Total NUMERIC(10,2) NOT NULL,
    CONSTRAINT PK_Invoice PRIMARY KEY (InvoiceId)
);

CREATE TABLE InvoiceLine
(
    InvoiceLineId INT NOT NULL,
    InvoiceId INT NOT NULL,
    TrackId INT NOT NULL,
    UnitPrice NUMERIC(10,2) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_InvoiceLine PRIMARY KEY (InvoiceLineId)
);

CREATE TABLE MediaType
(
    MediaTypeId INT NOT NULL,
    Name VARCHAR(120) CHARACTER SET utf8mb4,
    CONSTRAINT PK_MediaType PRIMARY KEY (MediaTypeId)
);

CREATE TABLE Playlist
(
    PlaylistId INT NOT NULL,
    Name VARCHAR(120) CHARACTER SET utf8mb4,
    CONSTRAINT PK_Playlist PRIMARY KEY (PlaylistId)
);

CREATE TABLE PlaylistTrack
(
    PlaylistId INT NOT NULL,
    TrackId INT NOT NULL,
    CONSTRAINT PK_PlaylistTrack PRIMARY KEY (PlaylistId, TrackId)
);

CREATE TABLE Track
(
    TrackId INT NOT NULL,
    Name VARCHAR(200) CHARACTER SET utf8mb4 NOT NULL,
    AlbumId INT,
    MediaTypeId INT NOT NULL,
    GenreId INT,
    Composer VARCHAR(220) CHARACTER SET utf8mb4,
    Milliseconds INT NOT NULL,
    Bytes INT,
    UnitPrice NUMERIC(10,2) NOT NULL,
    CONSTRAINT PK_Track PRIMARY KEY (TrackId)
);

ALTER TABLE Album 
ADD CONSTRAINT FK_Album_Artist 
FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId);

ALTER TABLE Track 
ADD CONSTRAINT FK_Track_Album 
FOREIGN KEY (AlbumId) REFERENCES Album(AlbumId),
ADD CONSTRAINT FK_Track_Genre 
FOREIGN KEY (GenreId) REFERENCES Genre(GenreId),
ADD CONSTRAINT FK_Track_MediaType 
FOREIGN KEY (MediaTypeId) REFERENCES MediaType(MediaTypeId);

ALTER TABLE PlaylistTrack 
ADD CONSTRAINT FK_PlaylistTrack_Track 
FOREIGN KEY (TrackId) REFERENCES Track(TrackId);

ALTER TABLE Invoice 
ADD CONSTRAINT FK_Invoice_Customer 
FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId);

ALTER TABLE InvoiceLine 
ADD CONSTRAINT FK_InvoiceLine_Invoice 
FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId);

create view View_Album_Artist 
as select ab.AlbumId,ab.Title,a.Name
from album ab
join artist a on a. ArtistId = ab.ArtistId ;

create view View_Customer_Spending 
as select c.CustomerId ,c.FirstName ,c.LastName,c.Email ,sum(i.total) as Total_Spending 
from Customer c
join Invoice i on i.CustomerId = c.CustomerId
group by c.CustomerId;

create index idx_Employee_LastName on Employee(LastName);
EXPLAIN SELECT * FROM Employee WHERE LastName = 'King';

delimiter // 
	create procedure GetTracksByGenre (GenreId_in int)
    begin
		select t.trackid, t.name , ab.title,a.name
        from album ab
		join artist a on a. ArtistId = ab.ArtistId 
        join track t on t.albumid = ab.albumid
        where t.GenreId=GenreId_in;
    end; 

// delimiter ; 

call GetTracksByGenre(1)

delimiter // 
	create procedure GetTrackCountByAlbum (p_AlbumId int )
    begin	
			select count(t.TrackId)
            from track t 
            join album ab on ab.AlbumId = t.AlbumId
            where ab.AlbumId = p_AlbumId
            group by ab.AlbumId;
    end;
// delimiter ;

call GetTrackCountByAlbum(1);

drop view View_Album_Artist;
drop view View_Customer_Spending;
drop index idx_Employee_LastName on Employee;
drop procedure GetTracksByGenre;
drop procedure GetTrackCountByAlbum;

