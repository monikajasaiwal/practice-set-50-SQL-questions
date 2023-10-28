create database org ; 
use org;
show tables;
select * from worker;
select * from bonus;
--------- add data into tables ------
INSERT INTO bonus  (worker_refrence_id , bonus_amount, bonus_date)
VALUES
  (1, 5000, '2020-02-23'),
  (2, 3000, '2011-06-23'),
  (3, 4000, '2020-02-23'),
  (1, 4500, '2020-02-23'),
  (2, 3500, '2011-06-26');
create table Title( worker_refrence_id int , worker_title char (25),
Affected_from datetime,
foreign key (  worker_refrence_id)
 references worker ( worker_id)
 on delete cascade );
  INSERT INTO  Title ( worker_refrence_id , worker_title, Affected_from)
  values (1 , 'Manager', '23-02-20 00:00:00'),
  (2 , 'Excutive' ,'23-06-11 00:00:00'),
  ( 3 , 'Lead' ,'23-06-11 00:00:00'),
  (4 , 'Assistance manager', '23-06-11 00:00:00'),
  ( 5 , 'manager' ,'23-06-11 00:00:00'),
  ( 6 , 'Lead', '23-06-11 00:00:00'),
  ( 7 , 'Excutive' ,'23-06-11 00:00:00'),
  ( 8 , 'Excutive' ,'23-06-11 00:00:00');
  
  ----- Questions --------
  -- 1  write an query for first_name as alias Workers_name .
  select first_name as Workers_name from worker;
  -- 2 first name i upper case --
  select upper(first_name ) as workers_name from  worker;
  -- 3 unique values from department from worker table--
  select * from worker;
  select distinct department from worker;
  -- 4 first three character from first name--
  select substring( first_name ,1,3) from worker;
  -- 5 find the position of a in first name column Amitabh from worker table--
  select instr( first_name , binary 'a') from worker where first_name = 'Amitabh';
  -- 6 first name from worker after removing white spaces from right side--
  select rtrim( First_name ) from worker;
  select ltrim( First_name ) from worker;
  -- 7 department from worker after removing space from left--
  select rtrim(first_name ) from worker;
-- 8 unique vales from department and its length from worker --
select distinct(department), length(department) from worker;
-- 9 first name after replacing a with A--
select replace(first_name ,'a','A')  as new_name from worker;
-- 10 first name and last name as complete name with space --
select concat(first_name , " " , Last_name ) as complete_name from worker;
-- 11 worker details from worker table order by firts_name asscending--
select * from worker order by first_name asc;
-- 12 worker details from worker table order by firts_name asscending department by decending --
select * from worker order by first_name asc , department desc;
-- 13 worker details for vipul and satish--
select * from worker where first_name in  ('satish','vipul') ;
-- 14 worker details except firts name for vipul and satish  
select * from worker where first_name not in  ('satish','vipul') ;
select * from worker where first_name  not in  ('satish','vipul') ;
-- 15 worker department admin --
-- 16 worker details with first anme contaning a ---
select * from worker where first_name like '%a%';
-- 17 first anme ends with a--
select * from worker where first_name like '%a';
-- 18 worker details first anme ends with h and contains six alphabet--
select * from worker where first_name like '%h'  and length(6)
-- 19 worker details with salary lies between 100000 and 500000 -- 
 ; select * from worker where salary between 100000 and 500000 ;
 -- 20 worker details who joined in feb 2021;
 select * from worker where  year(joining_date )= 2020 and month(joining_date )= 02;
 select joining_date from worker;
 -- 21 count of employees working in admin department --
 select count(*) from worker where department = 'Admin';
-- 22 worker name with salary >= 50000 and <=100000
  select concat(first_name ,last_name ) , salary from worker 
  where salary between 50000 and 100000;
 ---- OR-----
 select concat(first_name ,last_name ) as employee_name , salary from worker
 where worker_id in (select worker_id from worker where salary between 50000 and 100000);
-- 23 number of worker in each department decending order--
select count(*),  department from worker 
group by department order by department desc;
-- 24 worker details who are manegers--
select * from title;
select distinct w.first_name , t.worker_title from worker w
inner join title t on
 w.worker_id = t.worker_refrence_id
and t.worker_title =  ('manager');
select * from title;
select * from worker;
-- 25 duplicates records--
select  worker_title , Affected_from from title
group by worker_title , Affected_from having count(*)>1 ;
 -- 26 show only odd rows of a table 
 select * from worker 
 where worker_id %2 = 1 ;
 -- 27 even rows--
  select * from worker 
 where worker_id %2 = 0 ; 
 -- 28 clone a new table from another table--
 create table workerclone as
 select * from worker;
 -- 29 find intersecting records of two table--
 select * from worker
inner join workerclone on worker.worker_id = workerclone.worker_id; 
-- 30 show records from one table that another table doesn't have--
select * from worker 
left join title on worker.worker_id = title.worker_refrence_id ;
-- 31 show curreent date and time 
select now();
-- 32 show top 10 records--
select * from worker order by worker_id  limit 10;
select * from worker order by salary   limit 10;
-- 33 query to determine 5th highest salary from a table --
 select  distinct * from worker order by salary
 desc limit 1 offset 4;
-- 34 query to determine 5th highest salary from a table without using top or limit--
SELECT Salary FROM Worker W1
WHERE 4 = (SELECT COUNT( DISTINCT ( W2.Salary ) )
 FROM Worker W2
 WHERE W2.Salary >= W1.Salary
 );
 -- 35  query to find employees with same salary
 select * from worker w ,  worker w1
 where w.salary = w1.salary
 and w.worker_id != w1.worker_id;
-- 36 employees with 2nd highest salary--
select  first_name ,salary from worker 
order by salary desc limit 1 offset 2 ;
-- or --
select  first_name ,salary from worker w1 
where 2 = ( select count(distinct salary) from worker w2
where w2.salary >= w1.salary);
--- or --- 
select first_name , salary from worker
where salary = (select max(salary) from worker);
-- now find 2nd highest salary--
select   max(salary) from worker   
where salary not in (select  max(salary) from worker);
-- 37 query to show one row twice--
select * from worker;
select first_name , department , salary from worker w 
union all 
select  first_name , department , salary from worker w1 order by first_name ; 
-- 38 query to fetch intersecting records --
select * from worker
inner join title on worker.worker_id = title.worker_refrence_id;
-- or ----
(SELECT * FROM Worker)
INTERSECT
(SELECT * FROM WorkerClone);
-- 39 query to find 50% of data from a table--
select * from worker
 where worker_id <=
 ( select count(worker_id)/2 from worker);
 -- 40 department that have less than 5 people--
 select count(worker_id) as number_of_employee ,department
 from worker where worker_id < 5
 group by department;
 -- 41 department along with their number of employee--
 select count(worker_id) as number_of_employee , department 
 from worker
 group by department;
 -- 42 last records of table--
 select * from worker order by worker_id desc limit 1;
 -- or ---
 select * from worker where worker_id = 
 (select max(worker_id ) from worker);
--  43 first record of table--
 select * from worker order by worker_id limit 1;
 -- or--
 select * from worker where worker_id =
 ( select min(worker_id) from worker);
 -- 44 record less than 5 worker_id--
 SELECT * FROM Worker WHERE WORKER_ID <=5
UNION
SELECT * FROM (SELECT * FROM Worker W order by W.WORKER_ID DESC)
 AS W1 WHERE W1.WORKER_ID <=5 ;
 -- 45 find employee with highest salary in each department--
WITH Ranked_employee as
( select first_name, salary , department , row_number() over
( partition by department order by salary desc ) as row_num
from worker ) 
select first_name , department , salary 
from ranked_employee where row_num = 1 ; 
-- or-- 
select w.first_name, w.salary, w.department from( select max(salary) as total_salary,
 department from worker group by department)
as tempnew 
join worker w on tempnew.department = w.department
and tempnew.total_salary = w. salary;
-- 46 fetch 3 max salary--
select distinct salary from worker a where 3 >=( 
select count(distinct salary) from worker b where 
a.salary <= b. salary ) order by salary ; 
-- 47 fetch  3 min salary--
select distinct salary from worker a where 3<= ( select count(distinct salary) from worker b where 
a.salary <= b.salary) order by salary ;
-- 48 fetch nth max salary--
select distinct salary from worker a where n >= ( select count(distinct salary) from worker b where 
a.salary <= b.salary) order by salary ; 
-- 49. fetch departments along with the total salaries paid for each of them.
select sum(salary) , department from worker
 group by department ;
-- 50 names of worker who earns highest salary--
 select first_name, department from worker  where salary=
 (select max(salary) from worker) ; 
--- ----------- end ----------------- 
