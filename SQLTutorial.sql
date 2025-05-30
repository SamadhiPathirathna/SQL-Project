create table EmployeeDemographics
(EmployyeID int,
FirstName varchar(50),
LastNAme varchar(50),
Age int,
Gender varchar(50)
)

create table EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int)

insert into EmployeeDemographics values
(1001, 'Jim','Halpert' , 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male'),
(1010, 'Jimbo', 'Halbert' , 30, 'Male'),
(1011, 'Pamela', 'Beasely', 35, 'Female'),
(1012, 'Toby', 'Flenderson',  32, 'Male'),
(Null, 'Sam', 'Flenderson',  32, 'Male'),
(1014, 'Toby', 'Flenderson',  30, 'Male'),
(1015, 'Kevin', 'Scott',  32, 'Male'),
(1016, 'Pam', 'Hudson',  35, 'Female')


Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000),
(1010, 'HR', 52000),
(1011, 'Null', 42000),
(1012, 'Regional Manager', 65000),
(Null, 'Accountant', 42000),
(1014, 'Receptionist', 32000),
(1015, 'Salesman', 48000),
(Null, 'Receptionist', 32000)

/* Select Statment
* , Top, Distinct, Count, As ,Max , Min, Avg
*/
SELECT *
FROM EmployeeDemographics

SELECT *
FROM EmployeeSalary

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT Top 5 *
FROM EmployeeDemographics

SELECT distinct(EmployyeID)
FROM EmployeeDemographics

SELECT distinct(Gender)
FROM EmployeeDemographics

SELECT count(LastName) AS LAstNameCount
FROM EmployeeDemographics

SELECT Max(Salary)
FROM EmployeeSalary

SELECT Min(Salary)
FROM EmployeeSalary

SELECT Avg(Salary)
FROM EmployeeSalary


/* Where Statement
*, <> , <, >, And , Or , Like, Null ,Not Null , In*/

Select *
from EmployeeDemographics
where FirstName= 'Jim'

Select *
from EmployeeDemographics
where FirstName <> 'Jim'

Select *
from EmployeeDemographics
where Age >= 30

Select *
from EmployeeDemographics
where Age <= 32 AND Gender = 'Male'


Select *
from EmployeeDemographics
where Age <= 32 OR Gender = 'Male'


Select *
from EmployeeDemographics
where LastNAme LIKE 'S%'

Select *
from EmployeeDemographics
where LastNAme LIKE '%S%'

Select *
from EmployeeDemographics
where LastNAme LIKE 'S%c%ott%'

Select *
from EmployeeDemographics
where LastNAme is Null

Select *
from EmployeeDemographics
where LastNAme is Not Null

Select *
from EmployeeDemographics
where FirstName IN('Jim', 'Michael')

/* Group By Order By */

Select Gender ,count(Gender)
from EmployeeDemographics
group by Gender

Select Gender , Age, count(Gender)--dervided from data--
from EmployeeDemographics
group by Gender,Age

Select Gender , count(Gender) AS CountGender
from EmployeeDemographics
where Age > 31
group by Gender

Select Gender , count(Gender) AS CountGender
from EmployeeDemographics
where Age > 31
group by Gender
order by Gender

Select*
from EmployeeDemographics
order by Age DESC, Gender DESC

Select*
from EmployeeDemographics
order by 4 DESC, 5 

/* Inner Joins, Full/left/right outer joins */

select *
from EmployeeDemographics

select *
from EmployeeSalary

select *
from EmployeeDemographics
inner join EmployeeSalary
  on EmployeeDemographics.EmployyeID= EmployeeSalary.EmployeeID

select *
from EmployeeDemographics
full outer join EmployeeSalary
  on EmployeeDemographics.EmployyeID= EmployeeSalary.EmployeeID

select *
from EmployeeDemographics
left outer join EmployeeSalary
  on EmployeeDemographics.EmployyeID= EmployeeSalary.EmployeeID

select *
from EmployeeDemographics
right outer join EmployeeSalary
  on EmployeeDemographics.EmployyeID= EmployeeSalary.EmployeeID

select EmployeeID,FirstName, LastNAme, JobTitle, Salary
from EmployeeDemographics
inner join EmployeeSalary
  on EmployeeDemographics.EmployyeID= EmployeeSalary.EmployeeID

select EmployeeDemographics.EmployyeID,FirstName, LastNAme, JobTitle, Salary
from EmployeeDemographics
right outer join EmployeeSalary
  on EmployeeDemographics.EmployyeID= EmployeeSalary.EmployeeID

select EmployeeSalary.EmployeeID,FirstName, LastNAme, JobTitle, Salary
from EmployeeDemographics
left outer join EmployeeSalary
  on EmployeeDemographics.EmployyeID= EmployeeSalary.EmployeeID

select EmployeeDemographics.EmployyeID,FirstName, LastNAme,Salary
from EmployeeDemographics
inner join EmployeeSalary
  on EmployeeDemographics.EmployyeID= EmployeeSalary.EmployeeID
where FirstName<>'Michael'
order by Salary DESC

select JobTitle, AVG(Salary)
from EmployeeDemographics
inner join EmployeeSalary
  on EmployeeDemographics.EmployyeID= EmployeeSalary.EmployeeID
  where JobTitle = 'Salesman'
  group by JobTitle


/* Union ,Union All */
-- Here both table need to have the same data columns and data type--

SELECT EmployyeID, FirstName,Age
FROM EmployeeDemographics
UNION 
SELECT EmployeeID, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeSalary


/* Case Statment */
select FirstName, LastNAme, Age,
case
 when Age > 34 then 'Old'
 when Age between 30 and 34 then 'Young'
 else 'Baby'
 end
from EmployeeDemographics
where Age is not null
order by Age

select FirstName, LastNAme,JobTitle,Salary,
case
	when JobTitle = 'Salesman' then Salary + ( Salary * .10)
	when JobTitle = 'Accountant' then Salary + ( Salary * .05)
	when JobTitle = 'HR' then Salary + ( Salary * .000001)
	else Salary + (Salary * .03)
end as SalaryAfterRaise
from EmployeeDemographics
join EmployeeSalary
 on EmployeeDemographics.EmployyeID=EmployeeSalary.EmployeeID

 /* Having Clause */
 
select JobTitle, count(JobTitle)
from EmployeeDemographics
join EmployeeSalary
 on EmployeeDemographics.EmployyeID=EmployeeSalary.EmployeeID
group by Jobtitle
having count(JobTitle) > 1

select JobTitle, AVG(Salary)
from EmployeeDemographics
join EmployeeSalary
 on EmployeeDemographics.EmployyeID=EmployeeSalary.EmployeeID
group by Jobtitle
having AVG(Salary)> 45000
order by AVG(Salary)

/* Updating and deleting data */

select *
from EmployeeDemographics

update EmployeeDemographics
set EmployyeID=1013
where FirstName = 'Sam'

update EmployeeDemographics
set Age=25 
where FirstName = 'Toby' AND LastNAme='Flenderson'

update EmployeeDemographics
set FirstName='Jane' , LastNAme='Zoe', Gender= 'Female'
where EmployyeID=1012


delete from EmployeeDemographics
where EmployyeID= 1001

/* Aliasing */
select LastNAme as Lastname
from EmployeeDemographics

select FirstName + ' ' + LastNAme AS FullName
from EmployeeDemographics

select AVG(Age) as AVGAge
from EmployeeDemographics

select Demo.EmployyeID, Sal.Salary
from EmployeeDemographics AS Demo
left join EmployeeSalary AS Sal
	 on Demo.EmployyeID = Sal.EmployeeID


/* Partition By */

select FirstName, LastNAme , Gender, Salary
,count(Gender) over (partition by Gender) as TotalGender
from EmployeeDemographics AS Demo
join EmployeeSalary AS Sal
	 on Demo.EmployyeID = Sal.EmployeeID

select FirstName, LastNAme , Gender,Salary,count(Gender)
from EmployeeDemographics AS Demo
join EmployeeSalary AS Sal
	 on Demo.EmployyeID = Sal.EmployeeID
group by FirstName, LastNAme , Gender,Salary

select Gender,count(Gender)
from EmployeeDemographics AS Demo
join EmployeeSalary AS Sal
	 on Demo.EmployyeID = Sal.EmployeeID
group by Gender

/* CTEs --> puting in a temporary data and used once*/

with CTE_Employee as 
(select FirstName, LastNAme , Gender, Salary
,count(Gender) over (partition by Gender) as TotalGender
,AVG(Salary) over (partition by Gender) as AvgSalary
from EmployeeDemographics AS Demo
join EmployeeSalary AS Sal
	 on Demo.EmployyeID = Sal.EmployeeID
	 where Salary > '45000'
)
select FirstName, AvgSalary
from CTE_Employee


/* Temp table --> can be used multiple times*/

create table #temp_Employee(
EmployeeID int,
JobTitle varchar(100),
Salary int )

select *
from #temp_Employee

insert into #temp_Employee values(
1001, 'HR', 45000
)

insert into #temp_Employee
select *
from EmployeeSalary

drop table if exists #temp_Employee2
create table #temp_Employee2(
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int)

insert into #temp_Employee2 
select JobTitle , count(JobTitle) , Avg(Age), AVG(Salary)
from EmployeeDemographics AS Demo
join EmployeeSalary AS Sal
	 on Demo.EmployyeID = Sal.EmployeeID
group by JobTitle

select *
from #temp_Employee2


/*

Today's Topic: String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

*/

--Drop Table EmployeeErrors;


CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- Using Trim, LTRIM, RTRIM.Getting rid of space

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 

	
-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors


-- Using Substring
Select Substring(FirstName,1,3)
FROM EmployeeErrors 

Select Substring(FirstName,3,3)
FROM EmployeeErrors 

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)


Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)



-- Using UPPER and lower

Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors



/*

Today's Topic: Stored Procedures

*/

CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployyeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee
GO;




CREATE PROCEDURE Temp_Employee2 
@JobTitle nvarchar(100)
AS
DROP TABLE IF EXISTS #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployyeID = sal.EmployeeID
where JobTitle = @JobTitle --- make sure to change this in this script from original above
group by JobTitle

Select * 
From #temp_employee3
GO;


exec Temp_Employee2 @jobtitle = 'Salesman'
exec Temp_Employee2 @jobtitle = 'Accountant'


/*

Today's Topic: Subqueries (in the Select, From, and Where Statement)

*/

Select EmployeeID, JobTitle, Salary
From EmployeeSalary

-- Subquery in Select

Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary

-- How to do it with Partition By
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary

-- Why Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
order by EmployeeID


-- Subquery in From

Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
	 Order by a.EmployeeID


-- Subquery in Where


Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID
	From EmployeeDemographics
	where Age > 30)


Create table #Temp_employee2 (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

Select * From #Temp_employee2

Insert into #Temp_employee2 values (
'1001', 'HR', '45000'
)

Insert into #Temp_employee2 
SELECT * From SQLTutorial..EmployeeSalary

Select * From #Temp_employee2




DROP Procedure IF EXISTS #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployyeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee3

SELECT AvgAge * AvgSalary
from #temp_employee3



-- Using Common Table Expressions (CTE)
-- A CTE allows you to define a subquery block that can be referenced within the main query. 
-- It is particularly useful for recursive queries or queries that require referencing a higher level
-- this is something we will look at in the next lesson/

-- Let's take a look at the basics of writing a CTE:


-- First, CTEs start using a "With" Keyword. Now we get to name this CTE anything we want
-- Then we say as and within the parenthesis we build our subquery/table we want
WITH CTE_Example AS 
(
SELECT Gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary), AVG(salary)
FROM EmployeeDemographics dem
JOIN EmployeeSalary sal
	ON dem.EmployyeID= sal.EmployeeID
GROUP BY Gender
)

-- directly after using it we can query the CTE
SELECT *
FROM CTE_Example;


-- Now if I come down here, it won't work because it's not using the same syntax
SELECT *
FROM CTE_Example;



-- Now we can use the columns within this CTE to do calculations on this data that
-- we couldn't have done without it.

WITH CTE_Example AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- notice here I have to use back ticks to specify the table names  - without them it doesn't work
SELECT gender, ROUND(AVG(`SUM(salary)`/`COUNT(salary)`),2)
FROM CTE_Example
GROUP BY gender;



-- we also have the ability to create multiple CTEs with just one With Expression

WITH CTE_Example AS 
(
SELECT employee_id, gender, birth_date
FROM employee_demographics dem
WHERE birth_date > '1985-01-01'
), -- just have to separate by using a comma
CTE_Example2 AS 
(
SELECT employee_id, salary
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000
)
-- Now if we change this a bit, we can join these two CTEs together
SELECT *
FROM CTE_Example cte1
LEFT JOIN CTE_Example2 cte2
	ON cte1. employee_id = cte2. employee_id;


-- the last thing I wanted to show you is that we can actually make our life easier by renaming the columns in the CTE
-- let's take our very first CTE we made. We had to use tick marks because of the column names

-- we can rename them like this
WITH CTE_Example (gender, sum_salary, min_salary, max_salary, count_salary) AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- notice here I have to use back ticks to specify the table names  - without them it doesn't work
SELECT gender, ROUND(AVG(sum_salary/count_salary),2)
FROM CTE_Example
GROUP BY gender;
