USE employees_mod;
# 2. Create a procedure that will provide the average salary of all employees
DELIMITER $$
CREATE PROCEDURE average()
BEGIN
SELECT AVG(salary)
FROM t_salaries;
END$$
DELIMiTER ;
CALL average();

# 3. Create a procedure called ‘emp_info’ that uses as parameters the first and 
# the last name of an individual, and returns their employee number.
delimiter $$
create procedure emp_info(in p_fn varchar(40), in p_ln varchar(40), out p_emp_no integer)
begin
	SELECT
    p.emp_no
INTO p_emp_no FROM
    t_employees p
WHERE
    first_name = p_fn AND last_name = p_ln;
end$$
delimiter ;

# Call the procedures
call emp_info('Saniya','Kalloufi',@p_emp_no);
select @p_emp_no;

# 5. Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, 
# and returns the salary from the newest contract of that employee. Hint: In the BEGIN-END block of this program, 
# you need to declare and use two variables – v_max_from_date that will be of the DATE type, and v_salary, 
# that will be of the DECIMAL (10,2) type.
DELIMITER $$
CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
DETERMINISTIC
BEGIN
DECLARE v_max_from_date date;
DECLARE v_salary decimal(10,2);
SELECT MAX(from_date) INTO v_max_from_date FROM t_employees e
JOIN t_salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
SELECT s.salary INTO v_salary FROM t_employees e
JOIN t_salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name AND s.from_date = v_max_from_date;
end$$
delimiter ;

# 6. Create a trigger that checks if the hire date of an employee is higher than the current date. 
# If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)
DELIMITER $$
CREATE TRIGGER before_hire_insert
BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN 
	IF NEW.hire_date > CURRENT_DATE THEN 
		SET NEW.hire_date = DATE_FORMAT(SYSDATE(), '%y-%m-%d'); 
	END IF; 
END $$
DELIMITER ;

# 7. Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.
ALTER TABLE t_employees
ADD COLUMN i_hire_date date;
CREATE INDEX ouykhy ON t_employees (i_hire_date); 
DROP INDEX ouykhy ON t_employees;

# 8. Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum. 
# Then, create an index on the ‘salary’ column of that table, and check 
# if it has sped up the search of the same SELECT statement.
SELECT * FROM employees_mod.t_salaries WHERE salary > 89000;
CREATE INDEX Q8 ON t_salaries (salary); 
SELECT * FROM t_salaries WHERE salary > 89000;

# 9. Use Case statement and obtain a result set containing the employee number, first name, and last name of all employees 
# with a number higher than 109990. Create a fourth column in the query, indicating whether this employee 
# is also a manager, according to the data provided in the dept_manager table, or a regular employee.
SELECT t_employees.emp_no,t_employees.first_name,t_employees.last_name, 
case  when t_dept_manager.dept_no = t_employees.emp_no
THEN 'Employee is a manager'
ELSE 'Employee is a regular employee'
END AS RegularManager
FROM t_employees 
left join t_dept_manager ON t_dept_manager.emp_no = t_employees.emp_no where t_employees.emp_no >  109990;

# 10. Extract a dataset containing the following information about the managers: employee number, first name, and 
# last name. Add two columns at the end – one showing the difference between the maximum and minimum salary of that 
# employee, and another one saying whether this salary raise was higher than $30,000 or NOT.
select t_dept_manager.emp_no, t_employees.first_name, t_employees.last_name,
max(t_salaries.salary) - min(t_salaries.salary) as salary_difference,
case when max(t_salaries.salary) - min(t_salaries.salary) > 30000 then 'higher than 30k' else 'not higher than 30k' end as raise_high
from t_employees inner join t_dept_manager on t_dept_manager.emp_no = t_employees.emp_no
inner join t_salaries on t_salaries.emp_no = t_employees.emp_no
group by t_employees.emp_no;

# 11. Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, 
# called “current_employee” saying “Is still employed” if the employee is still working in the company, or “Not an 
# employee anymore” if they aren’t. Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table 
# to solve this exercise.
select t_employees.emp_no, t_employees.first_name, t_employees.last_name,
case when t_dept_emp.to_date > SYSDATE() then 'Is still employed' else 'Not an employee anymore' end as current_employee
from t_employees , t_dept_emp
WHERE t_employees.emp_no = t_dept_emp.emp_no LIMIT 100;
