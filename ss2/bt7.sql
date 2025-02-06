use bt5;

create table Product (
    ProductID int PRIMARY KEY,
    primary key (ProductID)
);

create table InvoiceDetail (
    InvoiceID int,
    ProductID int,
    Quantity int not null CHECK (Quantity > 0),
    primary key (InvoiceID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
);

SELECT 
    InvoiceDetail.InvoiceID AS InvoiceID,
    Product.ProductID AS ProductID,
    InvoiceDetail.Quantity AS Quantity
FROM 
    InvoiceDetail
JOIN 
    Product ON InvoiceDetail.ProductID = Product.ProductID
ORDER BY 
    InvoiceDetail.InvoiceID;
