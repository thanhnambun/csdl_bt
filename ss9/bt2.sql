use ss9;

CREATE VIEW view_manager_summary AS
SELECT 
    manager_id,
    COUNT(employee_id) AS total_employees
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

select * from view_manager_summary;

SELECT 
    e.name AS manager_name, 
    v.total_employees
FROM view_manager_summary v
JOIN employees e ON v.manager_id = e.employee_id;

