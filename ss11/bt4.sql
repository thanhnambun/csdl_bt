DELIMITER //

CREATE PROCEDURE UpdateSalaryByID (
    IN EmployeeID_in INT, 
    OUT salaryUpdate DECIMAL(10,2)
)
BEGIN
    DECLARE currentSalary DECIMAL(10,2);

    SELECT Salary INTO currentSalary 
    FROM employees 
    WHERE EmployeeID = EmployeeID_in;

    IF currentSalary IS NOT NULL THEN
        IF currentSalary < 20000000 THEN
            SET salaryUpdate = currentSalary * 1.1;
        ELSE
            SET salaryUpdate = currentSalary * 1.05;
        END IF;

        UPDATE employees
        SET Salary = salaryUpdate
        WHERE EmployeeID = EmployeeID_in;
    ELSE
        SET salaryUpdate = NULL;
    END IF;
END 
// DELIMITER ;
set @salary =0;
CALL UpdateSalaryByID(1, @salary);
SELECT @salary; 


delimiter // 
	create procedure GetLoanAmountByCustomerID (CustomerID_in int , out sum_loanAmount decimal(10,2))
    begin
		select COALESCE(SUM(LoanAmount), 0) into sum_loanAmount
        from loans
        where CustomerID = CustomerID_in
        group by CustomerID;
    end;
// delimiter ; 
set @sum_loanAmount = 0;
call GetLoanAmountByCustomerID(1,@sum_loanAmount);
select @sum_loanAmount;

delimiter // 
	create procedure DeleteAccountIfLowBalance (AccountID_in int, out message VARCHAR(255) )
    begin
		DECLARE rowsAffected INT;
		delete from accounts where  AccountID = AccountID_in and Balance <1000000 ; 
		SET rowsAffected = ROW_COUNT();
		IF rowsAffected > 0 THEN
			SET message = CONCAT('Xóa thành công tài khoản có ID ', AccountID_in);
		ELSE
			SET message = CONCAT('Không thể xóa');
		END IF;
        end;
//delimiter ; 

CALL DeleteAccountIfLowBalance(1, @msg);
SELECT @msg; 

DELIMITER //

CREATE PROCEDURE TransferMoney (
    IN from_account INT, 
    IN to_account INT, 
    INOUT amount DECIMAL(10,2),
    OUT message VARCHAR(255)
)
BEGIN
    DECLARE from_exists INT DEFAULT 0;
    DECLARE to_exists INT DEFAULT 0;
    DECLARE balance_available DECIMAL(10,2);

    SELECT COUNT(accountid) INTO from_exists 
    FROM accounts 
    WHERE accountid = from_account;

    SELECT COUNT(accountid) INTO to_exists 
    FROM accounts 
    WHERE accountid = to_account;

    IF from_exists > 0 THEN
        SELECT balance INTO balance_available 
        FROM accounts 
        WHERE accountid = from_account;
    END IF;

    START TRANSACTION;
    IF from_exists = 0 THEN
        SET message = 'Tài khoản nguồn không tồn tại';
        ROLLBACK;
    ELSEIF to_exists = 0 THEN
        SET message = 'Tài khoản đích không tồn tại';
        ROLLBACK;
    ELSEIF balance_available < amount THEN
        SET message = 'Số dư không đủ';
        ROLLBACK;
    ELSE
        UPDATE accounts 
        SET balance = balance - amount 
        WHERE accountid = from_account;

        UPDATE accounts 
        SET balance = balance + amount 
        WHERE accountid = to_account;

        COMMIT;
        SET message = CONCAT('Chuyển thành công ', amount, ' từ tài khoản ', from_account, ' sang ', to_account);
    END IF;

END //

DELIMITER ;

set @amount = 2000000;
CALL TransferMoney(101, 202, @amount, @msg);
SELECT @amount;
 
drop procedure TransferMoney;
drop procedure DeleteAccountIfLowBalance;
drop procedure GetLoanAmountByCustomerID;
drop procedure UpdateSalaryByID;
