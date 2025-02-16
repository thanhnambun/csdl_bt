create table budget_warnings (
	warning_id int auto_increment primary key,
    project_id int ,
    warning_message varchar(255) not null 
);

DELIMITER //

CREATE TRIGGER budget_warnings_after 
AFTER UPDATE ON projects 
FOR EACH ROW
BEGIN
    DECLARE warning_exists INT DEFAULT 0;

    SELECT COUNT(*) INTO warning_exists
    FROM budget_warnings
    WHERE project_id = NEW.project_id;

    IF NEW.total_salary > NEW.budget AND warning_exists = 0 THEN
        INSERT INTO budget_warnings (project_id, warning_message)
        VALUES (NEW.project_id, 'Budget exceeded due to high salary');
    END IF;
END;
//
DELIMITER ;


create table ProjectOverview  (
	project_id int auto_increment primary key,
    name varchar(100) not null ,
    budget decimal(15,2),
    total_salary decimal(15,2),
    warning_message varchar(255)
);

INSERT INTO workers (name, project_id, salary) VALUES ('Michael', 1, 6000.00);

INSERT INTO workers (name, project_id, salary) VALUES ('Sarah', 2, 10000.00);

INSERT INTO workers (name, project_id, salary) VALUES ('David', 3, 1000.00);

select * from ProjectOverview;
select * from budget_warnings ;







