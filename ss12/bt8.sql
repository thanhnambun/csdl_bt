create table salary_history (
	history_id int auto_increment primary key ,
    emp_id int ,
    old_salary decimal(10,2) not null,
    new_salary decimal(10,2) not null,
    change_date datetime not null
);
create table salary_warnings (
	waring_id int auto_increment primary key,
    emp_id int not null,
    waring_mesage varchar(255) not null,
    warning_date datetime
);

DELIMITER //
CREATE TRIGGER after_update_salary
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE adjusted_salary DECIMAL(10,2);

    INSERT INTO salary_history (emp_id, old_salary, new_salary, change_date)
    VALUES (NEW.emp_id, OLD.salary, NEW.salary, NOW());

    IF NEW.salary < OLD.salary * 0.7 THEN
        INSERT INTO salary_warnings (emp_id, waring_mesage, warning_date)
        VALUES (NEW.emp_id, 'Salary decreased by more than 30%', NOW());
    END IF;

    IF NEW.salary > OLD.salary * 1.5 THEN
        SET adjusted_salary = OLD.salary * 1.5;

        UPDATE employees 
        SET salary = adjusted_salary
        WHERE emp_id = NEW.emp_id;

        INSERT INTO salary_warnings (emp_id, waring_mesage, warning_date)
        VALUES (NEW.emp_id, 'Salary increased above allowed threshold (adjusted to 150% of previous salary)', NOW());
    END IF;
END;
//
DELIMITER ;

delimiter //
	create trigger after_insert_project
    after insert on project
    for each row
    begin
		DECLARE active_project_count INT;

		SELECT COUNT(*) INTO active_project_count 
		FROM project 
		WHERE emp_id = NEW.emp_id 
		AND status IN ('In Progress', 'Pending');

		IF active_project_count >= 3 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Lỗi.';
		END IF;

		IF NEW.status = 'In Progress' AND NEW.start_date > CURDATE() THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Lỗi.';
		END IF;
    end;
// delimiter ;

delimiter//
	create view PerformanceOverview
    as select p.project_id , p.name,count(DISTINCT e.emp_id),(p.end_date-p.start_date) as total_day,p.status
    from project p 	
    join employees e on p.emp_id = e.emp_id 
    group by p.project_id 
// delimiter ; 

UPDATE employees SET salary = salary * 0.5 WHERE emp_id = 1; 
UPDATE employees

SET salary = salary * 2

WHERE emp_id = 2; 

INSERT INTO project (name, emp_id, start_date, status) 

VALUES ('New Project 1', 1, CURDATE(), 'In Progress');

INSERT INTO project (name, emp_id, start_date, status) 

VALUES ('New Project 2', 1, CURDATE(), 'In Progress');

INSERT INTO project (name, emp_id, start_date, status) 

VALUES ('New Project 3', 1, CURDATE(), 'In Progress');

INSERT INTO project (name, emp_id, start_date, status) 

VALUES ('New Project 4', 1, CURDATE(), 'In Progress'); 

-- Trường hợp 2: Ngày bắt đầu dự án không hợp lệ

INSERT INTO project (name, emp_id, start_date, status) 

VALUES ('Future Project', 2, DATE_ADD(CURDATE(), INTERVAL 5 DAY), 'In Progress');


