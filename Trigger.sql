#Ques1. Create a trigger that updates an inventory table whenever a new sale is recorded in the sales table.alter
# Specifically, when a new sale is inserted into the sales table,the trigger should decrease the quantity of the corresponding product in the inventory table.

create database invertory;

use invertory;

create table invertory(product_id int primary key ,
product_name varchar(50),
quantity int);

create table sales(sale_id int auto_increment key,
product_id int ,
amount decimal(10,2),
sale_date date,
quantity_sold int );

#Ques2. Insert sample data into the invertory table.

insert into invertory(product_id,product_name,quantity)
values(1,"product A",100),
(2,"product B",150),
(3,"product C",200);

#Ques3.Create the trigger.

delimiter //
create trigger afte_sales_insert
after insert on sales
for each row 
begin
update invertory
set quantity = quantity -new.quantity_sold
where product_id = new.product_id;
end //

#Ques4.insert a new sale to test the trigger.
delimiter ;
insert into sales(product_id,amount,sale_date,quantity_sold)
values(1,900,"2026-05-31",10);

select * from sales;
select * from invertory;

create table employee(emp_id int primary key ,
name varchar(50),
department varchar(50));

insert into employee(emp_id,name,department)
values(1,"Alice","HR"),
(2,"Bob","IT"),
(3,"Charlie","Finance");

select * from employee;

create table delete_employee(log_id int auto_increment key,
emp_id int ,
emp_name varchar(50),
emp_department varchar(50),
deleted_at datetime);

select * from delete_employee;

delimiter //
create trigger after_delete_emp
after delete on employee
for each row
begin
insert into delete_employee(emp_id,emp_name,emp_department,deleted_at)
values(old.emp_id,old.name,old.department,now());
end //

delimiter ;
delete from employee where emp_id=3 ;

select * from employee;
select * from delete_employee;

create table empl(emp_id int primary key,
name varchar(50),
salary decimal(10,2));

insert into empl(emp_id,name,salary)
values(1,"Aryan",40000),
(2,"Shiva",50000),
(3,"Vikas",60000),
(4,"Madhu",70000);

create table empl_log(lod_id int auto_increment primary key,
emp_id int,
name varchar(50),
action varchar(50),
log_time timestamp default current_timestamp);

select * from empl;

#Ques1. Trigger to log insert actinity.
delimiter //
create trigger after_empl_insert
after insert on empl
for each row
begin
insert into empl_log(emp_id,name,action,log_time)
values(new.emp_id,new.name,"Inserted",now());
end //

delimiter ;
insert into empl(emp_id,name,salary)
values(5,"Arpit",50000);

select * from empl;
select * from empl_log;

#Ques2. Trigger to log salary changes.

create table salary(emp_id int primary key,
name varchar(50),
salary int);

insert into salary(emp_id,name,salary)
values(1,"Shiva",30000),
(2,"Vikas",35000),
(3,"Sumit",40000);

select * from salary;

create table salary_log(log_id int auto_increment primary key ,
emp_id int,
old_salary decimal(10,2),
new_salary decimal(10,2),
time_log timestamp default current_timestamp);

delimiter //
create trigger after_update_salary
after update on salary
for each row 
begin
insert into salary_log(emp_id,old_salary,new_salary)
values(old.emp_id,old.salary,new.salary);
end //

delimiter ;
update salary 
set salary = 90000
where emp_id = 2;

select * from salary;
select * from salary_log;

#Ques3. Trigger to convert  Employee name to uppercase.

delimiter //
create trigger name_to_uppercase
before insert on empl
for each row 
begin 
set new.name= upper(new.name);
end //

delimiter ;
insert into empl(emp_id,name,salary)
value(6,"Om",55000);
select * from empl;

#Ques4. Trigger to prevent Negative salary.

delimiter //

create trigger try_before_insert_salary
before insert on empl
for each row
begin 
if new.salary < 0 then 
signal sqlstate "45000"
set message_text = "Salary cannot be negative";
end  if ;
end //

delimiter ;
insert into empl(emp_id,name,salary)
value (7,"Sudha",20000);

select * from empl;

#Ques5. Trigger to restrict salary Reduction.

delimiter //

create trigger try_before_insert_salary1
before update  on empl
for each row
begin 
if new.salary <25000 then 
signal sqlstate  "45000"
set message_text = "salary reduction not allowed";
end if ;
end //

delimiter ;
update empl 
set salary =20000
where emp_id = 1;

select * from empl;

#Ques6. Trigger to Name changes.
show tables;

create table emply(id int,
name varchar(20),
salary int);

insert into emply(id,name,salary)
values(1,"Alice",55000),
(2,"Bob",60000);

select * from emply;

create table emply_log(log_id int auto_increment primary key ,
emp_id int,
emp_name varchar(20),
action varchar(20),
log_time timestamp default current_timestamp);

delimiter //
create trigger after_emply_insert
after insert on emply
for each row 
begin
insert into emply_log(emp_id,emp_name,action,log_time)
values(new.id,new.name,"Name Change",now());
end//

delimiter ;
insert into emply(id,name,salary)
values(3,"Charlie",50000);


select * from emply_log;
#Ques7. Set Default Salary.

delimiter //
create trigger set_default_salary
before insert on emply
for each row
begin
if new.salary is null then 
set new.salary= 15000;
end if;
end //

delimiter ;
insert into emply(id,name)
values(5,"OM");

select * from emply ;

# Ques8. Create a trigger to Automatically Increase  Salary by 10%.

delimiter //
create trigger increase_salary_by_10_percent
before insert on salary 
for each row 
begin
set new.salary = new.salary +(new.salary *0.10);
end //

delimiter ;

insert into salary(emp_id,name,salary)
value(4,"Deepu",25000);

select * from salary;

# Ques9. Create a trigger to store old and new salary Change.

create table salary_change(log_id int auto_increment primary key,
emp_id int,
old_salary decimal(10,2),
action varchar(50),
new_salary decimal(10,2),
log_time timestamp default current_timestamp);

select * from salary_change;
select * from emply;

delimiter //
create trigger salary_change
after update on emply
for each row 
begin 
insert into salary_change(emp_id,old_salary,action,new_salary)
values(old.id,old.salary,"Salary change from",new.salary);
end //

delimiter ;
update emply 
set salary = 50000
where id = 1;

select * from emply;
select * from salary_change;

#Ques10. Create a trigger to count total salary.

