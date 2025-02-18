create database ss13;
use ss13;
 
create table accounts(
	account_id int auto_increment primary key,
    account_name varchar(100),
    balance decimal(15,2)
);

INSERT INTO accounts (account_name, balance) VALUES 

('Nguyễn Văn An', 1000.00),

('Trần Thị Bảy', 500.00);

set autocommit = 0;
delimiter // 
	create procedure transaction__money(
		from_account int,
        to_account int,
        amount decimal,
        result_code int
    )
    begin
		start transaction ;
		if(select count(account_id) from accounts where account_id = from_account) = 0 
			or(select count(account_id) from accounts where account_id = to_account ) =0 then
			set result_code =1 ;
			rollback;
		else 
			update accounts
			set balance = balance - amount;
			if(select balance from accounts where account_id = from_account)< amount then 
				set result_code = 2;
				rollback ;
			else
				update accounts
				set balance = balance + amount
				where account_id = to_account ;
				SET result_code = 0;
				COMMIT;
				end if;
		end if;
    end;
    
// delimiter ;

CALL transaction_money(1, 2, 200, @result);
SELECT @result;






