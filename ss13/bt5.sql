use ss13;
create table employees(
	emp_id int auto_increment primary key,
    emp_name varchar(50),
    salary decimal(10,2)
);

create table company_funds (
	fund_id int primary key auto_increment,
    balance decimal(15,2)
);

create table payroll(
	payroll_id int primary key ,
    emp_id int,
    salary decimal(10,2),
    pay_date date,
    foreign key (emp_id) references employees(emp_id)
);

create table  transaction_log (
	log_id int primary key auto_increment,
    log_message text not null,
    log_time timestamp default current_timestamp
)engine = 'MyISAM' ;

alter table transaction_log add column last_pay_date date;

set autocommit = 0;
delimiter // 
	create procedure tran_money (emp_id_in int , fund_id_in int)
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

				INSERT INTO transaction_log(log_message,last_pay_date )
				VALUES (CONCAT('Trả lương thành công cho nhân viên ', emp_id_in),CURDATE());
				commit;
                end if;
        end if;
    end;
// delimiter ; 

CALL tran_money(1, 1);
SELECT * FROM payroll;
SELECT * FROM company_funds;
SELECT * FROM transaction_log;
