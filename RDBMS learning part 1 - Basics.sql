-- SQL basics 
-- The commands available in SQL can be broadly categorised as follows:
-- ● Data Definition Language (DDL)
-- ● Data Manipulation Language(DML)
-- ● Data Query Language (DQL)
-- ● Data Control Language (DCL)
-- ● Transactional Control Language (TCL)


-- Data Definition Language (DDL)
-- The typical commands available in DDL are:
-- ○ CREATE
-- ○ ALTER
-- ○ DROP
-- ○ TRUNCATE

-- CREATE DATABASE statement is used to create a new SQL database
create database Sandeep; -- to create a database named sandeep
show databases; -- to view all the database (by default -- sys, musql, information_schema, performance schema ) databases predefined
use sandeep ; -- To use the created database
-- DROP DATABASE Sandeep; -- to drop the created databse
CREATE TABLE marks -- to create a table named sandeeep
(roll_no varchar(20) primary key -- to create a column named roll_no with primary key(so does not contian null and duplicate values 
,Name_ varchar(30) not null,Itp_marks int(2),NPV_marks int(2),EDA_marks int(2));
show tables; -- To view all the tables in the database
-- Drop table marks; -- to drop the table named sandeep, delete the whole strucuture of the table
-- TRUNCATE TABLE marks; to delete all the reords in the table although strusture will reamin 

-- Data Manipulation Language (DML)
-- ○ INSERT
-- ○ UPDATE
-- ○ DELETE
-- ○ SELECT

select * from marks;
-- ○ INSERT
INSERT INTO marks (roll_no, Name_, Itp_marks,NPV_marks,EDA_marks) -- one way to add values inside the table here need to pass columns 
VALUES ( 'san101','sandeep' , 45, 44,50);--  vlaues interserted here feeds as per the order of above columns
INSERT INTO marks values  -- here values inserted as per the order of columns inside the table
( 'Abhi102','Abhijeet' , 35, 24,40),
('Har103','Harsh' , 23, 45,45),
('Dhru104','Dhruti' , 33, 45,25),
('Shu105','Shubham' , 45, 23,28),
('Tus106','Tushar' , 04, 33,43) ;

INSERT INTO marks values  -- here values inserted as per the order of columns inside the table
( 'Ab107', 'Abhishek',35, 24,40), -- as we have not defied any constraints apart from roll_no 
('Nat108','Harsh' ,null , 45,45), -- we can add null and duplicated to other columns
('Dhv109','Dhruv', 33, 45,null), -- if we have specified unique, not null etc constraints then the query will not work.
('Shi105','Shivam' , null, 23,null),
('Tu106','Shivam' , null, 23,null) ;

-- ○ UPDATE
update marks  set itp_marks=34 where roll_no ='Tus106'; -- to update the values inside the table for single columns
update marks  set itp_marks=34,npv_marks=23,eda_marks=38 where roll_no ='Tus106'; -- to update the values inside the table for multiple columns

-- ○ DELETE
-- DELETE FROM marks WHERE roll_no='Tus106'; -- to delete the specified value(tuple)

-- ○ SELECT
-- If you want to select all the fields available in the table
SELECT * from marks; -- this is very dangerous might crash if data is very large 
SELECT Roll_no, Name_ from marks; -- select multiple columns
SELECT * from marks
WHERE itp_marks = 34; -- select only those row there marks are 34 in Itp_marks columns

-- The following operators can be used in WHERE clause
-- Operator Description
-- = Equal
-- > Greater than
-- < Less than
-- >= Greater than or equal
-- <= Less than or equal
-- <> :Not equal. In some versions of SQL the operator may be written as !=
-- BETWEEN :Between a certain range
-- LIKE : Search for a pattern
-- IN :To specify multiple possible values for a colum

-- Compound Search Conditions
-- The compound conditions are made up of multiple simple conditions connected by AND or OR
-- There is no limit to the number of simple conditions that can be present in a single query
-- They enable you to specify compound search conditions to fine tune your data retrieval requirements

SELECT * FROM marks
WHERE (Name_  like '%a%' AND 
itp_marks <> 34)
OR (npv_marks = 44);   -- compund mean the Parentheses which defines the scope of and , or 
-- If we don't use Parentheses it will combine and cause ambiguity.

-- Checking Missing Data

SELECT * FROM marks -- return not null values 
WHERE name_ IS NOT NULL;

SELECT * FROM marks -- return null values
WHERE itp_marks IS NULL;


-- ○ ALTER  : it is DDL command , showing here beacuse required data that i have created in DML 
-- ● Sometimes we need to incorporate changes to an already existing tables. For
-- example, renaming a field, changing the data-type, etc
-- ● The alter command is used to make modification in an existing database/table
-- ● Alter command is generally used with clauses such as change, modify, add, drop
-- Alter Query - Change Clause:
-- The change clause allows you to:
-- ○ Change the name of the column (new name, new data type, new constraint(optional))
ALTER TABLE marks CHANGE itp_marks
DSA_marks int(3); -- here we have changed the column itp_marks to DSA_marks
-- ○ Change the column data type
ALTER TABLE marks CHANGE DSA_marks
DSA_marks float(5);-- Here we have changed DSA_marks datatype from int to float 
-- ○ Change column constraints
ALTER TABLE marks CHANGE DSA_marks
DSA_marks float(5) default 0; -- here have set a defualt constraint to 0 ,
 -- it does not chnage the previous values it will change the values inserted after this query 
 
-- The Modify clause allows you to:
-- ○ Modify Column Data Type
ALTER TABLE marks MODIFY DSA_marks float(5);-- Here we have changed DSA_marks datatype from int to float 
-- ○ Modify Column Constraints
ALTER TABLE marks MODIFY DSA_marks float(5) default 0; -- here have set a defualt constraint to 0 ,
 -- it does not chnage the previous values it will change the values inserted after this query 

-- modify is similar to change but modify cannot rename a column as it formats uses only one column(current column)  where as 
-- change uses old and new column name both.
-- MODIFY does everything CHANGE can, but without renaming the column

-- The Add clause allows you to:
-- ○ Add a new column to an existing table
ALTER TABLE marks ADD COLUMN age int(5);
-- By default, the ADD clause adds a column at the end of the table. Use the
-- AFTER keyword to add a column at a particular position in a table
ALTER TABLE marks ADD Date_of_Birth date AFTER Name_ ;
-- ○ Add primary key constraint to an existing column

-- Alter Query - Drop Clause
ALTER TABLE marks DROP COLUMN age;
-- The DROP query allows  to:
-- ○ Delete a database
-- DROP DATABASE sandeep;
-- ○ Delete an existing table from the database
-- DROP TABLE marks;
-- can delete primary key,
-- here is only one Primary Key in a table. Hence, we don’t
-- need to specify the name of the column while dropping the
-- Primary Key using the ALTER command
-- ALTER TABLE marks DROP PRIMARY KEY;

-- The Rename Query
-- The rename command is used to change the name of an existing database table
-- to a new name
-- ● Renaming a table does not make it to lose any data is contained within it
RENAME TABLE marks TO PGPDSE_marks;

# Constrains

-- NOT NULL Ensures that a column cannot have a NULL value
CREATE TABLE Student_details ( student_id int Not Null
,first_name varchar(20) Not 
Null
,last_name varchar(20) Not Null
,country varchar(20)
);
-- UNIQUE Ensures that all values in a column are different
CREATE TABLE Student_details ( student_id int Not Null UNIQUE
,first_name varchar(20) Not 
Null
,last_name varchar(20) Not Null
,country varchar(20)
);
-- PRIMARY KEY A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
CREATE TABLE Student_details ( student_id int primary key
,first_name varchar(20) Not 
Null
,last_name varchar(20) Not Null
,country varchar(20)
);
-- or
CREATE TABLE Student_details ( student_id int Not Null UNIQUE
,first_name varchar(20) Not 
Null
,last_name varchar(20) Not Null
,country varchar(20)
,PRIMARY KEY (student_id));

-- FOREIGN KEY Uniquely identifies a row/record in another table
CREATE TABLE Student_details ( student_id int Not Null UNIQUE
,first_name varchar(20) Not 
Null
,last_name varchar(20) Not Null
,country varchar(20)
,PRIMARY KEY (student_id)),
FOREIGN KEY (student_id )
REFERENCES PGPDSE_marks(roll_no);

-- CHECK Ensures that all values in a column satisfies a specific condition

-- DEFAULT Sets a default value for a column when no value is specified
-- INDEX Used to create and retrieve data from the database very quickly

## Where
-- The Where Clause supports the following types of predicates :
-- ○ Comparison
-- ■ = Equal
SELECT * FROM Pgpdse_marks Where npv_marks = 23;
-- ■ <> Not Equal
SELECT * FROM Pgpdse_marks Where npv_marks <> 23;
-- ■ < Less Than
SELECT * FROM Pgpdse_marks Where npv_marks < 23;
-- ■ > Greater Than
SELECT * FROM Pgpdse_marks Where npv_marks > 23;
-- ■ <= Less Than Or Equal
SELECT * FROM Pgpdse_marks Where npv_marks <= 23;
-- ■ >= Greater Than Or Equal
SELECT * FROM Pgpdse_marks Where npv_marks >= 23;
-- ○ Pattern Matching
-- ■ LIKE ( Used for Wildcard Filtering)
-- % The percent character indicates any character with any number of counts
SELECT * FROM PGpdse_marks WHERE name_ LIKE 'S%'; -- return all from name_ column where first letter is s
SELECT * FROM PGpdse_marks WHERE name_ LIKE '%S'; -- return all from name_ column where last letter is s 
SELECT * FROM PGpdse_marks WHERE name_ LIKE '%S%'; -- return all from name_ column where anywhere the letter s is there
-- - The hyphen character indicates a range of the character within the braces [a-c]

-- _ The underscore character indicates any one character
SELECT * FROM PGpdse_marks WHERE name_ LIKE 'sandee_'; -- check all the text which contain sandee_ and last letter can be anything but should be there
-- [] The square bracket indicates any one value with the brackets 
-- ^ The caret character indicates all the character except available in the brackets: [^xyz]
-- # The hash sign indicates a single numeric characte

-- ○ BETWEEN
-- ■ <= Less Than Or Equal
SELECT * FROM Pgpdse_marks Where npv_marks between 23 and 45;
-- ○ IN
SELECT * FROM Pgpdse_marks Where npv_marks in (24,45); # check only these two element not range
-- ○ IS NULL
SELECT * FROM Pgpdse_marks Where npv_marks is NULL;

# Set Operations
-- ● Set operators are used to join the results of two (or more) SELECT statements
-- ● Types of SET operations:
-- ○ UNION : merge two query or more like stack the data irrespective of acutal mean of column
-- The Union clause/operator is used to combine the results of two or more SELECT 
-- Statements with Identical columns without returning any duplicate rows
-- There should be same number of columns in both SELECT statement
-- The column names from the first SELECT statement in the UNION operator are used as
-- the column names for the result set
select * from pgpdse_marks where npv_marks=45
union
select * from pgpdse_marks where eda_marks<45;
-- ○ UNION ALL
-- The Union All clause/operator is used to combine the results of two or 
-- more SELECT Statements into a single set of rows and columns without 
-- the removal of any duplicates
select * from pgpdse_marks where npv_marks=45
union all
select * from pgpdse_marks where eda_marks<45;
-- ○ INTERSECT
-- The INTERSECT OPERATION is used to combine two SELECT statements with 
-- identical columns and returns rows only common rows returned by the two select 
-- statements
-- select * from pgpdse_marks where npv_marks=45
-- union all
-- select * from pgpdse_marks where eda_marks<45;
-- MySQL DOES NOT support INTERSECT operator. However, we 
-- can emulate the INTERSECT operator using JOINS.
-- ○ MINUS
-- MySQL DOES NOT support MINUS operator. However, we 
-- can emulate the MINUS operator using JOINS.

#Duplicate rows 
-- The DISTINCT keyword in the SELECT statement eliminates duplicate rows and 
-- display a unique list of values
select distinct EDA_marks from pgpdse_marks;

# SQL Built-in Function
-- There are different types of SQL built - in functions, which are mentioned below:
-- ○ Numeric
SELECT (25 + 7) AS ADDITION; -- 32 perform addition
SELECT COS(1) As Cos; -- .54030 Can also perfrom trignometry degree calcuation
SELECT SIN(1) As Sin; -- 0.8414 Can also perfrom trignometry degree calcuation
SELECT TAN(1) As Tan; -- 1.5574
SELECT COT(1) As Cot; -- 0.64
SELECT 20 DIV 6 As DIVISION; -- 3 perfrom divison
SELECT DEGREES(45) As Degree; -- 2576 degree It converts a radian value into degrees
SELECT EXP(2) As Exponential ;-- 7.389 It returns e raised to the power of number
SELECT FlOOR(2.8) As Floor; -- 2  returns the largest integer value that is less than or equal to a number
SELECT GREATEST(2,4,5,454,3.4) As Greatest_num; -- 454 greatest value in a list of expressions
SELECT LEAST(2,4,5,454,3.4) As Least_num; -- 2 Samallest value in a list of expressions
SELECT LN(1) As natual_log; -- 0 Natural logarithm(log with base e) of a number
SELECT LOG10(10) As log_; --  1 log with base 10 
SELECT LOG2(2) As log_; -- 1 like this we can write log2, log3 and any number
SELECT 10 MOD 3 ; -- 1 Return remainder
SELECT ROUND(PI(), 6) AS pi_value; -- 3.14 Returns the value of pi with 6 decimal places
SELECT POW(2, 3) AS power_result; -- 8 Return 3 to the power of 2 
SELECT RADIANS(90) AS radians_value; -- 1.57 Converts a value in degrees to radians.
SELECT RAND() AS random_number; -- .99 Returns a random number between 0 and 1.
SELECT ROUND(3.14159, 2) AS rounded_number; -- 3.14 Returns a number rounded to a certain number of decimal places.
SELECT SIGN(-10) AS sign_value; -- -1 Returns a value indicating the sign of a number (-1 for negative, 0 for zero, 1 for positive).
SELECT SQRT(16) AS square_root_value; -- 4 Returns the square root of a number.
SELECT ATAN2(1, 1) AS arctangent_value; -- .78 Returns the arctangent of the quotient of its arguments. The result is expressed in radians.
-- ○ String
SELECT ASCII('A'),ASCII('a') ; -- A:65,a:97 return ascii value of char
SELECT CHAR(97) AS character_value;
SELECT CONCAT('Sandeep', ' ', 'Kumar') AS concatenated_string; -- join the strings
SELECT CONCAT_WS(',', 'apple', 'banana', 'orange') AS concatenated_string_with_separator; -- Concatenate multiple strings with a separator into a single string.
SELECT FORMAT(12345.6789, 'C') AS formatted_value; -- to format the value
-- For numeric values, common format strings include 'C' for currency, 'N' for number, and 'P' for percentage.
-- For date/time values, common format strings include 'd' for short date, 't' for short time, and 'f' for full date/time.
SELECT LEFT('Sandeep Kumar',7) AS left_string; -- sandeep takes letters from the start of a word till the given number
SELECT RIGHT('Sandeep Kumar', 3) AS last_toys; -- mar ,takes letters from the end of a word till the given number
SELECT LENGTH(' Sandeep') AS length_of_word; -- 7 Counts how many all char incuding space and specal char in the word.
SELECT CHAR_LENGTH('Sandeep')AS length_of_word; -- 7 Counts how many letters are in a word.
SELECT LOWER('SANDEEp') AS lowercase_word; -- sandeep Makes all the letters lower case
SELECT LTRIM('   sandeep') AS trimmed_word;-- sandeep Removes empty spaces from the beginning of a word.
SELECT RTRIM('Sandeep    ') AS trimmed_word;-- sandeep Removes empty spaces from the end of a word.
SELECT TRIM('  Sandeep  ') AS trimmed_word;-- Makes a word neat by removing empty spaces from both ends.
SELECT REPLACE('banana', 'a', 'o') AS new_word; -- bonono replace a by o everywhere in text
SELECT REVERSE('hello') AS backward_word; -- olleh ,reverse the whole string
SELECT SPACE(5) AS empty_spaces; --    ,Makes 5 empty spaces
SELECT SUBSTRING('banana', 2, 3) AS sub_word; -- ana (text,start(1), stop)

-- ○ Date
SELECT NOW() AS current_date_and_time; -- Shows the current date and time
SELECT DATE('2024-04-13 01:52:56') AS date_only; -- Extracts the date part of a date or date/time expression
SELECT EXTRACT(YEAR FROM '2024-04-08') AS year; -- extract year
SELECT EXTRACT(MONTH FROM '2024-04-08') AS Month;-- extract month
SELECT EXTRACT(DAY FROM '2024-04-08') AS day; -- extract day
SELECT DATE_ADD('2024-04-13', INTERVAL 7 DAY) AS future_date; -- Adds a specified time interval to a date
SELECT DATE_ADD('2024-04-13', INTERVAL 7 month) AS future_date;-- subtract a specified time interval to a date
SELECT DATE_ADD('2024-04-13', INTERVAL 7 year) AS future_date;-- subtract a specified time interval to a date
SELECT DATE_SUB('2024-04-08', INTERVAL 1 MONTH) AS past_date;-- subtract a specified time interval to a date
SELECT DATEDIFF('2024-04-08', '2024-03-01') AS days_difference; -- Counts the days between two dates
SELECT DATE_FORMAT('2022-04-08', '%M %d, %Y') AS formatted_date; -- formats the date in output
SELECT CURTIME() AS current_time ; -- print current time
-- ○ Bin
Select BIN(255); -- print binary of 255
-- ○ Cast
SELECT CAST(150 AS CHAR); -- converts a value (of any type) into the specified datatype
SELECT CAST("14:06:10" AS TIME); -- converts into time

# COALESCE : COALESCE() function returns the first non-null value in a list
SELECT COALESCE(NULL, 1, 2, 'Sandeep_kumar');

# Sorting Query Results
-- by default, the order by clause lists items in ascending order.
select * from pgpdse_marks order by EDA_marks desc; -- desc keyword to sort in descending order
select * from pgpdse_marks order by EDA_marks,DSA_marks desc; 

# Aggregate Functions : all aggregate functions skip the null values 
-- ○ COUNT
SELECT COUNT(roll_no)FROM pgpdse_marks where name_ like '%a%'; -- count the names which contain letter a anywhere in the text
SELECT COUNT(*) FROM pgpdse_marks;  -- count total rows but never use this as computationally expensive
SELECT COUNT(DISTINCT EDA_marks)FROM pgpdse_marks where name_ like '%a%';  -- distinct count
-- ○ SUM
SELECT SUM(EDA_marks)FROM pgpdse_marks ; -- taking sum of whole column
SELECT SUM(EDA_marks)FROM pgpdse_marks where NPV_marks<40; -- take sum of filterd column where marks are below 40 in NPV_marks
-- ○ AVG
SELECT AVG(EDA_marks)FROM pgpdse_marks ; -- taking average of whole column
SELECT AVG(EDA_marks)FROM pgpdse_marks where NPV_marks<40; -- take average of filterd column where marks are below 40 in NPV_marks
-- ○ MIN
SELECT MIN(EDA_marks)FROM pgpdse_marks ; -- taking MIN of whole column
SELECT MIN(EDA_marks)FROM pgpdse_marks where NPV_marks<40; -- take MIN of filterd column where marks are below 40 in NPV_marks
-- ○ MAX
SELECT MAX(EDA_marks)FROM pgpdse_marks ; -- taking Max of whole column
SELECT MAX(EDA_marks)FROM pgpdse_marks where NPV_marks<40; -- take Max of filterd column where marks are below 40 in NPV_marks

# Group by Function

CREATE TABLE employee1 (joining_month INT, emp_id INT, 
emp_name VARCHAR(15), dept_name VARCHAR(15), salary INT );
INSERT INTO employee1 VALUES
(1, 101, "Sandeep", "HR", 9000),
(1, 102, "Dhruti", "IT", 8000),
(1, 103, "Praksh", "HR", 20000),
(3, 104, "Tushar", "IT", 110123),
(6, 105, "Pragti", "SALES", 3000),
(6,106, "Akansha", "SALES", 101000),
(3,107, "shubham", "IT", 123456),
(Null, 108, "Robert", "IT", 30400);

-- Count the number of employees, in each department, using the Group By clause 
-- along with the count aggregate function as follows

SELECT COUNT(*), dept_name FROM employee1 GROUP BY dept_name; -- Gives count of each department
SELECT dept_name, SUM(salary) FROM employee1 GROUP BY dept_name;-- prints sum of salary department wise
SELECT dept_name, MIN(salary) FROM employee1 GROUP BY dept_name;-- prints min of salary department wise
SELECT dept_name, MAX(salary) FROM employee1 GROUP BY dept_name;-- prints max of salary department wise
SELECT dept_name, AVG(salary) FROM employee1 GROUP BY dept_name;-- prints avg of salary department wise

# Multiple column grouping
SELECT dept_name, joining_month,  -- columns given with select apart from aggregate function must be there in group by
SUM(salary), AVG(salary) FROM employee1 
GROUP BY dept_name, joining_month; -- cant use aggretgate funtions in grouping
Select dept_name , joining_month , sum(salary) From 
employee1 group by dept_name , joining_month; -- Shows the aggregate summary of salaries for those NULL values of the  month.

# Aggregation With Having Clause
-- Having clause is used along with group-by clause in order to apply conditions for the grouped result set
-- Having clause should be enclosed with grouped functions on columns that are issued in the Select query
Select joining_month, dept_name , sum(salary) From employee1 
group by joining_month, dept_name having sum(salary) > 35000;
Select dept_name, joining_month, sum(salary), avg(salary) From -- salary details of employee along 
employee1 -- with the name and month they 
group by dept_name , joining_month having sum(salary) is not null; -- have joined, where the salary is not a null value

#  Having without Group by
Select sum(salary) From employee1 having sum(salary) > 299999; 
-- Difference between where and having
-- | Aspect          | WHERE Clause                                 | HAVING Clause                                       |
-- |-----------------|----------------------------------------------|-----------------------------------------------------|
-- | Usage           | Filters rows before grouping/aggregation     | Filters groups of rows after grouping/aggregation   |
-- | Applied to      | Individual rows in the original dataset      | Groups of rows based on result of aggregations     |
-- | Aggregated data | Not typically used with aggregated columns  | Used with aggregated columns or aggregate functions |
-- | Syntax          | SELECT ... FROM ... WHERE ... GROUP BY ...   | SELECT ... FROM ... GROUP BY ... HAVING ...         |
-- | Execution order | Executed before GROUP BY                    | Executed after GROUP BY                              |
-- | Performance     | Generally faster due to earlier filtering   | May be slower due to grouping/aggregation overhead   |


# Joins
-- ○ Self - Join or equi - Join
-- ○ Non - Equi Join
-- ○ Natural Join 
-- ○ Inner Join
-- ○ Left Outer Join
-- ○ Right Outer Join

# simple join
-- joined two tables employees and department with same column present in both tables
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e , departments d
where e.department_id= d.department_id; 
-- above query can also be written like this 
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e ,(select * from departments) d
where e.department_id= d.department_id; 

-- composite joining key
-- multiple conditions while joining
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e ,(select * from departments) d
where (e.department_id= d.department_id and e.salary<20000 and e.first_name like '%a%');

# INNER JOIN
-- The INNER JOIN is the default type of join that is used to select matching rows in 
-- both tables using common key joining column
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e inner join  departments d
on  e.department_id= d.department_id;

# LEFT JOIN
-- The LEFT JOIN is used when you want to select
-- ○ Matching records that are selected from both the tables and
-- ○ All the valid records from the left table with Null assignment of columns in the
-- right table
-- This type of join is very similar to the normal JOIN, with the only difference being 
-- that it pulls complete details of Left table 
-- The OUTER word in the query is optional
-- show all the employees and their respective deaprtments (some might not assigend with deparment here we can see those)
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e left outer join  departments d
on  e.department_id= d.department_id where department_name is null;
-- here kimberely grant record apper if we do the inner join we never find this record

# RIGHT JOIN
-- The RIGHT JOIN is used when you want to select
-- ○ Matching records from both the tables and
-- ○ All the valid records from the right table with Null assignment of columns in
-- the left table
-- above query with as right join
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from departments d right outer join employees e  
on  e.department_id= d.department_id where department_name is null;
-- here kimberely grant record apper if we do the inner join we never find this record
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e right outer join  departments d
on  e.department_id= d.department_id ;

# FULL OUTER JOIN
-- Full outer Joins helps to retrieve combination of LEFT and RIGHT join results

select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e left outer join  departments d
on  e.department_id= d.department_id 
union
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e right outer join  departments d
on  e.department_id= d.department_id ;

# Natural join
-- if you have two tables with similar columns, a natural join matches the rows where the values in those columns are the same.
select * from employees natural join departments;
-- here manager_id and department_id both the columns are present in both tables so it is cobmibing both columns in matching
-- below is the query that can explain the natural join
select e.department_id,d.department_id,e.manager_id,d.manager_id,e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e , departments d
where e.manager_id=d.manager_id and e.department_id= d.department_id;
-- There are certain restriction on Natural joins:
-- ● Natural Joins needs curated data in the common columns which means all 
-- the common columns should have unique data without duplicates 
-- ● With Natural Joins Chances are high in retrieving too many rows without 
-- meaningful relationships because of duplicate values in Joining key columns
-- ● Natural joins cannot handle NULL values in Joining key columns since it 
-- matches the column values implicitly by SQL and are not written in the SQL 
-- queries

# Queries with three or more tables
select * from employees natural join departments natural join locations;
-- employees and department tables common columns are ( manager_id and department_id ) 
-- department and locations table have common colum  loaction_id
-- query that qunatify above query
select e.department_id,d.department_id,e.manager_id,d.manager_id,e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e , departments d,locations l
where e.manager_id=d.manager_id and e.department_id= d.department_id and l.location_id=d.location_id;

# Other equi-joins
-- ● Like NATURAL JOIN, the EQUI-JOIN / Inner JOIN also matches the rows using 
-- common key columns between tables 
-- ● The only difference with equi-joins and NATURAL join is, joining key columns are 
-- explicitly specified
-- ● Equi - JOIN otherwise called INNER JOIN is simply defined with JOIN / INNER JOIN 
-- clause between two tables but essentially defines with an equal (=) operator. 
-- ● Equi-Joins / INNER JOINS efficiently handles NULL values and comparisons
-- ● Assign default values by replacing NULL values in joining key columns, and ensures 
-- the records are not dropped in the output
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e inner join  departments d
on  e.department_id= d.department_id;
-- Equi - Join can also be implemented with USING clause which replaces WHERE and 
-- equal operator (=) but the column name must be same
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e join departments d using(department_id);


# Non Equi- Joins
-- Non equi-JOINS uses comparison operators like >, < , NOT , <> in order to 
-- filter the records in one table and map the remaining rows across the other 
-- table rows

select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e ,departments d
where (e.department_id= d.department_id and e.salary<20000 and e.first_name like '%a%');

# Self Join
-- SELF JOIN is usually applied when we see meaningful data in a same table
-- ● Self join means joining the same table to itself for multiple times
select e1.first_name,e1.last_name,e2.salary 
from employees e1 ,employees e2
where (e1.employee_id= e2.employee_id and e1.salary<20000 );

# CROSS JOIN
-- combines all rows from left and right tables
select count(*) from employees ; -- 107 rows
select count(*) from departments ; -- 27 rows
select e.first_name,e.last_name,e.salary,d.department_name,d.manager_id 
from employees e cross join departments d; -- 2889 rows

select (107 * 27) As total_rows; -- result : 2889
-- so combine each row with all the rows of other column 



