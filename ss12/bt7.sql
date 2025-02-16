CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manager VARCHAR(100) NOT NULL,
    budget DECIMAL(15,2)
);

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE project (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    emp_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(100) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

DELIMITER //
CREATE TRIGGER warning_insert_employee
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE project_status VARCHAR(100);
    
    IF NEW.salary < 500 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Lương quá thấp';
    ELSEIF NEW.dept_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Nhân viên phải thuộc một phòng ban';
    ELSE
        SELECT status INTO project_status FROM project WHERE emp_id = NEW.emp_id LIMIT 1;
        IF project_status = 'Completed' THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Lỗi: Nhân viên đã làm việc trong dự án hoàn thành';
        END IF;
    END IF;
END;
//
DELIMITER ;

CREATE TABLE project_warnings (
    warning_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    warning_message VARCHAR(255) NOT NULL,
    warning_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES project(project_id)
);

CREATE TABLE dept_warnings (
    warning_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_id INT NOT NULL,
    warning_message VARCHAR(255) NOT NULL,
    warning_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


DELIMITER //
CREATE TRIGGER after_update_projects
AFTER UPDATE ON project
FOR EACH ROW
BEGIN
    DECLARE total_salary DECIMAL(15,2);
    DECLARE department_budget DECIMAL(15,2);
    DECLARE department_id INT;

    IF NEW.status = 'Delayed' THEN
        INSERT INTO project_warnings (project_id, warning_message)
        VALUES (NEW.project_id, '⚠ Lỗi: Dự án bị trì hoãn');
    END IF;

    IF NEW.status = 'Completed' THEN
        UPDATE project
        SET end_date = CURDATE()
        WHERE project_id = NEW.project_id;

        SELECT e.dept_id, SUM(e.salary), d.budget INTO department_id, total_salary, department_budget
        FROM employees e
        JOIN departments d ON e.dept_id = d.dept_id
        WHERE e.emp_id = NEW.emp_id
        GROUP BY e.dept_id;
 
        IF total_salary > department_budget THEN
            INSERT INTO dept_warnings (dept_id, warning_message)
            VALUES (department_id, '⚠ Lỗi: Tổng lương nhân viên vượt ngân sách phòng ban');
        END IF;
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE VIEW FullOverview AS
SELECT 
    e.emp_id, 
    e.name AS EmployeeName, 
    d.name AS DepartmentName, 
    p.name AS ProjectName, 
    p.status AS ProjectStatus, 
    e.salary,
	COALESCE(pw.warning_message, dw.warning_message, 'No Warning') AS WarningMessage
FROM employees e
JOIN departments d ON d.dept_id = e.dept_id
LEFT JOIN project p ON p.emp_id = e.emp_id;
LEFT JOIN project_warnings pw ON pw.project_id = p.project_id
LEFT JOIN dept_warnings dw ON dw.dept_id = d.dept_id;
//
DELIMITER ;

INSERT INTO employees (name, dept_id, salary, hire_date)

VALUES ('Alice', 1, 400, '2023-07-01'); 

INSERT INTO employees (name, dept_id, salary, hire_date)

VALUES ('Bob', 999, 1000, '2023-07-01'); 

INSERT INTO employees (name, dept_id, salary, hire_date)

VALUES ('Charlie', 2, 1500, '2023-07-01');

INSERT INTO employees (name, dept_id, salary, hire_date)

VALUES ('David', 1, 2000, '2023-07-01');

UPDATE projects SET status = 'Delayed' WHERE project_id = 1;

UPDATE projects SET status = 'Completed', end_date = NULL WHERE project_id = 2;

UPDATE projects SET status = 'Completed' WHERE project_id = 3;

UPDATE projects SET status = 'In Progress' WHERE project_id = 4;

SELECT * FROM FullOverview;
