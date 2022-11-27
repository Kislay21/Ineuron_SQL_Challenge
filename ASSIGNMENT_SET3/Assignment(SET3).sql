create database assignment3;
use assignment3;
#101
create table useractivity(username varchar(15),activity varchar(15),
start_date date,end_date date);
insert into useractivity values('Alice','Travel','2020-02-12','2020-02-20'),
('Alice','Dancing','2020-02-21','2020-02-23'),('Alice','Travel','2020-02-24','2020-02-28'),
('Bob','Travel','2020-02-11','2020-02-18');

select username,activity,start_date,end_date from 
                (select *,
                rank() over(partition by username order by start_date desc) as 'rnk',
				count(activity) over(partition by username) as 'count'
                from useractivity) as u
where (count <> 1 and rnk = 2) or (count = 1 and rnk = 1);

#103
create table students(id int,name varchar(15),marks int);
insert into students values(1,'Ashley',81),(2,'Samantha',75),(4,'Julia',76),
(3,'Belvet',84);
select * from students;
select name from students 
where marks>75
order by SUBSTR(name, -3), id asc;

#107
create table employees(id int,name varchar(15),salary int);
insert into employees values(1,'Kristten',1420),(2,'Ashley',2006),
(3,'Julia',2210),(4,'Maria',3000);

select ceil(avg(salary)-avg(replace(salary,'0','')))
from  employees;

#108
create table employee(emp_id int,name varchar(15),months int,
salary int);
insert into employee values(12228,'Rose',15,1968),(33645,'Angela',1,3443),
(45692,'Frank',17,1608),(56118,'Patrrick',7,1345),(59725,'Lisa',11,2330),
(74197,'Kimberly',16,4372),(78454,'Bonnie',8,1771),(83565,'Michael',6,2017),
(98607,'Todd',5,3396),(99989,'Joe',9,3573);
select * from employee;
select months*salary as 'earnings' , count(*) from employee
group by earnings
order by earnings desc
limit 1;

#109
create table occupations(name varchar(15),occupation varchar(15));
insert into occupations value('Samantha','Doctor'),('Julia','Actor'),
('Maria','Actor'),('Meera','Singer'),('Ashley','Professor'),('Ketty','Proffesor'),
('Christeen','Proffesor'),('Jane','Actor'),('Jenny','Doctor'),('Priya','Singer');
select * from occupations;
select concat(name,'(',left(occupation, 1),')') as sample_output
from occupations 
order by name;

#110
select Doctor,Professor,Singer,Actor
from (select NameOrder,
        max(case Occupation when 'Doctor' then Name end) as Doctor,
        max(case Occupation when 'Professor' then Name end) as Professor,
        max(case Occupation when 'Singer' then Name end) as Singer,
        max(case Occupation when 'Actor' then Name end) as Actor
    from (select Occupation,Name,
                row_number() over(partition by Occupation order by Name ASC) as NameOrder
				from Occupations
         )as NameLists group by NameOrder
    ) as Names;

#111
create table BST (N int, P int);
insert into BST values(1,2),(3,2),(6,8),(9,8),(2,5),
(8,5),(5,null);
select * from BST;
select N,
     (case when N not in (select distinct P from BST where P is not null) then 'Leaf'
            when P is null then 'Root'
            else 'Inner'
		end ) as 'sample_output'
from BST;

#114
set @number = 0;
select repeat('* ', @number := @number + 1) 
from information_schema.tables
where @number < 20;

#115
set @i = 21;
select repeat('* ', @i := @i-1)
from information_schema.tables;

#116
create table sample(x int,y int);
insert into sample values(20,20),(20,20),(20,21),(23,22),(22,23),(21,20);
select * from sample;

select f1.x,f1.y
from sample f1, sample f2
where f1.x=f2.y and f1.y=f2.x
group by f1.x,f1.y
having count(f1.x)>1 or f1.x<f1.y
order by f1.x;

#112
create table Company(company_code varchar(15),founder varchar(15));
insert into company values('C1','Monika'),('C2','Samantha');

create table lead_manager(lead_manager_code varchar(15),company_code varchar(15));
insert into lead_manager values('LM1','C1'),('LM2','C2');

create table senior_manager(senior_manager_code varchar(15),lead_manager_code varchar(15),
company_code varchar(15));
insert into senior_manager values('SM1','LM1','Ç1'),('SM2','LM1','C1'),('SM3','LM2','C2');

create table manager(manager_code varchar(15),senior_manager_code varchar(15),
lead_manager_code varchar(15),company_code varchar(15));
insert into manager values('M1','SM1','LM1','Ç1'),('M2','SM3','LM2','Ç2'),
('M3','SM3','LM2','Ç2');

create table employee(employee_code varchar(15),manager_code varchar(15),
senior_manager_code varchar(15),lead_manager_code varchar(15),
company_code varchar(15));

insert into employee values('E1','M1','SM1','LM1','C1'),('E2','M1','SM1','LM1','C1'),
('E3','M2','SM3','LM2','C2'),('E4','M3','SM3','LM2','C2');

select c.company_code, c.founder,
       count(distinct l.lead_manager_code),
       count(distinct s.senior_manager_code),
       count(distinct m.manager_code),
       count(distinct e.employee_code)
from Company as c 
join Lead_Manager as l 
on c.company_code = l.company_code
join Senior_Manager as s
on l.lead_manager_code = s.lead_manager_code
join Manager as m 
on m.senior_manager_code = s.senior_manager_code
join Employee as e
on e.manager_code = m.manager_code
group by c.company_code, c.founder
order by c.company_code;

##150
create table students(id int, name varchar(15));
create table friends(id int,friend_id int);
create table packages(id int,salary float);
insert into students values(1,'Ashley'),(2,'Samantha'),(3,'Julia')
,(4,'Scarlet');
insert into friends values(1,2),(2,3),(3,4),(4,1);
insert into packages values(1,15.20),(2,10.06),(3,11.55),(4,12.12);

select S1.Name from Students s1 
inner join Packages p1 on s1.Id = p1.Id
inner join Friends f on s1.id = f.Id
inner join Students s2 on f.Friend_Id = s2.Id
inner join Packages p2 on s2.id = p2.Id
where p1.Salary < p2.Salary
order by p2.Salary ;

#151
create table hackers(hacker_id int,name varchar(15));
create table difficulty(difficulty_level int,score int);
create table challenges(challenge_id int,hacker_id int,difficulty_level int);
create table submissions(submission_id int,hacker_id int,challenge_id int,score int);

insert into hackers values(5580,'Rose'),(8439,'Angela'),(27205,'Frank'),
(52249,'Patrick'),(52348,'Lisa'),(57645,'Kimberly'),(77726,'Bonnie'),
(83082,'Michael'),(86870,'Todd'),(90411,'Joe');

insert into difficulty values(1,20),(2,30),(3,40),(4,60),(5,80),(6,100),(7,120);

insert into challenges values(4810,77726,4),(21069,27205,1),(36566,5580,7),
(66730,52243,6),(71055,52243,2);

insert into submissions values(68628,77726,36566,30),(65300,77726,21089,10),
(40326,52243,36566,77),(8941,27205,4810,4),(83544,77726,66730,30),(43353,52243,66730,0),
(55385,52348,71055,20),(39784,27205,71055,23),(94613,86870,71055,30),(45788,52348,36566,0),
(93058,86870,36566,30),(7344,8439,66730,92),(2721,8439,4810,36),(523,5580,71055,4),
(49105,52348,66730,0),(55877,57645,66730,80),(38355,27205,66730,35),(3924,8439,36566,80),
(97397,90411,66730,100),(84162,83082,4810,40),(97431,90411,71055,30);

select s.hacker_id, name from submissions as s
join hackers as h on s.hacker_id = h.hacker_id
join challenges as c on s.challenge_id = c.challenge_id
join difficulty as d on c.difficulty_level = d.difficulty_level
where s.score = d.score
group by name, s.hacker_id
having count(s.challenge_id) > 1
order by count(s.challenge_id) desc, s.hacker_id;

#152
create table projects(task_id int,start_date date,end_date date);
insert into projects value(1,'2015-10-01','2015-10-02'),(2,'2015-10-02','2015-10-03'),
(3,'2015-10-03','2015-10-04'),(4,'2015-10-13','2015-10-14'),(5,'2015-10-14','2015-10-15'),
(6,'2015-10-28','2015-10-29'),(7,'2015-10-30','2015-10-31');

select * from projects;
select start_date, min(end_date)
from 
   (select start_date from projects where start_date not in (select end_date from projects))a,
   (select end_date from projects where end_date not in (select start_date from projects))b
where start_date < end_date
group by start_date
order by datediff(min(end_date), start_date) asc, start_date asc;

#153
create table trans(user_id int,amount int,transaction_date timestamp);
insert into trans values(1,9.99,STR_TO_DATE("2022/08/01 10:00:00", "%Y/%m/%d %H:%i:%s")),
(1,55,STR_TO_DATE("2022/08/17 10:00:00", "%Y/%m/%d %H:%i:%s")),
(2,149.5,STR_TO_DATE("2022/08/05 10:00:00", "%Y/%m/%d %H:%i:%s")),
(2,4.89,STR_TO_DATE("2022/08/06 10:00:00", "%Y/%m/%d %H:%i:%s")),
(2,34,STR_TO_DATE("2022/08/07 10:00:00", "%Y/%m/%d %H:%i:%s"));
select * from trans;
with cte as (
            select *, lead(date_diff,1) over(partition by user_id order by transaction_date
            ) - lead(date_diff,0) over(partition by user_id order by transaction_date)as'diff'
		from (
             select *,datediff(lead(transaction_date,1) over(partition by user_id order by
             transaction_date), lead(transaction_date,0) over(partition by user_id order by
             transaction_date)) as 'date_diff'
		from trans) sub),
cte2 as (select user_id,date_diff,diff,
		count(date_diff),count(diff) from cte
        group by user_id,date_diff,diff
        having count(date_diff) >= 2
        and date_diff=1 or diff=0)
select user_id from cte2;
			
#154
create table payments(player_id int,recipient_id int,amount int);
insert into payments value(101,201,30),(201,101,10),(101,301,20),(301,101,80),
(201,301,70);
select * from payments;
with cte as 
  (select player_id,recipient_id
  from payments
  INTERSECT
  Select recipient_id,player_id
  from payments)

select count(player_id)/2 as unique_relationships
from cte;

#155
create table user_logins(user_id int,login_date datetime);
insert into user_logins value(725,STR_TO_DATE("2022/03/03 12:00:00", "%Y/%m/%d %H:%i:%s")),
(245,STR_TO_DATE("2022/03/28 12:00:00", "%Y/%m/%d %H:%i:%s")),
(112,STR_TO_DATE("2022/03/05 12:00:00", "%Y/%m/%d %H:%i:%s")),
(245,STR_TO_DATE("2022/04/29 12:00:00", "%Y/%m/%d %H:%i:%s")),
(112,STR_TO_DATE("2022/04/05 12:00:00", "%Y/%m/%d %H:%i:%s"));
select * from user_logins;

#156
create table user_trans(trans_id int,user_id int,spend decimal,
trans_date timestamp);
insert into user_trans values
(759274,111,49.50,STR_TO_DATE("2022/02/03 00:00:00", "%Y/%m/%d %H:%i:%s")),
(850371,111,51.00,STR_TO_DATE("2022/03/15 00:00:00", "%Y/%m/%d %H:%i:%s")),
(615348,145,36.30,STR_TO_DATE("2022/03/22 00:00:00", "%Y/%m/%d %H:%i:%s")),
(137424,156,151.00,STR_TO_DATE("2022/04/04 00:00:00", "%Y/%m/%d %H:%i:%s")),
(248475,156,87.00,STR_TO_DATE("2022/04/16 00:00:00", "%Y/%m/%d %H:%i:%s"));
select * from user_trans;
with cte as (
select *, row_number() over(partition by user_id order by trans_date) as rn 
from user_trans
order by user_id, trans_date )
select count(user_id) as users from cte where rn=1 and spend>=50;

#157
create table measuremet(m_id int,m_value float,m_time datetime);
insert into measuremet values
(131233,1109.51,STR_TO_DATE("2022/07/10 09:00:00", "%Y/%m/%d %H:%i:%s")),
(135211,1662.74,STR_TO_DATE("2022/07/10 11:00:00", "%Y/%m/%d %H:%i:%s")),
(523542,1246.24,STR_TO_DATE("2022/07/10 13:15:00", "%Y/%m/%d %H:%i:%s")),
(143562,1124.50,STR_TO_DATE("2022/07/11 15:00:00", "%Y/%m/%d %H:%i:%s")),
(346462,1234.14,STR_TO_DATE("2022/07/11 16:45:00", "%Y/%m/%d %H:%i:%s"));

select * from measuremet;
with m as
 (select cast(m_time as date) md, m_value mv,
 row_number() over( partition by cast(m_time as date)
        order by m_time) mn
from measuremet)
select md,
 sum(case when m.mn % 2 = 0 then mv else 0 end) as even_sum,
 sum(case when m.mn % 2 != 0 then mv else 0 end) as odd_sum
from m
group by md;

#158
create table transaction(user_id int,amount int,transaction_date timestamp);
insert into transaction values
(1,9.99,STR_TO_DATE("2022/08/01 10:00:00", "%Y/%m/%d %H:%i:%s")),
(1,55,STR_TO_DATE("2022/08/17 10:00:00", "%Y/%m/%d %H:%i:%s")),
(2,149.5,STR_TO_DATE("2022/08/05 10:00:00", "%Y/%m/%d %H:%i:%s")),
(2,4.89,STR_TO_DATE("2022/08/06 10:00:00", "%Y/%m/%d %H:%i:%s")),
(2,34,STR_TO_DATE("2022/08/07 10:00:00", "%Y/%m/%d %H:%i:%s"));

select * from transaction;
with cte as (
      select *,lead(date_diff, 1) over(partition by user_id
      order by transaction_date) - lead(date_diff, 0) over(
      partition by user_id order by transaction_date) as 'diff'
from( select *, datediff(lead(transaction_date, 1) over(partition by user_id
order by transaction_date),lead(transaction_date, 0) over(partition by user_id
order by transaction_date)) as 'date_diff'
from transaction) sub),

cte2 as (select user_id,date_diff,diff,count(date_diff),count( diff )
from cte group by user_id,date_diff,diff
having count(date_diff) >= 2 and date_diff = 1 or diff = 0)
select user_id from cte2;

#163
create table purchases(user_id int,product_id int,quantity int,purchase_date datetime);
insert into purchases values
(536,3223,6,STR_TO_DATE("2022/01/11 12:33:44", "%Y/%m/%d %H:%i:%s")),
(827,3585,35,STR_TO_DATE("2022/02/20 14:05:26", "%Y/%m/%d %H:%i:%s")),
(536,3223,5,STR_TO_DATE("2022/03/02 09:33:28", "%Y/%m/%d %H:%i:%s")),
(536,1435,10,STR_TO_DATE("2022/03/02 08:40:00", "%Y/%m/%d %H:%i:%s")),
(827,2452,45,STR_TO_DATE("2022/04/09 00:00:00", "%Y/%m/%d %H:%i:%s"));
select * from purchases;
select count(distinct user_id) as repeat_purchases
from (select user_id, rank() over (partition by user_id, product_id
    order by date(purchase_date) asc
 ) as purchase_no 
  from purchases
 ) as ranking where purchase_no = 2;

#164
 create table search_category(country varchar(15),search_cat varchar(15),
 num_search int,invalid_result_pct float);
 
 insert into search_category values('UK','home',null,null),
 ('UK','tax',98000,1.00),('UK','travel',100000,3.25);
 
 select * from search_category;
with invalid_results
as (select country,num_search,invalid_result_pct,
(case when invalid_result_pct is not null then
num_search
else null end) as num_search_2,
round((num_search * invalid_result_pct)/100.0,0) as
invalid_search from search_category
where num_search is not null
and invalid_result_pct is not null
)
Select country,sum(num_search_2) as total_search,
round (sum(invalid_search) /sum(num_search_2) *
100.0,2) as invalid_result_pct
from invalid_results group by country order by country;

#166
create table product_spend(category varchar(35),product varchar(35),
user_id int,spend float,transaction_date timestamp);

insert into product_spend values
('appliance','refrigerator',165,246.00,STR_TO_DATE("2022/12/26 12:00:00", "%Y/%m/%d %H:%i:%s")),
('appliance','refrigerator',123,299.99,STR_TO_DATE("2022/03/02 12:00:00", "%Y/%m/%d %H:%i:%s")),
('appliance','washing machine',123,219.80,STR_TO_DATE("2022/12/26 12:00:00", "%Y/%m/%d %H:%i:%s")),
('electronics','vaccum',178,152.00,STR_TO_DATE("2022/04/05 12:00:00", "%Y/%m/%d %H:%i:%s")),
('electronics','wireless headset',156,249.90,STR_TO_DATE("2022/07/08 12:00:00", "%Y/%m/%d %H:%i:%s")),
('electronics','vaccum',145,189.00,STR_TO_DATE("2022/07/15 12:00:00", "%Y/%m/%d %H:%i:%s"));

select * from product_spend;
select category, product, total_spend from (
    select  *,  rank() over ( partition by category 
        order by total_spend desc) as ranking 
    from ( select  category,   product, sum(spend) as total_spend 
        from product_spend where transaction_date >= '2022-01-01' 
          and transaction_date <= '2022-12-31' 
        group by category, product) as total_spend
  ) as top_spend 
where ranking <= 2 
order by category, ranking;

#168
create table songs_history(history_id int,user_id int,song_id int,song_plays int);
insert into songs_history values(10011,777,1238,11),(12452,595,4520,1);
create table song_weekly (user_id int,song_id int,listen_time datetime);
insert into song_weekly values
(777,1238,STR_TO_DATE("2022/08/01 12:00:00", "%Y/%m/%d %H:%i:%s")),
(695,4520,STR_TO_DATE("2022/08/04 08:00:00", "%Y/%m/%d %H:%i:%s")),
(125,9630,STR_TO_DATE("2022/08/04 16:00:00", "%Y/%m/%d %H:%i:%s")),
(695,9852,STR_TO_DATE("2022/08/07 12:00:00", "%Y/%m/%d %H:%i:%s"));
select * from song_weekly;
select user_id, song_id, sum(song_plays) as song_count
from (
select user_id, song_id, song_plays from songs_history
          union all
          select user_id, song_id, count(song_id) as song_plays
          from song_weekly
          where listen_time <= '2022-08-04 23:59:59'
          group by user_id, song_id
) as report
group by user_id, song_id
order by song_count desc;

#169
create  table emails(email_id int,user_id int,signup_date datetime);
create table texts(text_id int,email_id int,signup_action varchar(15));
insert into emails values(125,7771,STR_TO_DATE("2022/06/14 00:00:00", "%Y/%m/%d %H:%i:%s")),
(236,6950,STR_TO_DATE("2022/07/01 00:00:00", "%Y/%m/%d %H:%i:%s")),
(433,1052,STR_TO_DATE("2022/07/09 00:00:00", "%Y/%m/%d %H:%i:%s"));
insert into texts values(6878,125,'confirmed'),
(6920,236,'Not confirmed'),(6994,236,'Confirmed');

Select round(sum(signup)/ count(user_id), 2) as confirmation_rate from (
            select user_id,
           (case when texts.email_id is not null then 1
                     else 0 
End) as signup
  from emails
  left join texts
    on emails.email_id = texts.email_id
    and signup_action = 'confirmed'
) as rate;

#170
create table tweets(tweet_id int,user_id int,tweet_date timestamp);
insert into tweets values
(214252,111,STR_TO_DATE("2022/06/01 12:00:00", "%Y/%m/%d %H:%i:%s")),
(739252,111,STR_TO_DATE("2022/06/01 12:00:00", "%Y/%m/%d %H:%i:%s")),
(846402,111,STR_TO_DATE("2022/06/02 12:00:00", "%Y/%m/%d %H:%i:%s")),
(241425,254,STR_TO_DATE("2022/06/02 12:00:00", "%Y/%m/%d %H:%i:%s")),
(137374,111,STR_TO_DATE("2022/06/04 12:00:00", "%Y/%m/%d %H:%i:%s"));
select * from tweets;

select user_id, tweet_date,
  round( avg(tweet_num) over (partition by user_id
      order by user_id,
 tweet_date rows between 2 preceding and current row), 2) as rolling_avg_3d
from ( select  user_id, tweet_date,
    count(distinct tweet_id) as tweet_num
    from tweets
    group by user_id, tweet_date) as tweet_count;

#171
create table activities(activity_id int,user_id int,
activity_type varchar(15),time_spent float,activity_date datetime);

insert into activities values
(7274,123,'open',4.50,STR_TO_DATE("2022/06/22 12:00:00", "%Y/%m/%d %H:%i:%s")),
(2425,123,'send',3.50,STR_TO_DATE("2022/06/22 12:00:00", "%Y/%m/%d %H:%i:%s")),
(1413,456,'send',5.67,STR_TO_DATE("2022/06/23 12:00:00", "%Y/%m/%d %H:%i:%s")),
(1414,789,'chat',11.00,STR_TO_DATE("2022/06/25 12:00:00", "%Y/%m/%d %H:%i:%s"));

create table age_breakdown(user_id int,age_bucket varchar(15));
insert into age_breakdown values(123,'31-35'),(456,'26-30'),(789,'21-25');

with snaps_statistics as (select age.age_bucket, 
 sum(case when activities.activity_type = 'send' 
         then activities.time_spent else 0 end) as send_timespent, 
 sum(case when activities.activity_type = 'open' 
      then activities.time_spent else 0 end) as open_timespent, 
 sum(activities.time_spent) as total_timespent 
 from activities
 inner join age_breakdown as age 
    on activities.user_id = age.user_id 
  where activities.activity_type in ('send', 'open') 
  group by age.age_bucket) 

select age_bucket, 
  round(100.0*send_timespent/total_timespent,2)as send_perc, 
  round(100.0 * open_timespent / total_timespent, 2) as open_perc 
from snaps_statistics;

#172
create table personal_profiles(profile_id int,name varchar(15),followers int);
insert into personal_profiles values(1,'Nick Singh',92000),(2,'Zach Wilson',199000),
(3,'Daliana liu',171000),(4,'Ravit Jain',107000),(5,'Vin Vashista',139000),
(6,'Susan Wojcicki',39000);

create table employee_company(personal_profile_id int,company_id int);
insert into employee_company values(1,4),(1,9),(2,2),(3,1),(4,3),(5,6),(6,5);

create table company_pages(company_id int,name varchar(35),followers int);
insert into company_pages values(1,'The data science podcast',8000),
(2,'Airbnb',700000),(3,'The Ravit Show',6000),(4,'Datalemur',200),
(5,'Youtube',16000000),(6,'DataScince Vin',4500),(9,'Ace the Data Science Interview',4479);

select distinct p.profile_id from personal_profiles p inner join employee_company e
on p.profile_id=e.personal_profile_id inner join company_pages c
on e.company_id=c.company_id
where p.followers>c.followers and p.profile_id not in
(    select p.profile_id from personal_profiles p inner join employee_company e
     on p.profile_id=e.personal_profile_id
     inner join company_pages c on e.company_id=c.company_id
     where p.followers<c.followers)
   order by p.profile_id;
   
   