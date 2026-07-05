-- use mysql;
-- SQL PRACTICE 
-- Topics covered: SELECT, WHERE, ORDER BY, GROUP BY, HAVING, Aggregate Functions, JOINs, Subqueries
-- ====================================================================================================

## TABLE CREATION-Employees, Department, Students, Courses, Orders
-- =================================================================

CREATE TABLE Departments( DepartmentID INT PRIMARY KEY,
                          DepartmentName VARCHAR(50));
INSERT INTO Departments VALUES 
(1,"IT"),
(2,"Sales"),
(3,"HR"),
(4,"Finance");                          

 CREATE TABLE Employees (EmployeesID INT PRIMARY KEY,
                       EmployeeName VARCHAR(50),
                        Salary int,
                        DepartmentID INT,
                     FOREIGN KEY(DepartmentID) REFERENCES Departments(DepartmentID));
         
INSERT INTO Employees VALUES
(1, 'Saloni', 45000, 2),
(2, 'Rahul', 6000, 1),
(3, 'Aman', 52000,1),
(4, 'Priya', 48000, 3),
(5, 'Kunal', 75000, 1),
(6, 'Neha', 39000, 2),
(7, 'Vikarm', 82000, 4),
(8, 'simran', 55000, 3);      

CREATE TABLE Courses( CourseID INT PRIMARY KEY,
                     CourseName VARCHAR(50));      
 
INSERT INTO Courses VALUES
(1, 'PHP Development'),
(2, 'Data Analytics'),
(3, 'Web Design'); 

CREATE TABLE Students(
               StudentID INT PRIMARY KEY,
               Name VARCHAR(50),
               Marks INT,
               CourseID INT,
               foreign key (CourseID) REFERENCES Courses(CourseID));
               
INSERT INTO Students VALUES
(1, 'Anjali', 85, 1),
(2, 'Rohit', 60, 2),
(3, 'Meena', 92, 1),
(4, 'Suresh', 45, 3),
(5, 'Divya', 78, 2);      

CREATE TABLE Orders( OrderID INT PRIMARY KEY,
                   CustomerName VARCHAR(50),
                   ProductName VARCHAR(50),
                   Amount int,
                   City VARCHAR(50),
                   OrderDate DATE);
                   
INSERT INTO Orders Values
(1, 'Ravi', 'Laptop', 1500, 'Delhi', '2025-02-10'),
(2, 'Sneha', 'Mobile', 800, 'Mumbai', '2024-10-15'),
(3, 'Aditya', 'Tablet', 1200, 'Delhi', '2025-03-05'),
(4, 'Pooja', 'Headphones', 400, 'Pune', '2025-01-20'),
(5, 'Manoj', 'Laptop', 1600, 'Mumbai', '2025-04-01');                   
                       
select * from Departments;
select * from Employees;
select * from Courses;
select * from Orders;

-- =====================================================================================================    

## QUESTIONS AND ANSWERS

-- =========================================================================================================

-- Q1 : Display all records from Employees
select * from Employees;

-- Q2 : Display only EmployeeName and Salary
select EmployeeName, Salary FROM Employees;

-- Q3 : Employees with salary greater than 50000
select * from Employees WHERE Salary>50000;

-- Q4 : Employees working in the IT department
select e. * from Employees e JOIN Department d ON e.DepartmentID=d.DepartmentID WHERE d.DepartmentName = 'IT';

-- Q5 : Sort employees by salary (highest first)
select * from Employees ORDER BY Salary DESC limit 1;

-- Q6 : Total number of Employees 
select count(*) as Total_Employees from Employees;

-- Q7 : MAX, MIN AND AVERAGE Salary
select max(salary) as MAX_SALARY,
min(salary) as MIN_SALRY,
avg(salary) as AVERAGE_SALARY from Employees;

-- Q8 : Minimun salary in each department
select DepartmentID, min(salary) as MIN_SALARY from Employees group by DepartmentID;

-- Q9 : Departments having more than 1 employee
select DepartmentID, count(*) as Employee_count from Employees GROUP BY DepartmentID having count(*)>1;

-- Q10 :Employee names along with their department names
select e.EmployeeName, d.DepartmentName from Employees e INNER JOIN Departments d ON e.DepartmentID=d.DepartmentID;

-- Q11 : All departments with employee names(include departments with no employees)
select d.DepartmentName, e.EmployeeName from Departments d LEFT JOIN Employees e ON d.DepartmentID=e.DepartmentID;

-- Q12 :All departments including those without any employee 
select d.DepartmentName from Departments d LEFT JOIN Employees e ON d.DepartmentID=e.DepartmentID WHERE e.EmployeeSID IS NULL;

-- Q13 : Sort employees by salary (highest first) including department 
select e.EmployeeName, e.Salary, d.DepartmentName from Employees e JOIN Departments d ON e.DepartmentID=d.DepartmentID order by e.Salary desc;

-- Q14 : Find students enrolled in the course named "php development"
select s.Name from Students s INNER JOIN Courses c ON s.CourseID=c.CourseID WHERE c.CourseName='PHP Development';

-- Q15 :Display orders placed after 2025-01-01
select * from Orders WHERE OrderDate>'2025-01-01';

-- Q16 :Find total order amount for each city
select City, sum(amount) as TOTAL_AMOUNT from Orders GROUP BY City;

-- Q17 : Show customer name and product name where amount is between 500 and 2000
select CustomerName, ProductName from Orders WHERE Amount BETWEEN 500 AND 2000;

-- Q18 : Find the city with ,maximum total sales
select City, sum(amount) as TOTAL_SALES from Orders GROUP BY CITY  ORDER BY TOTAL_SALES DESC LIMIT 1;

-- Q19 : List students whose marks are above the average marks
select * from Students WHERE Marks> (select avg(Marks) from Students);

-- Q20 :Display course names that have no students enrolled
select c.CourseName from Courses c LEFT JOIN Students s ON c.CourseID=s.CourseID WHERE s.StudentID IS NULL;









