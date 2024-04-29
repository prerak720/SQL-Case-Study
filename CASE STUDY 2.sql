												--Case study


select * from [dbo].[DEPARTMENT]
select * from [dbo].[EMPLOYEE]
select * from [dbo].[JOB]
select * from [dbo].[LOCATION]


           
---1. List all the employee details.
select * from employee

--2. List all the department details  
select *  from department

----3. List all job details.
select * from job
--4. List all the locations.

select * from location

--5. List out the First Name, Last Name, Salary, Commission for all Employees.

select first_name,last_name,salary,comm from EMPLOYEE

--6. List out the Employee ID, Last Name, Department ID for all employees and alias
----Employee ID as "ID of the Employee", Last Name as "Name of the
----Employee", Department ID as "Dep_id".

select employee_id as [id of employee],last_name as [name of employee],department_id as [dep_id]
from EMPLOYEE

---7. List out the annual salary of the employees with their names only.

select first_name,last_name,salary from employee

										--WHERE Condition:

----1. List the details about "Smith".

select * from EMPLOYEE
where last_name = 'smith'

----2. List out the employees who are working in department 20.
select * from employee
where DEPARTMENT_ID = '20'

----3. List out the employees who are earning salaries between 3000 and4500.

select * from EMPLOYEE
where SALARY between 3000 and 4500

----4. List out the employees who are working in department 10 or 20.
select * from EMPLOYEE
where DEPARTMENT_ID = '10' or DEPARTMENT_ID =  '20'

----5. Find out the employees who are not working in department 10 or 30.

select * from employee
where DEPARTMENT_ID not in (10 ,30)

----6. List out the employees whose name starts with 'S'.

select * from EMPLOYEE
where LAST_NAME like 's%%'

								---ORDER BY Clause:

--- 1. List out the Employee ID and Last Name in ascending order based on the Employee ID.

select EMPLOYEE_ID,LAST_NAME from EMPLOYEE
order by EMPLOYEE_ID asc


---2. List out the Employee ID and Name in descending order based on salary.

select employee_id,first_name,last_name from EMPLOYEE
order by EMPLOYEE_ID asc

---3. List out the employee details according to their Last Name in ascending-order.

select * from EMPLOYEE
order by LAST_NAME asc

---4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.

select * from employee
order by LAST_NAME asc,department_id desc

							--GROUP BY and HAVING Clause:

--1. How many employees are in different departments in the organization?

select count(EMPLOYEE_ID) as  employee,DEPARTMENT_ID from EMPLOYEE
group by DEPARTMENT_ID

--2. List out the department wise maximum salary, minimum salary and average salary of the employees.

select department_id,min(salary) [min salary],max(salary) as [max salary],avg(salary) as [avg salary] from EMPLOYEE
group by DEPARTMENT_ID

--3. List out the job wise maximum salary, minimum salary and average salary of the employees.

select DESIGNATION,max(salary) as [max salary],min(salary) as [max salary],avg(salary) as [avg salary]from job as a 
inner join EMPLOYEE as b
on a.JOB_ID=b.JOB_ID
group  by DESIGNATION

--4. List out the number of employees who joined each month in ascending order.

select month(HIRE_DATE) AS [MONTH],COUNT(EMPLOYEE_ID) from EMPLOYEE 
GROUP BY month(HIRE_DATE)
ORDER BY month(HIRE_DATE) ASC

--5. List out the number of employees for each month and year in ascending order based on the year and month.

SELECT SUM(EMPLOYEE_ID),MONTH(HIRE_DATE) AS [MONTH],YEAR(HIRE_DATE) AS [YEAR] FROM EMPLOYEE
GROUP BY MONTH(HIRE_DATE),YEAR(HIRE_DATE)
ORDER BY MONTH(HIRE_DATE),YEAR(HIRE_DATE) ASC

--6. List out the Department ID having at least four employees.

SELECT TOP 1  DEPARTMENT_ID,COUNT(EMPLOYEE_ID)  FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
ORDER BY COUNT(EMPLOYEE_ID) DESC

--7. How many employees joined in the month of January?

SELECT EMPLOYEE_ID,MONTH(HIRE_DATE) AS [MONTH] FROM EMPLOYEE
WHERE MONTH(HIRE_DATE) = 1



--8. How many employees joined in the month of January or September?

SELECT COUNT(*) FROM EMPLOYEE
WHERE MONTH(HIRE_DATE) = '1' OR MONTH(HIRE_DATE) = '9'

--9. How many employees joined in 1985?

SELECT COUNT(*) FROM EMPLOYEE
WHERE HIRE_DATE = '1985'

--10. How many employees joined each month in 1985?

SELECT COUNT(*),MONTH(HIRE_DATE) FROM EMPLOYEE
WHERE MONTH(HIRE_DATE) = '1985'
GROUP BY MONTH(HIRE_DATE)

--11. How many employees joined in March 1985?

SELECT COUNT(*) FROM EMPLOYEE
WHERE MONTH(HIRE_DATE) = '3'AND YEAR(HIRE_DATE) = '1985'



--12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?

SELECT DEPARTMENT_ID FROM EMPLOYEE
WHERE  MONTH(HIRE_DATE) = '4' and year(hire_date) = '1985'
group by DEPARTMENT_ID
having COUNT(EMPLOYEE_ID) >= '3'

											----Joins:

--1. List out employees with their department names.

SELECT concat(last_name,' ',first_name),b.[name] from EMPLOYEE as a
join DEPARTMENT as b
on a.DEPARTMENT_ID=b.Department_Id

--2. Display employees with their designations.

select concat(last_name,' ',first_name) from EMPLOYEE as a 
join job as b
on a.JOB_ID=b.JOB_ID

--3. Display the employees with their department names and regional groups.

select concat(last_name,' ',first_name) as [full name],c.City from EMPLOYEE as a 
join DEPARTMENT as b
on a.DEPARTMENT_ID=b.Department_Id
join LOCATION as c 
on b.Location_Id=c.Location_ID


--4. How many employees are working in different departments? Display with department names.

select count(*),b.[Name] from EMPLOYEE as a 
join DEPARTMENT as b
on a.DEPARTMENT_ID = b.Department_Id
group by b.[Name]


--5. How many employees are working in the sales department?

select count(employee_id),b.[Name] from EMPLOYEE as a
join DEPARTMENT as b
on a.DEPARTMENT_ID = b.Department_Id
where b.[Name] = 'sale'
group by count(employee_id)


--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.

select b.[Name],count(employee_id) as  [employee] from EMPLOYEE as a 
join DEPARTMENT as b 
on a.DEPARTMENT_ID=b.Department_Id
group by  b.[Name]
having count(employee_id) >= '5'

--7. How many jobs are there in the organization? Display with designations.

select b.DESIGNATION,count(a.JOB_ID) as [jobs] from employee as a
join JOB as b
on a.JOB_ID=b.JOB_ID
group by b.DESIGNATION


--8. How many employees are working in "New York"?

select * from DEPARTMENT as a
join EMPLOYEE as b
on a.Department_Id=b.DEPARTMENT_ID
join LOCATION as c
on a.Location_Id =c.Location_ID
where city = 'new york'

--9. Display the employee details with salary grades. Use conditional statement to create a grade column.

select * ,
case 
when salary > 1000 and salary < 2000 then 'A'
when salary > 2000 then 'A+'
else 'b'
end as [gread of salary]
from employee



--10. List out the number of employees grade wise. Use conditional statementto create a grade column.

select  
case 
when salary > 1000 and salary < 2000 then 'high'
when salary > 2000 then 'primium'
else 'low'
end 
,count(employee_id) as employee
from employee
group by case 
when salary > 1000 and salary < 2000 then 'high'
when salary > 2000 then 'primium'
else 'low'
end 

--11. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary

select 
case 
when salary > 1000 and salary < 2000 then 'high'
when salary > 2000 then 'primium'
else 'low'
end ,
count (employee_id) from employee
where salary between 2000 and 5000
group by case 
when salary > 1000 and salary < 2000 then 'high'
when salary > 2000 then 'primium'
else 'low'
end  

--12. Display all employees in sales or operation departments.

select * from employee as a
join DEPARTMENT as b
on a.DEPARTMENT_ID=b.Department_Id
where Name = 'sales' or Name = 'Operations'

											----SET Operators:


--1. List out the distinct jobs in sales and accounting departments.

SELECT JOB_ID FROM JOB 
WHERE DESIGNATION = 'ACCOUNTING'
UNION
SELECT JOB_ID FROM JOB
WHERE DESIGNATION = 'SALES' 

--2. List out all the jobs in sales and accounting departments.

SELECT JOB_ID FROM JOB 
WHERE DESIGNATION = 'ACCOUNTING'
UNION ALL
SELECT JOB_ID FROM JOB
WHERE DESIGNATION = 'SALES' 


--3. List out the common jobs in research and accounting departments in ascending order.

SELECT * FROM JOB WHERE DESIGNATION = 'RESEARCH'
INTERSECT 
SELECT * FROM JOB WHERE DESIGNATION = 'ACCOUNTING'

											---	Subqueries:


---1. Display the employees list who got the maximum salary.

select * from EMPLOYEE where  SALARY = (select max(SALARY) from EMPLOYEE)

---2. Display the employees who are working in the sales department.

select * from EMPLOYEE
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT where Name ='sales')

---3. Display the employees who are working as 'Clerk'.

select * from EMPLOYEE 
where JOB_ID = (select JOB_ID from job where DESIGNATION  = 'clerk')

---4. Display the list of employees who are living in "New York".

SELECT DEPARTMENT_ID,FIRST_NAME FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT Location_Id FROM DEPARTMENT WHERE Location_Id = (SELECT City FROM LOCATION
WHERE City = 'NEW YOARK'))

---5. Find out the number of employees working in the sales department

SELECT COUNT(EMPLOYEE_ID) AS [EMPLOYEE] FROM EMPLOYEE 
WHERE DEPARTMENT_ID = (SELECT Department_Id FROM DEPARTMENT WHERE NAME = 'SALES')

---6. Update the salaries of employees who are working as clerks on the basis of 10%.

UPDATE  EMPLOYEE 
SET SALARY = SALARY*1.10
WHERE JOB_ID = (SELECT JOB_ID FROM JOB WHERE DESIGNATION = 'CLERK')

---7. Delete the employees who are working in the accounting department.

DELETE EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT Department_Id FROM DEPARTMENT WHERE NAME = 'ACCOUNTING')

---8. Display the second highest salary drawing employee details.

SELECT * FROM (SELECT *  ,ROW_NUMBER ()OVER ( ORDER BY SALARY ) AS NUM FROM EMPLOYEE ) RANKED
WHERE NUM = '5' 


---9. Display the nth highest salary drawing employee details.

SELECT * FROM (SELECT *  ,ROW_NUMBER ()OVER ( ORDER BY SALARY ) AS NUM FROM EMPLOYEE ) RANKED
WHERE NUM = '3' 

---10. List out the employees who earn more than every employee in department 30.

SELECT * FROM EMPLOYEE 
WHERE SALARY > ALL ( SELECT SALARY FROM EMPLOYEE WHERE DEPARTMENT_ID = '30')

---11. List out the employees who earn more than the lowest salary in
---department.Find out whose department has no employees.

SELECT * FROM EMPLOYEE
WHERE SALARY > (SELECT MIN(SALARY) FROM EMPLOYEE)

SELECT * FROM EMPLOYEE
WHERE NOT EXISTS (SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID = DEPARTMENT_ID)


--12. Find out which department has no employees.

SELECT * FROM DEPARTMENT
WHERE Department_Id NOT IN (SELECT Department_Id FROM EMPLOYEE)

--13. Find out the employees who earn greater than the average salary for their department

SELECT * FROM EMPLOYEE
WHERE SALARY > (SELECT AVG (SALARY) FROM EMPLOYEE)
