-- first run create_employee.sql from database_script folder to create the database in your MySQL
use employee;

-- 1. Write a SQL query to find the salaries of all employees
SELECT employee_id, concat(first_name,' ',last_name) AS Name, salary AS 'Salary' 
FROM employees;

-- 2. Write a SQL query to find the unique designations of the employees. Return job name.
SELECT DISTINCT job_title AS 'Job_Name' 
FROM jobs;

-- 3. write a SQL query to list the employees’ name, increased their salary by 15%, and expressed as number of Dollars.
SELECT CONCAT(first_name,' ',last_name) AS 'Name', salary AS Salary, ROUND(salary + (0.15*salary)) AS 'Increased Salary' 
FROM employees;

-- 4. Write a SQL query to list the employee's name and job name as a format of "Employee & Job".
SELECT CONCAT(first_name,' ',last_name, ', ', job_title) AS "Employee & Job"  
FROM employees 
JOIN jobs ON employees.job_id = jobs.job_id;

-- 5. Write a SQL query to find those employees with hire date in the format like February 22, 1991. Return employee ID, employee name, salary, hire date.
SELECT employee_id, CONCAT(first_name,' ',last_name) AS Name, salary, DATE_FORMAT(hire_date, '%M %d, %Y') AS hire_date 
FROM employees;

-- 6. Write a SQL query to count the number of characters except the spaces for each employee name. Return employee name length.
SELECT  CONCAT(first_name,' ',last_name) AS 'Name', TRIM(LENGTH(CONCAT(first_name,'',last_name))) AS 'No of Character' 
FROM employees;

-- 7. Write a SQL query to find the employee ID, salary, and commission of all the employees. 
SELECT employee_id, salary, commission_pct 
FROM employees 
ORDER BY commission_pct DESC;

-- 8. Write a SQL query to find the unique department with jobs. Return department ID, Job name. 
SELECT DISTINCT(department_id), job_title AS 'Job Name'
FROM employees 
JOIN jobs ON employees.job_id = jobs.job_id 
ORDER BY department_id;

-- 9. Write a SQL query to find those employees who joined before 1991. Return complete information about the employees.
SELECT  * FROM employees 
INNER JOIN job_history ON employees.employee_id = job_history.employee_id
WHERE start_date < '1991-01-01';

-- 10. Write a SQL query to compute the average salary of those employees who work as ‘ANALYST’. Return average salary.

-- as we don't have ‘ANALYST’ in this schema I am using 'Accountant'
SELECT job_title , round(avg(salary),2) As 'Average Salary'
FROM employees 
JOIN jobs ON employees.job_id = jobs.job_id 
WHERE job_title = 'Accountant';

-- for ‘ANALYST’ part
SELECT job_title , round(avg(salary),2) As 'Average Salary'
FROM employees 
JOIN jobs ON employees.job_id = jobs.job_id 
WHERE job_title = 'ANALYST';