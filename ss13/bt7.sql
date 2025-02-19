
USE ss13;

CREATE TABLE company_funds (
    fund_id INT PRIMARY KEY AUTO_INCREMENT,
    balance DECIMAL(15,2) NOT NULL,
    bank_id INT,
    CONSTRAINT fk_company_funds_bank FOREIGN KEY (bank_id) REFERENCES bank(bank_id)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL, 
    salary DECIMAL(10,2) NOT NULL,
    last_pay_date DATE NULL    
);

CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,                     
    salary DECIMAL(10,2) NOT NULL,   
    pay_date DATE NOT NULL,          
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE transaction_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_message VARCHAR(255) NOT NULL,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bank (
    bank_id INT AUTO_INCREMENT PRIMARY KEY,
    bank_name VARCHAR(255) NOT NULL,
    status ENUM('ACTIVE', 'ERROR') NOT NULL DEFAULT 'ACTIVE'
);

INSERT INTO company_funds (balance, bank_id) VALUES (50000.00, 1);
INSERT INTO employees (emp_name, salary) VALUES
('Nguyễn Văn An', 5000.00),
('Trần Thị Bốn', 4000.00),
('Lê Văn Cường', 3500.00),
('Hoàng Thị Dung', 4500.00),
('Phạm Văn Em', 3800.00);

INSERT INTO bank (bank_id, bank_name, status) VALUES 
(1,'VietinBank', 'ACTIVE'),   
(2,'Sacombank', 'ERROR'),    
(3, 'Agribank', 'ACTIVE');   

DELIMITER //

CREATE TRIGGER CheckBankStatus
BEFORE INSERT ON payroll
FOR EACH ROW
BEGIN
    DECLARE v_bank_status VARCHAR(20);
    SELECT b.status INTO v_bank_status 
    FROM company_funds cf
    JOIN bank b ON cf.bank_id = b.bank_id
    WHERE cf.bank_id = (SELECT bank_id FROM company_funds WHERE fund_id = 1)
    LIMIT 1;
    
    IF v_bank_status = 'ERROR' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Ngân hàng đang gặp sự cố.';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE TransferSalary(IN p_emp_id INT)
BEGIN
    DECLARE v_salary DECIMAL(10,2);
    DECLARE v_balance DECIMAL(10,2);
    DECLARE v_bank_status VARCHAR(20);
    DECLARE v_company_bank_id INT;
    DECLARE v_employee_exists INT DEFAULT 0;
    DECLARE v_error_message VARCHAR(255);

    START TRANSACTION;

    SELECT COUNT(*) INTO v_employee_exists FROM employees WHERE emp_id = p_emp_id;
    IF v_employee_exists = 0 THEN
        SET v_error_message = 'Lỗi: Nhân viên không tồn tại.';
        INSERT INTO transaction_log (log_message) VALUES (v_error_message);
        ROLLBACK;
    END IF;

    SELECT cf.balance, cf.bank_id, b.status INTO v_balance, v_company_bank_id, v_bank_status
    FROM company_funds cf
    JOIN bank b ON cf.bank_id = b.bank_id
    WHERE cf.bank_id = (SELECT bank_id FROM company_funds WHERE fund_id = 1)
    LIMIT 1;

    IF v_bank_status = 'ERROR' THEN
        SET v_error_message = 'Ngân hàng có lỗi. Giao dịch bị hủy.';
        INSERT INTO transaction_log (log_message) VALUES (v_error_message);
        ROLLBACK;
    END IF;

    SELECT salary INTO v_salary FROM employees WHERE emp_id = p_emp_id;

    IF v_balance < v_salary THEN
        SET v_error_message = 'Quỹ công ty không đủ tiền.';
        INSERT INTO transaction_log (log_message) VALUES (v_error_message);
        ROLLBACK;
    END IF;

    UPDATE company_funds SET balance = balance - v_salary WHERE bank_id = v_company_bank_id;

    INSERT INTO payroll (emp_id, salary, pay_date) 
    VALUES (p_emp_id, v_salary, NOW());

    UPDATE employees SET last_pay_date = NOW() WHERE emp_id = p_emp_id;

    INSERT INTO transaction_log (log_message) 
    VALUES ('Lương đã được chuyển thành công cho nhân viên ' || p_emp_id);

    COMMIT;
END //

DELIMITER ;

CALL TransferSalary(1);

SELECT * FROM company_funds;
SELECT * FROM payroll;
SELECT * FROM employees;
SELECT * FROM transaction_log;
