create index idx_productLine on products(productLine );

create view view_highest_priced_products  
as select productLine,productName,max(MSRP) 
from products 
group by productLine;

select productLine,productName,max(MSRP) 
from view_highest_priced_products 
group by productLine;

select v.productLine,v.productName,max(v.MSRP) , p.textDescription
from view_highest_priced_products v
join productlines p on p.productLine = v.productLine
group by productLine
order by max(v.MSRP) desc
limit 10;
