# Subquery
/*
● A select query when it is nested in anothermain query, then it is
called as a subquery
● Like joins, subqueries need common key columns for joining with main queries
● Subqueriesare otherwise called as virtual table enclosed with an
independent business logic
● Subqueriesexecute independently (Depends on Types) and share its results with the 
main query, so that the complexity reduces while writing the querie
● Subquery separates the complex business logic from the main query
● It is easy to debug an individual subquery instead of large and complex main query 
where more tables and columns are used
● Subqueries improve the performance when they are used in a better way
● Subqueries can be written anywhere in the SELECT clause, FROM clause and WHERE 
clause of another SQL query, however, the constraints of clauses are applied while 
using subqueries
● Non Correlated :1.Subquery Single Row Subquery -Returns a single value and feeds to main query
                  2.Multiple Row Subquery -Returns more number of rows
● Correlated Subquery : the subquery is dependent on outer query for retrieving each 
record
*/

# Subquery in Where Clause
/*Subqueries can be written in WHERE clause of another query by using operators
● Multi-row operators perform comparison operations on multiple rows returned by 
subquery includes EXISTS, IN , ANY and ALL
• Single-row operators perform comparison operations on single row returned by
subquery.They can also use single-row comparison operators as <, >, =
*/

-- Single row sub Queries in where clause
select first_name from employees -- Select the name of employees who belong to Marketing department
where department_id = (Select department_id from departments where department_name='Marketing');

-- Display the employee id, first_name, salary for all employees who earns salary equals to Neena
select employee_id, first_name, salary, job_id 
from employees 
where salary = (select salary from employees where first_name='neena');
-- Display the employee id, first_name, salary,job_id for all employees who earns salary and job_id equals to Neena
select employee_id, first_name, salary, job_id 
from employees 
where (salary, job_id) = (select  salary,job_id from employees where first_name='neena');

/* query to display the employee id, employee name (first name and last name ),
 salary for all employees who earn more than the average salary of an organisation.*/
 SELECT employee_id, first_name,last_name,salary 
 FROM  employees 
 WHERE salary >( SELECT AVG(salary) FROM employees );
 
-- Display employee details working for sales department
select * from employees
 where department_id=(select department_id from departments where department_name='sales');
 
-- List the employees who are reporting to payam
select * from employees where manager_id = (select employee_id from employees where first_name = 'payam');
-- Display the employee details who joined in the same year along with clara and Exclude Clara while listing
select * from employees
 where year(hire_date)=(select year(hire_date) from employees where first_name='Clara') 
 and first_name<>'Clara';
 
 -- Find the second highest salary wihtout using limit 
  select max(salary) from employees where salary<(select max(salary) from employees ) ;
  -- nested subquery to view all the employees with the second highest salary wihout using limit
  select * from employees where salary=(select max(salary) from employees where salary<(select max(salary) from employees ));
  
  /*
  Display the employee id, first_name, salary, department name and city for all the employees
  who gets the salary more than the maximum salary earn by the employee who joined in the year 1997 */
  select employee_id, first_name, salary, department_name,city from employees e 
  join departments d using(department_id)
  join locations using(location_id) 
  where salary>(select max(salary) from employees where year(hire_date)=1997);
  
-- Display the first name,salary, and department ID 
-- for those employees who earn less than the average salary, of Laura’s department
select first_name,salary,department_id from employees 
where salary <(select avg(salary) from employees where	department_id = (select department_id from employees where first_name='laura'))
and department_id=(select department_id from employees where first_name='laura');

# Multiple Row subquery – IN / Membership Test
# IN operator is well used when the main query searches all of the multiple rows returned by subquery
-- List the employees who all earning salary equals to David
(select * from employees where first_name='David'); -- retun 3 rows -- 3 salary 
select * from employees where salary in (select salary from employees where first_name='David') ;

-- List employees who are earning the min salary in their deparment
SELECT first_name, last_name, salary, department_id
from employees 
where (department_id,salary) in (select department_id,min(salary) FROM employees GROUP BY department_id);

-- count no of employees in each department having min salary and such are more than 1
SELECT  department_id,count(department_id)
from employees 
where (department_id,salary) in (select department_id,min(salary) FROM employees GROUP BY department_id)
group by department_id having count(department_id)>1;

-- List only the department name atleast somebody is working
select department_name from departments where department_id in(select department_id from employees);

-- Multiple Row subquery – NOT IN
-- Display all the information of the employees who does not work in these departments
-- whose manager id (refer department table) within the range 100 and 200.
SELECT * FROM employees 
WHERE department_id NOT IN (SELECT department_id FROM departments WHERE manager_id BETWEEN 100 AND 200);

-- Write the name of all Managers
select * from employees where employee_id in (select manager_id from employees);

-- List the employees those does not belong to location 1700
select * from employees 
where department_id not in(select department_id from departments where location_id=1700);

# Correlated Subquery 
-- Display the employees who are earning salary more than the average of his/her own department
select employee_id, first_name, salary from employees e1 where salary> 
(select avg(salary) from employees e2 where e1.department_id=e2.department_id);

-- List department name where atleast someone is working
select department_name from departments d 
where department_id in (select department_id from employees e where d.department_id=e.department_id) ;

-- Display department_id, employee_id,salary of all departments that has at least one employee with salary greater than 10,000
select department_id, employee_id,salary from employees o 
where employee_id in(select employee_id from employees i where salary >10000 and o.department_id=i.department_id);


# NOT EXISTS/EXISTS 
-- Exists - existence of given condition
-- T/F
-- 1/0
/*Example : here inner query will thorw a output and if the inner query satisfied then
 the outer query with exists will run and it will get true response 
 If the subquery returns at least one row, the EXISTS operator returns true, otherwise, it returns false
 */
select * from employees where exists (select employee_id from employees where department_id=80) ;

-- Display the name of the employees who are managers (using in & exists)
# using exits -- need to use correlated suquery for each row iteration
select first_name,manager_id,employee_id from employees o
where exists (select 1 from employees i where o.employee_id=i.manager_id);
# using in
select first_name, employee_id from employees e1 where employee_id in ( select manager_id from employees );
-- although we can use correlated subquery also in but this is simpler 
select first_name, employee_id from employees e1 where employee_id in ( select manager_id from employees e2 where e1.employee_id=e2.manager_id);
 
-- Display only the department details which has employees – using departments table & Exists operator
select department_name,department_id from departments d where exists
(select employee_id from employees e where e.department_id=d.department_id);

-- Display the name & department ID of all departments that has at least one employee with salary greater than 10,000
-- .using IN & Exists  (correlated)
select department_name, department_id from departments d 
where department_id in  (select department_id from employees e where salary>10000 and d.department_id=e.department_id)  ;
SELECT department_name,department_id FROM  departments
 d WHERE   EXISTS  ( SELECT 1  FROM   employees e   WHERE  salary > 10000 AND e.department_id = d.department_id);
 
-- ANY operator
-- ANY means that the condition will be satisfied if the operation is true for any of the values in the range. 
-- ALL means that the condition will be satisfied only if the operation is true for all values in the range. 

-- salary >ANY (1000, 2000, 3000, 4000) this mean : salary>1000 or salary>2000 or salary>3000 or salary>4000  
-- salary >ALL (1000, 2000, 3000, 4000) this mean : salary>4000 

-- A query to find the salary of the all employees who are earning more than minimum salary of any of the departments
select * from employees where salary > any(select min(salary) from employees group by department_id);
-- A query to find the salary of the all employees who are earning more than minimum salary of their resp department
select * from employees o where salary > (select min(salary) from employees i where o.department_id=i.department_id);

-- List the employees who all earning salary more than ‘David
select salary from employees where salary >ANY(select salary from employees where first_name='David');
-- Find the highest average salary among all the department

# subquery in having
select department_id, avg(salary) from employees group by department_id
having avg(salary)>= all(select avg(salary) from employees group by department_id);

-- Department name with highest employee count

select e.department_id, department_name, count(*) cnt from departments d 
join employees e using (department_id)group by e.department_id having cnt>=ALL(select count(*) from employees group by department_id);

--  a query to find the department id whose average salary is more than the average salary of department 80

select department_id, avg(salary) avg_sal from employees group by department_id
having avg_sal >
(select avg(salary) from employees where department_id=80);

# Subqueries – Select Clause  
select (select count(employee_id) from employees )emp_cnt,(select count(department_id) from departments) emp_dept from dual;
-- since we are not querying any existing tables, we use the DUAL table.
--  The DUAL table is essentially a dummy table that contains a single row and single column, 
-- allowing us to execute queries that don't require data from any actual tables.
# Or
select count(employee_id) cnt_emp, (select count(department_id) from departments) cnt_dept from employees;
-- Display employee_id , Department_id and Department_name 
select employee_id, department_id, (select department_name from departments d where
e1.department_id=d.department_id) as dept_name from employees e1;

-- Display Employee name along with manager_name
select first_name emp_name, 
(select first_name from employees e1 where e1.employee_id=e2.manager_id)from employees e2;

-- Subqueries – Derived Table/From clause
select desig, count(*) from
(select job_id, case when job_id like '%clerk%' then 'clerk'when job_id like '%mgr%' then 'Manager'end desig from employees) t1
where desig is not null
group by desig;


-- List the employee_id and first_name of those who working for more than 25 years 

select * from(select employee_id, floor(datediff(current_date(),hire_date)/365) t1 from employees) tw where t1>25;

-- display total employees in department 80 and job_id wise 
select * from
(select  department_id, job_id,count(job_id) cnt from employees
where department_id=80
group by department_id, job_id) t1 
cross join
(select count(*) total_count from employees where department_id=80) t2;


# Advanced Aggregate Function
/*
The Window/ Analytical  function uses OVER() clause to calculate aggregate results on group of rows

The aggregate result thus produced from group of rows is again shared for each row in the group

This is an advanced feature of GROUP BY clause by sharing aggregate result at row level
Window_function_name (expression)
OVER(  
[partition_definition] group by
[Order_definition] – order by
[frame_definition] – slices)  over()
	*/
    
# window Function ranking
/*
    
The ranking functions assign a rank for each row in an ordered group of rows

The rank is assigned to rows in a sequential manner

The assignment of rank to each of the rows always start with 1 for every new partition

There are 3 types of ranking functions supported in MySQL-
rank()
dense_rank()
percent_rank()
*/
# Window Functions – Row_Number()
-- List  the employee details with the Row Number 
select employee_id, department_id,  salary, row_number()over(order by employee_id) from employees ;
select * from 
(select row_number()over() SNo, employee_id, first_name, salary from employees) t 
where SNo  between 20 and 30;

# Rank() Function
-- Rank each employee by its Salary (skip the double occurance )
-- Rank() function will keep skipping the subsequent ranks based 
-- on the count of similar column values
-- No. of Ranks skipped = No. of gaps between similar column value

select rank() over(order by salary) from employees;

# Dense_Rank() Function
-- Dense_rank displays the rank based on highest value of a desired column,
-- but it preserves the rank for next following record without skipping
-- Rank each employee by its Salary
select employee_id, salary , rank() over(order by salary),dense_rank() over(order by salary)  from employees; 
 # Percent_Rank() Function
-- While the partitioned rows are in ascending order, the percent_rank () calculates the 
-- percentage of rank basis on formula: (rank - 1) / ( rows - 1)
-- Percent_rank() also skips the rank percentage when identified with duplicate values
select employee_id, salary , percent_rank() over(order by salary)  from employees; 

# Cume_dist() Function
/*Distribution of records means - the percentage of a record occupied in the total record set.
- Calculates the relative position of a specified value in a group of values
For the first row, the function finds the number of rows in the result set. 

*/

 select first_name,salary , row_number()over(),cume_dist()over(order by salary) from employees;
# LAG() and LEAD() Function

 





















-- Display managers to whom more than 2 employees report 
























 










