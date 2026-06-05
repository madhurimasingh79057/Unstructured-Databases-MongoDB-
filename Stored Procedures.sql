create database employee;

use employee;

create table employee(emp_id int,
emp_name varchar(50),
department varchar(50),
salary int);


insert into employee(emp_id,emp_name,department,salary)
values (1,"Alice","HR",50000),
(2,"Bob","IT",70000),
(3,"Charlie","IT",60000),
(4,"David","HR",55000),
(5,"Eve","Finance",65000);

select * from employee;

#Ques1. Create a procedure to display all employee detail.

delimiter //
create procedure ShowAllEmployee()
begin 
select * from employee;
end //

delimiter ;
call ShowAllEmployee() ;

#Ques2: create a stored proedure to fetch all employees from a specific department.

delimiter //
create procedure ShowEmployeeByDept(dept_name varchar(60))
begin
select * from employee where dept_name=department;
end //

delimiter ;
call ShowEmployeeByDept("Finance");

#Ques3: Create a stored procedure to insert a new employee.

delimiter //
create procedure AddNewEmployee(in id int,
name varchar(20),
dept varchar (20),
total_salary int)

begin 
insert into employee(emp_id,emp_name,department,salary)
values(id,name,dept,total_salary);
end //

delimiter ;
call AddNewEmployee(7,"Madhurima","IT",40000);

select * from employee;

#Ques4. Create a stored procedure to return the total salary of all employees.

delimiter //
create procedure totalsalary()
begin 
select sum(salary) from employee;
end //

delimiter ;
call totalsalary();

#Ques5. create a stored procedure to increase salary by a given percentage for a department.

set sql_safe_updates =0;

delimiter //
create procedure IncreaseSalaryByDept(
in dept_name varchar (50),
increase_percentage int)

begin 
update employee
set salary = salary +(salary * increase_percentage/ 100)
where dept_name= department;
end //

delimiter ;
call IncreaseSalaryByDept("Finance",10);
select * from employee;

#Ques6. Create a stored procedure to delete an employee by id.

delimiter //
create procedure DeleteById(in id int)
begin 
delete from employee where emp_id=id;
end //

delimiter ;
call DeleteById(7);

select * from employee;

#Ques7. Create a procedure to update employee name.

delimiter //
create procedure UpdateEmployeeName(in id int,
in name varchar(20))

begin 
update employee
set emp_name=name
where emp_id = id;
end //

delimiter ;
call UpdateEmployeeName(6,"Aryan");
select * from employee;

#Ques8. Create a procedure to get highest salary employee.

delimiter //
create procedure GetHighestsalary()
begin 
select * from employee
order by  salary desc
limit 1;
end //

delimiter ;
call GetHighestsalary();

select * from employee;

#Ques9. Create a procedure to return average salary.

delimiter //
create procedure AvgSalary()
begin
select avg(salary) from employee ;
end //

delimiter ;
call AvgSalary();

select * from employee;

#Ques10. Create a procedure to count total employee.

delimiter //
create  procedure CountEmployee()
begin
select count(*) from employee;
end //

delimiter ;
call CountEmployee();

#Ques11. Create a procedure to get employee above avg salary.

delimiter //
create procedure AboveAvgSalalry()
begin 
select * from employee
where salary>(select avg(salary) from employee);
end //

delimiter ;
call AboveAvgSalalry();

#Ques12. Create a procedure to add two numbers.

delimiter //
create procedure AddToNum(in a int,in b int)
begin
select a + b;
end //

delimiter ;
call  AddToNum(55,45) ;


#Ques13. Create a procedure to return average salary department wise.

delimiter //
create procedure AvgSalaryByDept()
begin
select department, avg(salary) from employee group by department;
end //

delimiter ;
call AvgSalaryByDept();