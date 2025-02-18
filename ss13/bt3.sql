INSERT INTO company_funds (balance) VALUES (50000.00);

INSERT INTO employees (emp_name, salary) VALUES
('Nguyễn Văn An', 5000.00),
('Trần Thị Bốn', 4000.00),
('Lê Văn Cường', 3500.00),
('Hoàng Thị Dung', 4500.00),
('Phạm Văn Em', 3800.00);


set autocommit = 0;
delimiter // 
	create procedure transaction_moneys (emp_id_in int , fund_id_in int)
    begin 
		declare com_balance decimal;
        declare com_salary decimal;
		start transaction;
        if(select count(emp_id) from employees where emp_id = emp_id_in ) = 0
			or(select count(fund_id) from company_funds where fund_id=fund_id_int) = 0 then 
				insert into transaction_log(log_message)
					value('mã nhân viên không tồn tại ');
                    rollback;
		else
			select balance into com_balance from company_funds where fund_id=fund_id_int;
            select salary into com_salary from employees where emp_id = emp_id_in;
            if com_balance < com_salary then
				insert into transaction_log(log_message)
					value('số tiền không đủ  ');
                    rollback;
             else 
				update company_funds
                set balance = balance -com_salary
                WHERE fund_id = fund_id_in;
                
                INSERT INTO payroll (emp_id, salary, pay_date)
				VALUES (emp_id_in, com_salary, CURDATE());
				commit;
                end if;
        end if;
    end;
// delimiter ; 

CALL transaction_moneys(1, 1);
SELECT * FROM payroll;
SELECT * FROM company_funds;