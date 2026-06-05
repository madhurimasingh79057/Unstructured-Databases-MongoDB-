create database Function_create;

use function_create;

#Ques1. Function to calculate square of a number.

create function square_num(n int)
returns int
deterministic
return n*n;

select square_num(9) as Square_num;

#Ques2. Function to add two numbers.

create function addtonum(a int, b int)
returns int
deterministic
return a+b;

select addtonum(78,22) as Add_To_Num;

#Ques3. Function to check even and odd.

create function check_even_odd(n int)
returns varchar (10)
deterministic
return if (n % 2=0,"Even","Odd");

select check_even_odd(7) as Even_Odd;

#Ques4. Function to Calculate Simple interest.

create function simple_interest(p int, r int, t int)
returns int 
deterministic
return (p*r*t)/100;

select simple_interest(7000,5,5) as Simple_interest;

#Ques5. Function to get full name.

create function get_full_name(first_name varchar(15),last_name varchar(15))
returns varchar(60)
deterministic
return concat(first_name,last_name);

select get_full_name("Madhurima","_Singh") as Full_Name;

# Function using table data.

create table emp(id int,name varchar (15),salary int);
insert into emp(id,name,salary) 
values(1,"Madhurima Singh",25000),
(2,"Shiva Singh",30000),
(3,"Vikas",35000),
(4,"Arpit Singh",40000);

select * from emp;

#Ques6. Function to Get salary.

create function get_salary(emp_id int)
returns int
deterministic
return (select salary from emp where emp_id = id);

select get_salary(3) as Salary_by_Id;

#Ques7. Function to find  factorial.

delimiter //
create function findfactorial(n int)
returns bigint
deterministic
begin
declare result bigint default 1;
declare counter int;
set counter = n;
while counter >1 do
set result =result* counter ;
set counter = counter -1;
end while ;
return result ;
end //

delimiter ;
select findfactorial(20) as Factorial_Result;

#Ques8. Function to Count Vovels in a string. 

delimiter  //
create function count_vowels(input_string varchar(60))
returns int 
deterministic
begin 
return char_length(input_string) - char_length(
replace(replace(replace(replace(replace(lower(input_string),"a",""),"e",""),"i",""),"o",""),"u",""));
end //

delimiter ;
select count_vowels("nikita singh") as Count_Vowels;

#Ques9. Function to get Discount price.

delimiter //
create function GetDiscountPrice(original_price int,discount_percentage int)
returns int 
deterministic 
begin 
declare final_price int;
set final_price = original_price- (original_price *(discount_percentage/100));
return final_price;
end //

delimiter ;
select GetDiscountPrice(45000,11) as Final_Price;

#Ques10. Function to calculator.

delimiter //
create function calculator(num1 float,num2 float,operator varchar(1))
returns varchar(50)
deterministic
begin
if operator = "+" then
return cast(num1 + num2 as char);
elseif operator  = "-" then
return cast(num1 - num2 as char);
elseif operator ="*" then 
return cast(num1 * num2  as Char);
elseif operator = "/" then
if num2 = 0 then 
return "Erroe: Zero se divide nhi kar sakte!";
else
return cast(num1/ num2 as char);
end if ;
else
return "Error: Ivalid operator!";
end if ;
end //

delimiter ;
select calculator(10, 45, '+') AS result; 