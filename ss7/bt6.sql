use ss7;

select e.name,d.department_name from
employees e join departments d on
e.department_id=e.department_id
order by e.name; 

select e.name,e.salary from employees e where e.salary>5000 order by e.salary desc;
-- Lấy tên nhân viên và tổng số giờ làm việc của mỗi nhân viên.
select e.name, sum(t.hours_worked)
from employees e join timesheets t
on e.employee_id=t.employee_id
group by e.name;

select d.department_name,avg(e.salary) from
employees e join departments d on
e.department_id=e.department_id
group by d.department_name; 

select p.project_name,sum(t.hours_worked) from 
projects p join timesheets t on
p.project_id=t.project_id
where month(work_date)=2
group by p.project_name;

select e.name,p.project_name,sum(t.hours_worked)
from projects p join timesheets t on
p.project_id=t.project_id
join employees e on 
e.employee_id=t.employee_id
group by  e.name,p.project_name;

SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 1;


select w.report_date,e.name,report_content
from WorkReports w join employees e
on w.employee_id=e.employee_id
order by report_date desc
limit 2 offset 1;

select w.report_date,e.name,sum(w.report_id)
from WorkReports w join employees e
on w.employee_id=e.employee_id
where w.report_content is not null
and w.report_date between '2025-01-01' and '2025-02-01'
group by  w.report_date,e.name
;

select e.name,p.project_name,sum(t.hours_worked),round( sum(t.hours_worked)* any_value(e.salary),0) as total_salary from 
projects p join timesheets t on
p.project_id=t.project_id
join employees e on
e.employee_id=t.employee_id
group by e.name,p.project_name
having sum(t.hours_worked)>5
order by total_salary;