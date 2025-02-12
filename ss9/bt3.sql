use classicmodels;

EXPLAIN ANALYZE SELECT * FROM customers WHERE country = 'Germany';

CREATE INDEX idx_country ON customers(country);

DROP INDEX idx_country ON customers;
