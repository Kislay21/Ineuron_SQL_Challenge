create database assignment1;
use assignment1;

create table world(
name varchar(15) primary key,
continent varchar(15),area int,population bigint,gdp bigint);

insert into world values('Afghanistan','Asia',652230,25500100,20343000000),
('Albania','Europe',28748,2831741,12960000000),
('Algeria','Africa',2381741,37100000,188681000000),
('Andorra','Europe',468,78115,3712000000),
('Angola','Africa',1246700,20609294,100990000000);


select name,population,area from world
where area>=3000000 or population >= 25000000;

create table customer(id int primary key,name varchar(10),
referee_id int);

insert into customer values(1,'Will',null),(2,'Jane',null),
(3,'Alex',2),(4,'Bill',null),(5,'Zack',1),(6,'Mark',2);

select name from customer where referee_id <> 2
or referee_id is null;

create table customers(id int primary key,
name varchar(15));

create table orders(id int primary key,
cust_id int);

insert into customers values(1,'Joe'),(2,'Henry'),(3,'Sam'),(4,'Max');
insert into orders values(1,3),(2,1);

select name from customers where id not in
                  (select cust_id from orders);
                  
create table employee(emp_id int primary key,
team_id int);

insert into employee values(1,8),(2,8),(3,8),
(4,7),(5,9),(6,9);

select emp_id,
count(team_id) over(partition by team_id) as team_size
from employee;

create table Person(id int primary key,name varchar(15),
phone varchar(15));

create table Country(name varchar(15),
country_code varchar(15) primary key);

create table Calls(caller_id int,callee_id int,
duration int);

insert into Person values(3,'Jonathan','051-1234567'),(12,'Elvis','051-7654321'),
(1,'Moncef','212-1234567'),(2,'Maroua','212-6523651'),(7,'Meir','972-1234567'),
(9,'Rachel','972-0011100');

insert into Country values('Peru',51),('Israel',972),('Morocco',212),
('Germany',49),('Ethiopia',251);

insert into Calls values(1,9,33),(2,9,4),(1,2,59),(3,12,102),
(3,12,330),(12,3,5),(7,9,13),(7,1,3),(9,7,1),(1,7,7);

with phn as(select caller_id as id,duration from calls
            union all
            select callee_id as id,duration from calls)
            
select c.name as country from phn
join person p on phn.id = p.id
join country c on left(p.phone,3) = c.country_code
group by c.name
having avg(duration)>(select avg(duration) from Calls);

create table activity(player_id int,device_id int,
event_date date,games_played int,primary key(player_id,event_date));

insert into activity values(1,2,'2016-03-01',5),(1,2,'2016-05-02',6),
(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

select distinct(player_id),
first_value(device_id)over(partition by player_id order by event_date asc) as device_id
from activity;

create table orders(order_no int primary key,
cust_no int);

insert into orders values(1,1),(2,2),(3,3),(4,3);

select cust_no from orders
group by cust_no
order by count(*) desc limit 1;

create table cinema(seat_id int auto_increment primary key,
free int);

insert into cinema values(1,1),(2,0),(3,1),(4,1),(5,1);

select seat_id from cinema where free = 1 and 
(seat_id+1 in (select seat_id from cinema where free = 1)
or seat_id-1 in (select seat_id from cinema where free = 1));

create table salesperson(sales_id int primary key,
name varchar(15),salary int,commission_rate int,hire_date date);

create table Company(com_id int primary key,
name varchar(15),city varchar(15));

create table orders(order_id int primary key,
order_date varchar(15),com_id1 int,sales_id1 int,amount int,
foreign key(com_id1) references Company(com_id),
foreign key(sales_id1) references Salesperson(sales_id));

insert into salesperson values(1,'John',100000,6,4/1/2006),
(2,'Amy',12000,5,5/1/2010),(3,'Mark',65000,12,12/25/2008),
(4,'Pam',25000,25,1/1/2005),(5,'Alex',5000,10,2/3/2007);

insert into Company values(1,'RED','Boston'),(2,'Orange','New york'),
(3,'Yellow','Boston'),(4,'Green','Austin');

insert into Orders values(1,'1/1/2014',3,4,10000),(2,'2/1/2014',4,5,5000),
(3,'3/1/2014',1,1,50000),(4,'4/1/2014',1,4,25000);


select s.name from salesperson s
where s.sales_id not in(
                    select sales_id1 from orders o
                    inner join company c 
					on o.com_id1 = c.com_id 
                    where o.com_id1 in 
                          (select c.com_id from company c where c.name= 'RED'));
                          
create table triangle(x int,y int,z int,
primary key(x,y,z));

insert into triangle values(13,15,30),(10,20,15);

select x,y,z,
    case when (x*x + y*y)>(z*z) then 'Yes'
		  else 'no'
	end as triangle
from triangle;
    
create table point(x int primary key);
insert into point values(-1),(0),(2);

Select min(abs(p2.x - p1.x)) as shortest
from point p1 JOIN point p2
ON p1.x != p2.x;

create table Actordirector(actor_id int,director_id int,
`timestamp` int primary key);

insert into Actordirector values(1,1,0),(1,1,1),
(1,1,2),(1,2,3),(1,2,4),(2,1,5),(2,1,6);

select distinct(actor_id),director_id from Actordirector where actor_id = director_id and
(actor_id + 1 = director_id + 1
or actor_id - 1 = director_id - 1);

create table Sales(sale_id int,product_id int,
year int,quantity int,price int,
primary key(sale_id,year));

create table product(product_id int primary key,
product_name varchar(15));

insert into Sales values(1,100,2008,10,5000),(2,100,2009,12,5000),
(7,200,2011,15,9000);

insert into Product values(100,'Nokia'),(200,'Ápple'),(300,'Samsung');

select p.product_name,s.year,s.price
from product p right join sales s
on p.product_id = s.product_id;

create table employees(emp_id int primary key,
name varchar(15),experience_years int);

create table project(project_id int, employee_id int,
primary key(project_id,employee_id),
foreign key(employee_id) references employees(emp_id));

insert into employees values(1,'Khaled',3),(2,'Ali',2),(3,'John',1),(4,'Doe',2);
insert into project values(1,1),(1,2),(1,3),(2,1),(2,4);

select p.project_id,round(avg(experience_years),2) as average_years
from project p inner join employees e
on p.employee_id = e.emp_id
group by p.project_id;

create table produkt(product_id int primary key,
product_name varchar(15),unit_price int);

create table sales(seller_id int,product_id1 int,
buyer_id int,sale_date date,quantity int,price int,
foreign key(product_id1) references produkt(product_id));

insert into produkt values(1,'S8',1000),(2,'G4',800),(3,'Iphone',1400);

insert into sales values(1,1,1,'2019-01-21',2,2000),(1,2,2,'2019-02-17',1,800),
(2,2,3,'2019-06-02',1,800),(3,3,4,'2019-05-13',2,2800);

select distinct(seller_id)
from sales
group by seller_id
having sum(price) = (select sum(price) as sum
                      from sales
                      group by seller_id
                      order by sum desc limit 1);

select buyer_id from sales s
where product_id1 in (select product_id from produkt p
                     where product_name = 'S8' and product_name <> 'iphone');
                     
create table cust(cust_id int,name varchar(15),
visited_on date,amount int,
primary key(cust_id,visited_on));

insert into cust values(1,'Jhon','2019-01-01',100),(2,'Daniel','2019-01-02',110),
(1,'Jade','2019-01-03',120),(4,'Khaled','2019-01-04',130),(5,'Winston','2019-01-05',110),
(6,'Elvis','2019-01-06',140),(7,'Anna','2019-01-07',150),(8,'Maria','2019-01-08',80),
(9,'Jaze','2019-01-09',110),(1,'Jhon','2019-01-10',130),(3,'Jade','2019-01-10',150);

select c1.visited_on, sum(c2.amount) as amount, 
round(avg(c2.amount), 2) as average_amount
from (select visited_on, sum(amount) as amount 
      from cust group by visited_on) c1
join (select visited_on, sum(amount) as amount 
      from cust group by visited_on) c2
on datediff(c1.visited_on, c2.visited_on) between 0 and 6
group by c1.visited_on
having count(c2.amount) = 7;

create table scores(player_name varchar(15),
gender varchar(15),day date,score_points int,
primary key(gender,day));

insert into scores values('Aron','F','2020-01-01',17),('Alice','F','2020-01-07',23),
('Bajrang','M','2020-01-07',7),('Khali','M','2019-12-25',11),('Salman','M','2019-12-30',13),
('Joe','M','2019-12-31',3),('Jose','M','2019-12-18',2),('Priya','F','2019-12-31',23),
('Priyanka','F','2019-12-30',17);

select gender,day,
Sum(score_points) over(partition by gender order by day) as 'total'
from scores
order by gender asc;

create table logs(log_id int primary key);

insert into logs values(1),(2),(3),(7),(8),(10);

select min(log_id) as start_id, max(log_id) as end_id
from (select *, row_number() over (order by log_id) as row_num from logs
      ) as a
group by (log_id - row_num)
order by min(log_id);

create table students(student_id int primary key,
student_name varchar(15));

create table subjects(subject_name1 varchar(15) primary key);

create table exams(student_id1 int,subject_name2 varchar(15));

insert into students values(1,'Alice'),(2,'Bob'),(13,'John'),(6,'Alex');

insert into subjects values('Math'),('Physics'),('Programming');

insert into exams values(1,'Math'),(1,'Physics'),(1,'Programming'),
(2,'Progamming'),(1,'Physics'),(1,'Math'),(13,'Math'),(13,'Programming'),
(13,'Physics'),(2,'Math'),(1,'Math');

select a.student_id,a.student_name,b.subject_name1,count(c.student_id1) as 'attended_exams'
from students a inner join subjects b 
left join exams c 
on a.student_id = c.student_id1 and b.subject_name1 = c.subject_name2
group by a.student_id,b.subject_name1;

create table employeees(emp_id int primary key,emp_name varchar(15),
manager_id int);

insert into employeees values(1,'Boss',1),(3,'Alice',3),(2,'Bob',1),(4,'Daniel',2),
(7,'Luis',4),(8,'Jhon',3),(9,'Angela',8),(77,'Robert',1);

select emp_id as employee_id from Employeees where manager_id in
(select emp_id from Employeees where manager_id in
(select emp_id from Employeees where manager_id =1))
and emp_id !=1;

create table transactions(id int primary key,
country varchar(15),state varchar(15),amount int,trans_date date);

insert into transactions values(121,'US','approved',1000,'2018-12-18'),
(122,'US','declined',2000,'2018-12-19'),(123,'US','approved',2000,'2019-01-01'),
(124,'DE','approved',2000,'2019-01-07');

select date_format(trans_date,"%y-%m") as month,country,
count(id) as trans_count,
sum(case when state='approved' then 1 else 0 end) as 'approved_count',
sum(amount) as trans_total_amount,
sum(case when state='approved' then amount else 0 end) as 'approved_total_amount'
from transactions
group by month,country;

create table actions(user_id int,post_id int,
action_date date,action varchar(15),extra varchar(15));

create table removals(post_id int primary key,remove_date date);

insert into actions values(1,1,'2019-07-01','view','null'),
(1,1,'2019-07-01','like','null'),(1,1,'2019-07-01','share','null'),
(2,2,'2019-07-04','view','null'),(2,2,'2019-07-04','report','spam'),
(3,4,'2019-07-04','view','null'),(3,4,'2019-07-04','report','spam'),
(4,3,'2019-07-02','view','null'),(4,3,'2019-07-02','report','spam');

insert into removals values(2,'2019-07-20'),(3,'2019-07-18');

select round(avg(daily),2) as average_daily_percent from
(select count(distinct(r.post_id))/count(distinct a.post_id)*100  as 'daily'
from actions a left join removals r
on a.post_id = r.post_id
where a.extra = 'spam'
group by action_date) as t;

select * from activity;

create table salaries(company_id int,employee_id int,
emp_name varchar(15),salary int,
primary key(company_id,employee_id));

insert into salaries values(1,1,'Tony',2000),
(1,2,'Pronub',21300),(1,3,'Tyrrox',10800),(2,1,'Pam',300),
(2,7,'Bassem',450),(2,9,'Hermione',700),(3,7,'Bocaben',100),
(3,2,'Ognjen',2200),(3,13,'Nyan Cat',3300),(3,15,'Morning cat',7777);

with cte as(
    select company_id,
    (case when max(salary) < 1000 then 1.0
          when max(salary) <= 10000 then 0.76
          else 0.51
	end) as tax
    from salaries 
    group by company_id)
    
select s.company_id, s.employee_id, s.emp_name, ROUND(s.salary * t.tax) as salary
from Salaries s join cte t on s.company_id = t.company_id;

create table sales(sale_date date,fruit varchar(15),sold_num int,
primary key(sale_date,fruit)); 

insert into sales values('2020-05-01','apples',10),('2020-05-01','oranges',8),
('2020-05-02','apples',15),('2020-05-02','oranges',15),('2020-05-03','apples',20),
('2020-05-03','oranges',0),('2020-05-04','apples',15),('2020-05-04','oranges',16);

select s.sale_date,
sum(if(s.fruit = 'apples', s.sold_num, -s.sold_num)) as diff
from Sales s
group by s.sale_date;

create table Variables(name varchar(15) primary key,
value int);

create table Expressions(left_operand varchar(15),operator varchar(15),
right_operand varchar(15),
primary key(left_operand,operator,right_operand));
insert into Variables values('x',66),('y',77);
insert into Expressions values('x','>','y'),('x','<','y'),
('x','=','y'),('y','>','x'),('y','<','x'),('y','=','x');

select e.left_operand, e.operator, e.right_operand,
(case
	when e.operator = '<' then if(l.value < r.value,'true','false')
	when e.operator = '>' then if(l.value > r.value,'true','false')
	else if(l.value = r.value,'true','false')
end) as value
from expressions e 
left join variables l on e.left_operand = l.name 
left join variables r on e.right_operand = r.name;

create table student(id int,name varchar(15),marks int);

insert into student values(1,'Ashley',81),(2,'Samantha',75),(4,'Julia',76),
(3,'Belvet',84);

select name from student 
where marks>75
order by SUBSTR(Name, -3), id asc;

create table emp(emp_id int,name varchar(15),
months int,salary int);

insert into emp values(12228,'Rose',15,1968),(33645,'Angela',1,3443),
(45692,'Frank',17,1808),(56118,'Pattrick',7,1345),(59725,'Lisa',11,2330),
(74197,'Kimberley',16,4372),(78454,'Bonnie',8,1771),(83565,'Michael',6,2017),
(98607,'Todd',5,3396),(99989,'Joe',9,3573);

select name from emp
order by name asc;

select name from emp
where salary > 2000 and months < 10
order by emp_id asc;

create table triangles(A int, B int, C int);
insert into triangles values (20,20,23),(20,20,20),(20,21,22),(13,14,30);
select * from triangles;
select (case when A=B and B=C then 'Equilateral'
			when A=B or B=C or A=C then 'Isosceles'
            when A+B<=C or A+C<=B or B+C<=A then 'Not a Triangle'
            else 'Scalene'
		end) as output
from triangles;

create table user_transactions(transaction_id int,product_id int,
spend decimal,transaction_date datetime);

insert into user_transactions values
(1341,123424,1500.60,STR_TO_DATE("2019/12/31 12:00:00", "%Y/%m/%d %H:%i:%s")),
(1423,123424,1000.20,STR_TO_DATE("2020/12/31 12:00:00", "%Y/%m/%d %H:%i:%s")),
(1623,123424,1266.44,STR_TO_DATE("2021/12/31 12:00:00", "%Y/%m/%d %H:%i:%s")),
(1322,123424,2145.32,STR_TO_DATE("2022/12/31 12:00:00", "%Y/%m/%d %H:%i:%s"));

select * from user_transactions;

with cte1 as
          (select extract(year from transaction_date) as year,
           product_id,spend as 'curr_year_spend' 
           from user_transactions),
cte2 as 
	(select *,lag(curr_year_spend,1) over(partition by product_id order by product_id,year)
	as 'prev_year_spend' from cte1)
select year,product_id,curr_year_spend,prev_year_spend,
round(100*(curr_year_spend-prev_year_spend)/prev_year_spend,2) as 'yoy_rate'
from cte2;

create table inventory(item_id int,item_type varchar(25),
item_category varchar(35),square_footage decimal);

insert into inventory values(1374,'prime_eligible','mini refrigerator',68.00),
(4245,'not_prime','standing lamp',26.40),(3255,'prime_eligible','television',85.00),
(3255,'not_prime','side table',22.60),(1672,'prime_eligible','laptop',8.50);

with summary as (  
           select  item_type,sum(square_footage) as total_sqft,count(*) as 'item_count'
           from inventory  group by item_type),
prime_items as (  
          select  distinct item_type, total_sqft,
          truncate(500000/total_sqft,0) as prime_combo,
          (truncate(500000/total_sqft,0) * item_count) as prime_count from summary  
           where item_type = 'prime_eligible'),
non_prime_items as (select distinct item_type, total_sqft,  
truncate((500000 - (select prime_combo * total_sqft from prime_items))  
      / total_sqft,0)  * item_count as non_prime_item_count  
from summary where item_type = 'not_prime')
  
select item_type,  prime_count as item_count from prime_items  
union all  
select item_type,non_prime_item_count as item_count  from non_prime_items;

create table user_actions(user_id int,event_id int,event_type varchar(15),
event_date datetime);

insert into user_actions values
(445,7765,'sign-in',STR_TO_DATE("2022/05/31 12:00:00", "%Y/%m/%d %H:%i:%s")),
(742,6458,'sign-in',STR_TO_DATE("2022/06/03 12:00:00", "%Y/%m/%d %H:%i:%s")),
(445,3634,'like',STR_TO_DATE("2022/06/05 12:00:00", "%Y/%m/%d %H:%i:%s")),
(742,1374,'comment',STR_TO_DATE("2022/06/05 12:00:00", "%Y/%m/%d %H:%i:%s")),
(648,3124,'like',STR_TO_DATE("2022/06/18 12:00:00", "%Y/%m/%d %H:%i:%s"));
select * from user_actions;
select 
  extract(month from curr_month.event_date) as mth, 
  count(distinct curr_month.user_id) as monthly_active_users 
from user_actions as curr_month
where exists (
  select last_month.user_id 
  from user_actions as last_month
  where last_month.user_id = curr_month.user_id
    and extract(month from last_month.event_date) =
    extract(month from curr_month.event_date - 1)
)
  and extract(month from curr_month.event_date) = 6
  group by extract(month from curr_month.event_date);

create table search(searches int,num_users int);
insert into search values(1,2),(2,2),(3,3),(4,1);


create table advertiser(user_id varchar(15),status varchar(15));
create table daily_pay(user_id varchar(15),paid decimal);
insert into advertiser values('bring','NEW'),('yahoo','NEW'),('alibaba','EXISTING');
insert into daily_pay values('yahoo',45.00),('alibaba',100.00),('target',13.00);

select a.user_id,
(case when a.status = 'NEW' and b.paid is null Then 'CHURN'
else 'EXISTING'
end ) as new_status
from advertiser a left join daily_pay b
on a.user_id = b.user_id;

create table servers(server_id int,status_time timestamp,
session_status varchar(15));

insert into servers values
(1,STR_TO_DATE("2022/08/02 10:00:00", "%Y/%m/%d %H:%i:%s"),'start'),
(1,STR_TO_DATE("2022/08/04 10:00:00", "%Y/%m/%d %H:%i:%s"),'stop'),
(2,STR_TO_DATE("2022/08/17 10:00:00", "%Y/%m/%d %H:%i:%s"),'start'),
(2,STR_TO_DATE("2022/08/24 10:00:00", "%Y/%m/%d %H:%i:%s"),'stop');
select * from servers;


create table transactions(trans_id int,merchant_id int,
credit_card_id int,amount int,transaction_timestamp datetime);

insert into transactions values
(1,101,1,100,STR_TO_DATE("2022/09/25 12:00:00", "%Y/%m/%d %H:%i:%s")),
(2,101,1,100,STR_TO_DATE("2022/09/25 12:08:00", "%Y/%m/%d %H:%i:%s")),
(3,101,1,100,STR_TO_DATE("2022/09/25 12:28:00", "%Y/%m/%d %H:%i:%s")),
(4,102,2,300,STR_TO_DATE("2022/09/25 12:00:00", "%Y/%m/%d %H:%i:%s")),
(5,102,2,400,STR_TO_DATE("2022/09/25 14:00:00", "%Y/%m/%d %H:%i:%s"));
select * from transactions;
with payment as
(select *,extract(minute from transaction_timestamp - lag(transaction_timestamp)
over (partition by merchant_id,credit_card_id,amount order by transaction_timestamp))
as 'minute_diff' 
from transactions)
select count(merchant_id) as 'payment_count'
from payment
where minute_diff<=10;

create table orders(order_id int,cust_id int,trip_id int,
status varchar(35),order_timestamp timestamp);

insert into orders values(727424,8472,100463,'completed sucessfully',
STR_TO_DATE("2022/06/05 09:12:00", "%Y/%m/%d %H:%i:%s")),
(242513,2341,100482,'completed incorrectly',
STR_TO_DATE("2022/06/05 14:40:00", "%Y/%m/%d %H:%i:%s")),
(141367,1314,100362,'completed incorrectly',
STR_TO_DATE("2022/06/07 15:03:00", "%Y/%m/%d %H:%i:%s")),
(582193,5421,100657,'never recieved',
STR_TO_DATE("2022/07/07 15:22:00", "%Y/%m/%d %H:%i:%s")),
(253613,1314,100213,'completed sucessfully',
STR_TO_DATE("2022/06/12 13:43:00", "%Y/%m/%d %H:%i:%s"));

create table trips(dasher_id int,trip_id int,
estimated_delivery timestamp,actual_delivery timestamp);

insert into trips values(101,100463,STR_TO_DATE("2022/06/05 09:42:00", "%Y/%m/%d %H:%i:%s"),
STR_TO_DATE("2022/06/05 09:38:00", "%Y/%m/%d %H:%i:%s")),
(102,100482,STR_TO_DATE("2022/06/05 15:10:00", "%Y/%m/%d %H:%i:%s"),
STR_TO_DATE("2022/06/05 15:46:00", "%Y/%m/%d %H:%i:%s")),
(101,100362,STR_TO_DATE("2022/06/07 15:33:00", "%Y/%m/%d %H:%i:%s"),
STR_TO_DATE("2022/06/07 16:45:00", "%Y/%m/%d %H:%i:%s")),
(102,100657,STR_TO_DATE("2022/07/07 15:52:00", "%Y/%m/%d %H:%i:%s"),
null),
(103,100213,STR_TO_DATE("2022/06/12 14:13:00", "%Y/%m/%d %H:%i:%s"),
STR_TO_DATE("2022/06/12 14:10:00", "%Y/%m/%d %H:%i:%s"));

create table customers(cust_id int,signup_timestamp timestamp);
insert into customers values(8472,STR_TO_DATE("2022/05/30 00:00:00", "%Y/%m/%d %H:%i:%s")),
(2341,STR_TO_DATE("2022/06/01 00:00:00", "%Y/%m/%d %H:%i:%s")),
(1314,STR_TO_DATE("2022/06/03 00:00:00", "%Y/%m/%d %H:%i:%s")),
(1435,STR_TO_DATE("2022/06/05 00:00:00", "%Y/%m/%d %H:%i:%s")),
(5421,STR_TO_DATE("2022/06/07 00:00:00", "%Y/%m/%d %H:%i:%s"));

with cte as(
          select o.order_id,o.trip_id,o.status
          from customers c join orders o
          on c.cust_id =o.cust_id where extract(month from c.signup_timestamp) = 6
          and extract(year from c.signup_timestamp) = 2022)
          
select round(100.0*count(summary.order_id)/
        (select count(order_id) from cte),2) as bad_experience_pct
from cte as summary
join trips t on summary.trip_id = t.trip_id
       where summary.status not in ('completed successfully') or 
       t.actual_delivery is null and
       t.estimated_delivery > t.actual_delivery;
          
create table numbers(num int primary key,
frequency int);

insert into numbers values(0,7),(1,1),(2,3),(3,1);
select * from numbers;

create table Salary(id int primary key,emp_id int,
amount int,pay_date date);

create table employee(emp_id1 int primary key,dep_id int);

insert into Salary values(1,1,9000,'2017-03-31'),(2,2,6000,'2017-03-31'),
(3,3,10000,'2017-03-31'),(4,1,7000,'2017-02-28'),(5,2,6000,'2017-02-28'),
(6,3,8000,'2017-02-28');

insert into employee values(1,1),(2,2),(3,2);

select pay_month,dep_id, 
(case when dept_avg > comp_avg then 'higher' when dept_avg < comp_avg then 'lower'
else 'same'
end) as comparison
from (
       select  date_format(b.pay_date, '%Y-%m') pay_month,
       a.dep_id, avg(b.amount) dept_avg,  d.comp_avg
	   from employee a inner join salary b
	   on (a.emp_id1 = b.emp_id) 
	   inner join (select date_format(c.pay_date, '%Y-%m') pay_month, avg(c.amount) comp_avg 
	   from salary c group by date_format(c.pay_date, '%Y-%m')) d 
	   on ( date_format(b.pay_date, '%Y-%m') = d.pay_month)
group by date_format(b.pay_date, '%Y-%m'), dep_id, d.comp_avg) final;

select * from activity;

select a.event_date as install_dt, count(a.player_id) as installs,
round(count(b.player_id)/count(a.player_id), 2) as Day1_retention
from (select player_id, MIN(event_date) as event_date from activity
      group by player_id) a
left join activity b on a.player_id = b.player_id and a.event_date + 1=b.event_date
group by a.event_date;

create table student(student_id int primary key, student_name varchar(15));
create table exams(exam_id int, student_id int,score int,
primary key(exam_id,student_id));
insert into student values(1,'Daniel'),(2,'Jade'),(3,'Stella'),
(4,'Jonathan'),(5,'Will');
insert into exams value(10,1,70),(10,2,80),(10,3,90),(20,1,80),
(30,1,70),(30,3,80),(30,4,90),(40,1,60),(40,2,70),(40,4,80);


select s.student_id, s.student_name from student s inner join 
            (select a.student_id,count(a.exam_id) as total_exam, 
                    sum(case when a.score > min_score and a.score < max_score then 1 
					else 0 end)as quite_exam 
             from   exams a 
	 		 inner join (select exam_id, min(score) as min_score,max(score) as max_score
             from   exams group  by exam_id order  by null) b 
 on a.exam_id = b.exam_id 
 group by a.student_id 
order  by null) c 
on s.student_id = c.student_id 
where  c.total_exam = c.quite_exam 
order  by s.student_id;