CREATE DATABASE BT5;
USE BT5;
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    PhoneNumber VARCHAR(11) NOT NULL,
    PRIMARY KEY (CustomerID)
);

CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY,
    InvoiceDate DATE,
    CustomerID INT,
    PRIMARY KEY (InvoiceID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
