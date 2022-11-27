Create database assignment;
use assignment;
create table city(
ID int(10),
Name varchar(17),
CountryCode varchar(3),
District varchar(20),
population bigint); 

insert into city values
(6,'Rotterdam','NLD','Zuid-Holland',593321),
(3878,'Scottsdale','USA','Arizona',202705),
(3965,'Corona','USA','california',124966),
(3973,'Concord','USA','california',121780),
(3977,'Cedar Rapids','USA','Lowa',120758),
(3982,'Coral Springs','USA','Florida',117549),
(4054,'Farfield','USA','California',92256),
(4058,'Boulder','USA','Colorado',91238),
(4061,'Fall River','USA','Massachusett',90555);

select * from city where CountryCode='USA' and population>100000;
select name from city where CountryCode='USA' and population>120000;
select * from city;
select * from city where ID=1661;
select * from city where CountryCode='JPN';
select name from city where CountryCode='JPN';

create table station(
ID int(10),
city varchar(17),
State varchar(3),
Lat_N int(10),
Long_W int(10));

insert into station values(794,'Kissee Mills','MO',139,73),(824,'Loma Mar','CA',48,130),
(603,'Sandy Hook','CT',72,148),(478,'Tipton','IN',33,97) ,
(619,'Arlington','CO',75,92), (711,'Turner','AR',50,101), 
(839,'Slidell','LA',85,151), (411,'Negreet','LA',98,105), 
(588,'Glencoe','KY',46,136), (665,'Chelsea','IA',98,59), 
(342,'Chignik Lagoon','AK',103,153),(733,'Pelahatchie','MS',38,28), 
(441,'Hanna City','IL',50,136), (811,'Dorrance','KS',102,121), 
(698,'Albany','CA',49,80), (325,'Monument','KS',70,141), 
(414,'Manchester','MD',73,37), (113,'Prescott','IA',39,65), 
(971,'Graettinger','IA',94,150), (266,'Cahone','CO',116,127);

select * from station;
select city from station;
select distinct(city) from station where MOD(ID,2)=0 
order by city;
select (count(*) - count(distinct city)) as Difference
from station;

(select CITY,LENGTH(CITY) as Min from STATION order by Length(CITY) asc, CITY limit 1) union
(select CITY,LENGTH(CITY) as Max from STATION order by Length(CITY) desc, CITY limit 1);

select Distinct(city) from station
where city like 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%'
OR CITY LIKE 'o%' OR CITY LIKE 'u%';

Select Distinct(city) from station
where city like '%a' OR CITY LIKE '%e' OR CITY LIKE '%i'
OR CITY LIKE '%o' OR CITY LIKE '%u';

Select Distinct(city) from station
where city not like 'a%' and CITY not LIKE 'e%' and CITY not LIKE 'i%'
and CITY not LIKE 'o%' and CITY not LIKE 'u%';

SELECT DISTINCT CITY FROM STATION WHERE 
LOWER(SUBSTR(CITY,1,1)) NOT IN ('a','e','i','o','u') or
LOWER(SUBSTR(CITY, LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');   

create table Product(
product_id int(5) not null primary key,
product_name varchar(10),
unit_price int(10));

create table sales(
seller_id int(5),
product_id1 int(5),
buyer_id int(5),
sales_date date,
quantity int(5),
price int(5),
foreign key(product_id1) references Product(product_id));

insert into product values(1,'S8',1000),
(2,'G4',800),
(3,'Iphone',1400);

select * from product;

insert into sales values(1,1,1,'2019-01-21',2,2000),
(1,2,2,'2019-02-17',1,800),
(2,2,3,'2019-06-02',1,800),
(3,3,4,'2019-05-13',2,2800); 

select * from sales;
select distinct product_id,product_name from product
where product_id in (select product_id1 from sales
where sales_date between '2019-01-01' AND '2019-03-31');

create table views(
article_id int(5),
author_id int(5),
viewer_id int(5),
view_date date);

insert into views values(1,3,5,'2019-08-01'),
(1,3,6,'2019-08-02'),
(2,7,7,'2019-08-01'),
(2,7,6,'2019-08-02'),
(4,7,1,'2019-07-22'),
(3,4,4,'2019-07-21'),
(3,4,4,'2019-07-21');

select distinct(author_id) as id from views
where author_id in (select viewer_id from views
where author_id=viewer_id)
order by author_id;

create table delivery(
delivery_id int(5) primary key,
customer_id int(5),
order_date date,
customer_pref_delivery_date date);

insert into delivery values(1,1,'2019-08-01','2019-08-02'),
(2,5,'2019-08-02','2019-08-02'),
(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-26'),
(5,4,'2019-08-21','2019-08-22'),
(6,2,'2019-08-11','2019-08-13');

with cte as (select * from
(select delivery_id,customer_id,order_date,customer_pref_delivery_date,
(Case when order_date=customer_pref_delivery_date then 1 else 0 end) as immediate,
RANK() OVER(PARTITION BY customer_id ORDER BY order_date) as first_order
from delivery)x)
SELECT
ROUND(SUM(immediate) *100 / COUNT(first_order),2) as immediate_percentage
FROM cte;

create table ads(
ad_id int,
user_id int,
act_ion varchar(15),
primary key(ad_id,user_id));

insert into ads values(1,1,'clicked'),
(2,2,'clicked'),
(3,3,'viewed'),
(5,5,'Ignored'),
(1,7,'Ignored'),
(2,7,'viewed'),
(3,5,'clicked'),
(1,4,'viewed'),
(2,11,'viewed'),
(1,2,'clicked');


select distinct ad_id, ifnull(
round(sum(act_ion = 'Clicked') / (sum(act_ion = 'Clicked') + sum(act_ion = 'Viewed')) * 100, 2),0)
as ctr
from ads
group by ad_id
order by ctr desc, ad_id;

show tables;
create table employee(
emp_id int(5) primary key,
team_id int(5));

insert into employee values(1,8),
(2,8),(3,8),(4,7),(5,9),(6,9);

select emp_id,
count(team_id) over (partition by team_id) as team_size
from employee
order by emp_id;
drop table country;

Create table countries(
country_id int primary key,
country_name varchar(10));

create table weather(
country_id int,
weather_state int,
day date,
primary key(country_id,day));

insert into countries values(2,'USA'),
(3,'Australia'),(7,'Peru'),(5,'China'),(8,'Morocco'),(9,'Spain');

insert into weather values(2,15,'2019-11-01'),
(2,12,'2019-10-28'),(2,12,'2019-10-27'),(3,-2,'2019-11-10'),(3,0,'2019-11-11'),
(3,3,'2019-11-12'),(5,16,'2019-11-07'),(5,18,'2019-11-09'),(5,21,'2019-11-23'),
(7,25,'2019-11-28'),(7,22,'2019-12-01'),(7,20,'2019-12-02'),(8,25,'2019-11-05'),
(8,27,'2019-11-15'),(8,31,'2019-11-25'),(9,7,'2019-11-23'),(9,3,'2019-12-23');

select country_name,
(case when avg(weather_state)<=15 then 'cold'
      when avg(weather_state)>=25 then 'hot'
      else 'warm'
end) as 'weather_type'
from countries c inner join weather w
on c.country_id = w.country_id
where month(w.day) = 11
group by c.country_id;

create table Prices(
product_id int,
start_date date,
end_date date,
price int,
primary key(product_id,start_date,end_date));

create table UnitsSold(
product_id int,
purchase_date date,
units int);

insert into Prices values(1,'2019-02-17','2019-02-28',5),
(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),
(2,'2019-02-21','2019-03-31',30);

insert into UnitsSold values(1,'2019-02-25',100),
(1,'2019-03-01',15),(2,'2019-02-10',200),(2,'2019-03-22',30);

drop table UnitsSold;

select u.product_id,
round(sum(p.price * u.units)/sum(u.units),2) as average_price
from prices p inner join UnitsSold u
on p.product_id = u.product_id
and (u.purchase_date between p.start_date And p.end_date) 
group by u.product_id;

create table Activity(
player_id int,
device_id int,
event_date date,
games_played int,
primary key(player_id,event_date));

insert into Activity values(1,2,'2016-03-01',5),
(1,2,'2016-05-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);

select distinct(player_id),
FIRST_VALUE(device_id) OVER (PARTITION BY player_id ORDER BY event_date ASC) AS device_id
from activity;
drop table Products;
create table products(
product_id int primary key,product_name varchar(30),
product_category varchar(20));

create table Orders(
product_id1 int,order_date date,
unit int,foreign key(product_id1) references products(product_id));

insert into products values(1,'Leetcode Solutions','Book'),(2,'Jewels of Stringology','Book'),
(3,'HP','Laptop'),(4,'Lenovo','Laptop'),(5,'Leetcode Kit','Tshirt');

insert into Orders values(1,'2020-02-05',60),
(1,'2020-02-10', 70), (2, '2020-01-18', 30), (2, '2020-02-11', 80), (3, '2020-02-17', 2), 
(3, '2020-02-24',3), (4, '2020-03-01', 20),(4, '2020-03-04', 30),(4, '2020-03-04', 60),
(5, '2020-02-25', 50),(5, '2020-02-27', 50), (5, '2020-03-01',50); 

Select p.product_name, sum(o.unit) as unit from products p
left join orders o 
on p.product_id = o.product_id1
where o.order_date Between '2020-02-01' And '2020-02-29'
group by p.product_name
having sum(o.unit)>=100;

create table Users(
user_id int primary key,
name varchar(30),
mail varchar(50));

insert into Users values(1,'Winston','winston@leetcode.com'),
(2,'Jonathan','jonathanisgreat'),
(3,'Annabelle','bella-@leetcode.com'),
(4,'Sally','sally.com@leetcode.com'),
(5,'Marwan','quartz#2020@leetcode.com'),
(6,'David','david69@gmail.com'),
(7,'Shapiro','.shapo@leetcode.com');

SELECT *
FROM Users
WHERE REGEXP_LIKE(mail, '^[a-zA-Z][a-zA-Z0-9\_\.\-]*@leetcode.com');

create table customers(
customer_id int primary key,name varchar(20),country varchar(20));

create table produkt(product_id int primary key,description varchar(20),
price int);

create table Orders(order_id int primary key,customer_id int,product_id int,
order_date date,quantity int);

insert into customers values(1,'Winston','USA'),(2,'Jonathan','Peru'),(3,'Mousafa','Egypt');

insert into produkt values(10,'LC Phone',300),(20,'LC Tshirt',10),(30,'LC Book',45),(40,'LC Keychain',2);

insert into Orders values(1,1,10,'2020-06-10',1),(2,1,20,'2020-07-01',1),
(3,1,30,'2020-07-08',2),(4,2,10,'2020-06-15',2),(5,2,40,'2020-07-01',10),
(6,3,20,'2020-06-24',2),(7,3,30,'2020-06-25',2),(9,3,30,'2020-05-08',3);

select o.customer_id, c.name
from Customers c, Produkt p, Orders o
where c.customer_id = o.customer_id and p.product_id = o.product_id
group by o.customer_id
having (
    sum(case when o.order_date like '2020-06%' then o.quantity*p.price else 0 end) >= 100
    and
    sum(case when o.order_date like '2020-07%' then o.quantity*p.price else 0 end) >= 100);
    
create table TVprogram(program_date date,
content_id int,channel varchar(15),primary key(program_date,content_id));

create table Content(content_id varchar(20) primary key,
title varchar(20),kids_content varchar(15),content_type varchar(15));

insert into Tvprogram values('2020-06-10 08:00',1,'LC Channel'),
('2020-05-11 12:00',2,'LC Channel'),('2020-05-12 12:00',3,'LC Channel'),
('2020-05-13 14:00',4,'Disney Ch'),('2020-06-18 14:00',4,'Disney Ch'),
('2020-07-15 16:00',5,'Disney Ch');

insert into content values(1,'Leetcode Movie','N','Movies'),
(2,'Alg. for kids','Y','Series'),(3,'Database Sols','N','Series'),
(4,'Alladin','Y','Movies'),(5,'Cindrella','Y','Movies');

select distinct(title) from content c
join Tvprogram t on c.content_id=t.content_id
where c.kids_content = 'Y' and c.content_type = 'Movies'
and (month(program_date), year(program_date)) = (6, 2020); 

Create table NPV(
id int,year int,npv int,primary key(id,year));

create table Queries(
id int,year int, primary key(id,year));

insert into NPV values(1,2018,100),
(7,2020,30),(13,2019,40),(1,2019,113),(2,2008,121),
(3,2009,12),(11,2020,99),(7,2019,0);

insert into Queries values(1,2019),(2,2008),(3,2009),(7,2018),
(7,2019),(7,2020),(13,2019);

select q.id,q.year,n.npv from queries q left join NPV n
on q.id = n.id and n.year = q.year;

create table employees(
id int primary key, name varchar(20));

create table employeesUNI(
id int,unique_id int,primary key(id,unique_id));

insert into employees values(1,'Alice'),(7,'Bob'),(11,'Meir'),
(90,'Winston'),(3,'Jonathan');

insert into employeesUNI values(3,1),(11,2),(90,3);

SELECT b.unique_id, a.name
FROM employees a
LEFT JOIN employeesUNI b on a.id = b.id;

create table users(id int primary key,name varchar(15));

create table Rides(
id int primary key,
user_id int,distance int);

insert into Users values(1,'Alice'),(2,'Bob'),
(3,'Alex'),(4,'Donald'),(7,'lee'),(13,'Jonathan'),(19,'Elvis');

insert into Rides values(1,1,120),(2,2,317),(3,3,222),
(4,7,100),(5,13,312),(6,19,50),(7,7,120),(8,19,400),(9,7,230);

select u.name,sum(ifnull(r.distance,0)) as travelled_distance 
from users u
left join rides r
on u.id = r.user_id
group by u.name
order by travelled_distance desc,u.name asc;

create table movies(movie_id int primary key,title varchar(15));

create table users(user_id int primary key,name varchar(15));

create table movierating(movie_id int,user_id int,
rating int,created_at date,
primary key(movie_id,user_id));

insert into movies values(1,'Avengers'),(2,'Frozen 2'),(3,'Joker');

insert into users values(1,'Daniel'),(2,'Monica'),(3,'Maria'),(4,'James');

insert into movierating values(1,1,3,'2020-01-12'),
(1,2,4,'2020-02-11'),(1,3,2,'2020-02-12'),(1,4,1,'2020-01-01'),
(2,1,5,'2020-02-17'),(2,2,2,'2020-02-01'),(2,3,2,'2020-03-01'),
(3,1,3,'2020-02-22'),(3,2,4,'2020-02-25');

(select b.name as results from users b
join movierating c on b.user_id=c.user_id
group by b.user_id
order by count(*) desc,b.name asc limit 1)
union
(select a.title as results from movies a
join movierating c on a.movie_id=c.movie_id
where (month(c.created_at), year(c.created_at)) = (2, 2020)
group by c.movie_id
order by avg(c.rating) desc,a.title asc limit 1);

create table department(id int primary key,name varchar(25));

create table student(id int primary key,name varchar(15),dep_id int);
insert into department values(1,'Electrical engineering'),
(7,'Computer engineering'),(13,'Business Administration');

insert into student values(23,'Alice',1),(1,'Bob',7),
(5,'Jennifer',13),(2,'John',14),(4,'Jasmine',77),(3,'Steve',74),
(6,'Luis',1),(8,'Jonathan',7),(7,'Dianna',33),(11,'Madelynn',1);

select s.id,s.name from student s
left join department d on d.id = s.dep_id
where d.id is null;

create table calls(from_id int,
to_id int,duration int);

insert into calls values (1,2,59), (2,1,11),
(1,3,20), (3,4,100),(3,4,200),(3,4,200),(4,3,499);
 
select from_id as person1,to_id as person2,  
count(duration) as call_count,sum(duration) as total_duration
from (select * from Calls 
      union all
      select to_id, from_id, duration 
      from Calls) as a
where from_id < to_id     
group by person1,person2;

create table warehouse(
name varchar(15),product_id int,units int,
primary key(name,product_id));

create table products(
product_id int primary key,product_name varchar(15),
width int,length int,height int);

insert into warehouse values('LCHouse1',1,1),
('LCHouse1',2,10),('LCHouse1',3,5),('LCHouse2',1,2),
('LCHouse2',2,2),('LCHouse2',4,1);

insert into products values(1,'LC-Tv',5,50,40),(2,'LC-Keychain',5,5,5),
(3,'LC-Phone',2,10,10),(4,'LC-Tshirt',4,10,20);

select name as warehouse_name, sum(units * vol) as volume
from Warehouse w
join (select product_id, Width*Length*Height as vol
     from Products) p
on w.product_id = p.product_id
group by name;

SELECT name AS warehouse_name,
       SUM(units*Width*LENGTH*Height) AS volume
FROM Warehouse w
INNER JOIN Products p ON w.product_id = p.product_id
GROUP BY name
ORDER BY NULL;

create table sales(
sale_date date,
fruit varchar(10),sold_num int,
primary key(sale_date,fruit));

insert into sales values('2020-05-01','apples',10),
('2020-05-01','oranges',8),('2020-05-02','apples',15),
('2020-05-02','oranges',15),('2020-05-03','apples',20),
('2020-05-03','oranges',0),('2020-05-04','apples',15),
('2020-05-04','oranges',16);

select sale_date, 
SUM(case when fruit='apples' then sold_num
else -sold_num
end) as diff
from sales
group by sale_date order by sale_date;

create table activity(
player_id int,device_id int,event_date date,
games_played int,primary key(player_id,event_date));

insert into activity values(1,2,'2016-03-01',5),
(1,2,'2016-03-02',6),(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

with activity_stats as (
   select player_id, event_date, 
   datediff(event_date,min(event_date) over(partition by player_id)) as date_diff
   from activity)
select round(count(distinct player_id) / (select count(distinct player_id)
 from activity), 2) as fraction 
from activity_stats 
where date_diff = 1;

create table employee(
id int primary key,
name varchar(15),department varchar(15),managerid int);

insert into employee values(101,'John','A',Null),(102,'Dan','A',101),
(103,'James','A',101),(104,'Amy','A',101),
(105,'Anne','A',101),(106,'Ron','B',101);

select name from employee 
where id in 
       (select managerid from employee 
        group by managerid
        having count(managerid)>=5);

create table student(
student_id int primary key,
student_name varchar(15),gender varchar(15),depid int,
foreign key(depid) references department(dep_id));

create table department(
dep_id int primary key,
dep_name varchar(15));

insert into student values(1,'Jack','M',1),(2,'Jane','F',1),
(3,'Mark','M',2);

insert into department values(1,'Engineering'),(2,'Science'),(3,'Law');

select d.dep_name,count(student_id) as student_number
from department d left join student s
on d.dep_id = s.depid
group by d.dep_id
order by student_number desc,d.dep_name asc;

create table Product1(product_key int primary key);

create table Customer1(customer_id int ,
product_key1 int,
foreign key(product_key1) references Product1(product_key));

insert into Product1 values(5),(6);
insert into Customer1 values(1,5),(2,6),(3,5),(3,6),(1,6);

select c.customer_id from customer1 c
group by customer_id
having count(distinct(product_key1)) in
           (select count(product_key) from product1);
         
create table employee1(employee_id int primary key,name varchar(15),
experience_years int);

create table project(project_id int,employee_id1 int,
primary key(project_id,employee_id1),
foreign key(employee_id1) references employee1(employee_id));

insert into employee1 values(1,'Khaled',3),
(2,'Ali',2),(3,'John',3),(4,'Doe',2);

insert into project values(1,1),(1,2),(1,3),(2,1),(2,4);
								
 Select project_id,employee_id1 FROM (
		SELECT p.project_id, p.employee_id1,
		DENSE_RANK() OVER(PARTITION BY p.project_id ORDER BY e.experience_years DESC) as rnk
        FROM project p JOIN employee1 as e
        ON p.employee_id1 = e.employee_id
		) as a
WHERE rnk = 1;         

create table books(
book_id int primary key,name varchar(25),
ava_from date); 

create table Orders(
order_id int primary key,book_id1 int,
quantity int,dispatch_date date,
foreign key(book_id1) references books(book_id));   

insert into books values(1,'Kaila & Demna','2010-01-01'),      
(2,'28 letters','2012-05-12'),(3,'The Hobbit','2019-06-10'),
(4,'13 reasons why','2019-06-01'),(5,'The Hunger Games','2008-09-21');    

insert into books values(1,'Kaila & Demna','2010-01-01'),      
(2,'28 letters','2012-05-12'),(3,'The Hobbit','2019-06-10'),
(4,'13 reasons why','2019-06-01'),(5,'The Hunger Games','2008-09-21');  



create table enrollments (student_id int, course_id int,
grade int,
primary key(student_id,course_id));         

insert into enrollments values(2,2,95), 
(2,3,95),(1,1,90),(1,2,99),(3,1,80),(3,2,75),
(3,3,82);        

select student_id, min(course_id) as course_id, grade
from Enrollments
where (student_id, grade) in 
    (select student_id, max(grade)
    from Enrollments
    group by student_id)
group by student_id
order by student_id asc;

create table players(player_id int primary key,
group_id int);

create table matches(match_id int primary key,
first_player int,second_player int,first_score int,second_score int);

insert into players values(15,1),(25,1),(30,1),
(45,1),(10,2),(35,2),(50,2),(20,3),(40,3);

insert into matches values(1,15,45,3,0),
(2,30,25,1,2),(3,30,15,2,0),(4,40,20,5,2),
(5,35,50,1,1);

select group_id, player_id from
   (select p.group_id, ps.player_id, 
               sum(ps.score) as score 
			    from   players p inner join
                  (select first_player as player_id, first_score  as score from  matches 
				union all 
                    select second_player as player_id,second_score  as score
                    from   matches) ps 
        on  p.player_id = ps.player_id 
        group  by ps.player_id 
        order  by group_id, score desc, player_id) top_scores 
group  by group_id;