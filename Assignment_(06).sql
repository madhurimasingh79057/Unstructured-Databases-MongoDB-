create database sale;

use sale;

create table sale(
id int,
emp_name varchar(20),
department varchar(10),
sales_amount int,
sale_date date);

select * from sale;

insert into sale (id,emp_name,department,sales_amount,sale_date)
values(1,"Alice","A",1000,"2024-01-01"),
(2,"Bob","B",1500,"2024-01-02"),
(3,"Alice","A",2000,"2024-01-03"),
(4,"Bob","B",1800,"2024-01-04"),
(5,"Alice","A",1200,"2024-01-05"),
(6,"Bob","B",1600,"2024-01-06");

select * from sale;

#Q1. Total sales per employee (Running Total)?

select emp_name,sale_date,sales_amount,
sum(sales_amount) over(order by sale_date)
as Running_Total_Per_Customer
from sale;

#Q2. Row number per employee?

select  id,emp_name,sale_date,sales_amount,
row_number() over (partition by emp_name order by sale_date)
as Row_numbers from sale;

#Q3. Rank of sales per department.

select emp_name,department,sale_date,sales_amount,
rank() over(partition by department order by sales_amount desc)
as Sales_Rank from sale;

#Q4. Lead (next sale) per employee.

select emp_name,department,sales_amount,
lead(sales_amount) over(partition by department order by sale_date)
as  Next_Sale from sale;

#Q5. Lag (previous sale) per employee.

select emp_name,department,sales_amount,
lag(sales_amount) over(partition by department order by sale_date)
as Previous_sale from sale;

#Q6. Average sales per employee.

select emp_name,sales_amount,
avg(sales_amount) over(partition by emp_name order by sale_date)
as Avg_sale from sale;

#Q7. First and last sales per employee.

select emp_name,sale_date,sales_amount,
first_value(sales_amount) over(partition by emp_name order by sale_date)
as first_Sales,
last_value(sales_amount) over(partition by emp_name order by sale_date rows between unbounded preceding and unbounded  following)
as Last_Sales from sale;

#Q8. Dense rank (no gaps).

select emp_name,department,sales_amount,
dense_rank()over(partition by department order by sales_amount)
as Dense_Sales_Rank from sale;

#Q9. Cumulative average per employee.
select emp_name,department,sales_amount,
cume_dist() over(order by Sales_amount)as Cumulative_Dist
from sale;

#Q10.Find highest sale per employee.

select emp_name,department,sale_date,sales_amount,
max(sales_amount) over(partition by department order by sales_amount desc)
as Highest_Sale from sale;

#Q11.Sales difference from previous record.

with RankedSales as(select id,emp_name,department,sales_amount,sale_date,
lag(sales_amount) over (partition by emp_name order by sale_date) as previous_sales_amount 
from sale) 
select id,emp_name,department,sales_amount,sale_date,
coalesce(previous_sales_amount,0) as previous_sales_amount,
(sales_amount - coalesce(previous_sales_amount,sales_amount)) as Sales_difference
from RankedSales
order by emp_name,sale_date;

#Q12.Cumulative count of sales per employee.

select id,emp_name,department,sales_amount,sale_date,
count(*) over(partition by emp_name order by sale_date rows between unbounded preceding and current row)
as Cumulative_sales_count
from sale;

#Q13.Show if sale is above average per employee.

select emp_name,department,sale_date,sales_amount,
avg(sales_amount) over(partition by emp_name)
as Avg_salary from sale;

#Q14.Find second highest sale per employee.

with RankedSales as (
select id,emp_name,sales_amount,
dense_rank() over(order by sales_amount desc) as sales_rank
from sale)
select id,emp_name,sales_amount
from RankedSales 
where sales_rank =2;