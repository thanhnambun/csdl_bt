use ss5 ;

SELECT product_name, category, price, stock_quantity
FROM products
GROUP BY category;

SELECT product_name, category, price, stock_quantity
FROM products
limit 2 offset 2;

SELECT product_name, category, price, stock_quantity
FROM products
where category = 'Electronics'
order by price asc;

SELECT product_name, category, price, stock_quantity
FROM products
WHERE category = 'Clothing'
ORDER BY price ASC
LIMIT 1;