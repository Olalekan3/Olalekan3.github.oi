CREATE DATABASE [EMPOLYEES]

CREATE TABLE [EMPLOYEE LIST] (EMPLOYEE_ID VARCHAR(99)
							,FULL_NAME VARCHAR(99)
							,MANAGER_ID VARCHAR(99)
							,DATE_OF_JOINING DATE
							,CITY VARCHAR(99)
							,PROJECT VARCHAR(99)
							,SALARY INT
							,VARIABLE VARCHAR(99)
							)

INSERT INTO [dbo].[EMPLOYEE LIST]
VALUES ('121','John Snow','321','2019-01-31','Toronto','P1','8000','500')

INSERT INTO [dbo].[EMPLOYEE LIST]
VALUES ('321','Walter White','986','2020-01-30','California','P2','10000','1000'),
		('421','Kuldeep Rana','876','2021-11-27','New Delhi','P1','12000','0'),
		('655','Alex Brown','955','2020-02-28','London','P1','14000','500'),
		('577','Chris George','487','2021-04-02','Manchester','P2','16000','1000')


--Q1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’.

SELECT EMPLOYEE_ID, FULL_NAME FROM EmployeeDetails WHERE MANAGER_ID = '986';


--Q2. Write an SQL query to fetch the different projects available from the EmployeeSalary table.

SELECT DISTINCT PROJECT FROM EmployeeDetails;


--Q3. Write an SQL query to fetch the count of employees working in project ‘P1’.

SELECT COUNT(EMPLOYEE_ID) FROM EmployeeDetails WHERE PROJECT = 'P1';


--Q4. Write an SQL query to find the maximum, minimum, and average salary of the employees.

SELECT MAX(SALARY) AS MaxSalary, MIN(SALARY) AS MinSalary, AVG(SALARY) AS AvgSalary FROM EmployeeDetails;


--Q5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.

SELECT EMPLOYEE_ID FROM EmployeeDetails WHERE SALARY BETWEEN 9000 AND 15000;


--Q6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.

SELECT * FROM EmployeeDetails WHERE CITY = 'Toronto' AND MANAGER_ID = '321';


--Q7. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321.

SELECT * FROM EmployeeDetails WHERE CITY = 'California' OR MANAGER_ID = '321';


--Q8. Write an SQL query to fetch all those employees who work on Projects other than P1.

SELECT * FROM EmployeeDetails WHERE PROJECT <> 'P1';


--Q9. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.

SELECT EMPLOYEE_ID, FULL_NAME, (SALARY + VARIABLE) AS TotalSalary FROM EmployeeDetails;


--Q10. Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.

SELECT * FROM EmployeeDetails WHERE FULL_NAME LIKE '__hn%';


--Q11. Write an SQL query to fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’.

SELECT EMPLOYEE_ID FROM EmployeeDetails UNION SELECT EmpId FROM EmployeeSalary;





