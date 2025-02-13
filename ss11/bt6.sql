use sakila;

create view view_film_category
as select f.film_id,f.title,c.name
from film_category fc
join category c on c.category_id = fc.category_id 
join film f on f.film_id= fc.film_id;

create view view_high_value_customers 
as select c.customer_id , c.first_name,c.last_name, sum(p.amount) as total_payment 
from customer c 
join payment p on p.customer_id = c.customer_id
group by c.customer_id
having total_payment > 100 ;

create index idx_rental_rental_date  on rental (rental_date );
EXPLAIN SELECT * FROM rental WHERE rental_date = '2005-06-14';

delimiter // 
	create procedure CountCustomerRentals(customer_id_in int , out rental_count int  )
    begin
		select count(rental_id) into rental_count
        from rental
        where customer_id = customer_id_in
        group by customer_id;
        
    end ;
// delimiter ;
set @rental_count =0 ;
call CountCustomerRentals(1,@rental_count);
select @rental_count;

delimiter // 
	create procedure GetCustomerEmail (customer_id_in int )
    begin	
		select email 
        from customer 
        where customer_id = customer_id_in;
    end ;
// delimiter ;

call GetCustomerEmail(1);

drop view view_film_category;
drop view view_high_value_customers;
drop index idx_rental_rental_date on rental ;
drop procedure CountCustomerRentals ;
drop procedure GetCustomerEmail ;


