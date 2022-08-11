use test_db

CREATE table worker(
worker_id varchar(10),
first_name varchar(100), 
last_name varchar(100),
salary int,
joining_date datetime,
department varchar(10))

INSERT INTO worker values ("001", "Monika", "Arora", 100000, '2014-02-20 09:00:00', "HR");
INSERT INTO worker values ("002", "Niharika", "Verma", 80000, '2014-06-11 09:00:00', "Admin");
INSERT INTO worker values ("003", "Vishal", "Singhal", 300000, '2014-02-20 09:00:00', "HR");
INSERT INTO worker values ("004", "Amitabh", "Singh", 500000, '2014-02-20 09:00:00', "Admin");
INSERT INTO worker values ("005", "Vivek", "Bhati", 500000, '2014-06-11 09:00:00', "Admin");
INSERT INTO worker values ("006", "Vipul", "Diwan", 200000, '2014-06-11 09:00:00', "Account");
INSERT INTO worker values ("007", "Satish", "Kumar", 75000, '2014-01-20 09:00:00', "Account");
INSERT INTO worker values ("008", "Geetika Chauhan", "Arora", 90000, '2014-04-11 09:00:00', "Admin");

CREATE table bonus(
worker_ref_id int,
bonus_date datetime,
bonus_amt int)

CREATE table title(
worker_ref_id int,
worker_title varchar(100), 
affected_from datetime)



INSERT INTO bonus values (1,'2016-02-20 00:00:00',5000);
INSERT INTO bonus values (2,'2016-06-11 00:00:00',3000);
INSERT INTO bonus values (3,'2016-02-20 00:00:00',4000);
INSERT INTO bonus values (1,'2016-02-20 00:00:00',4500);
INSERT INTO bonus values (2,'2016-06-11 00:00:00',3500);


INSERT INTO title values (1,'Manager','2016-02-20 00:00:00');
INSERT INTO title values (2,'Executive','2016-06-11 00:00:00');
INSERT INTO title values (8,'Executive','2016-06-11 00:00:00');
INSERT INTO title values (5,'Manager','2016-06-11 00:00:00');
INSERT INTO title values (4,'Asst. Manager','2016-06-11 00:00:00');
INSERT INTO title values (7,'Executive','2016-06-11 00:00:00');
INSERT INTO title values (6,'Lead','2016-06-11 00:00:00');
INSERT INTO title values (3,'Lead','2016-06-11 00:00:00');


select * from title
worker, bonus, title

select concat(first_name,' ',last_name) as worker_name from worker

# fetch first_name in upper case
select upper(first_name) from worker

# fetch unique values of department
select distinct department from worker

# print first 3 characters of first_name
select substring(first_name,1,3) as first_3 from worker

select first_name from worker


# find the position of the alphabet (‘a’) in the first name column 
select first_name, instr(first_name, binary'a') from worker

# fetch the unique values of DEPARTMENT from Worker table and prints its length.
select distinct length(DEPARTMENT) from worker

select distinct length(DEPARTMENT) from worker

# print details of the Workers whose FIRST_NAME contains ‘a’
select * from Worker where FIRST_NAME like '%a%';

# print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
Select * from Worker where FIRST_NAME like '_____h';
select * from worker where length(first_name) = 6 and first_name like '%h'


# fetch the no. of workers for each department in the descending order
select count(worker_id) no_of_workers, department from worker group by department order by no_of_workers desc


# print details of the Workers who are also Managers.
select w.first_name, w.last_name, t.worker_title from worker w, title t where w.worker_id = t.worker_ref_id and t.worker_title = 'Manager'
select w.first_name, w.last_name, t.worker_title from worker w INNER JOIN title t ON w.worker_id = t.worker_ref_id and t.worker_title = 'Manager'

#show odd rows of a table
select * from worker where mod(worker_id,2)<>0
#event rows
select * from worker where mod(worker_id,2)=0

#determine 5h highest salary from the table
SELECT Salary FROM Worker ORDER BY Salary DESC LIMIT 2,1;

#determine nth highest without using TOP or LIMIT
SELECT Salary
FROM Worker W1
WHERE 4 = (
 SELECT COUNT( DISTINCT ( W2.Salary ) )
 FROM Worker W2
 WHERE W2.Salary >= W1.Salary
 );

# query to fetch list of employees with the same salary
Select distinct W.WORKER_ID, W.FIRST_NAME, W.Salary 
from Worker W, Worker W1 
where W.Salary = W1.Salary 
and W.WORKER_ID != W1.WORKER_ID;

SELECT count(WORKER_ID)/2 from Worker

# query to fetch first 50% records
SELECT *
FROM WORKER
WHERE WORKER_ID > (SELECT count(WORKER_ID)/2 from Worker);

# query to fetch departments having less than five people in it
SELECT DEPARTMENT, COUNT(WORKER_ID) as 'Number of Workers' FROM Worker GROUP BY DEPARTMENT HAVING COUNT(WORKER_ID) < 5;

# query to print name of employees having the highest salary in each department
SELECT t.DEPARTMENT,t.FIRST_NAME,t.Salary from(SELECT max(Salary) as TotalSalary,DEPARTMENT from Worker group by DEPARTMENT) as TempNew 
Inner Join Worker t on TempNew.DEPARTMENT=t.DEPARTMENT 
 and TempNew.TotalSalary=t.Salary;

create table max_salary as
SELECT max(Salary) as TotalSalary,DEPARTMENT from Worker group by DEPARTMENT

SELECT t.DEPARTMENT,t.FIRST_NAME,t.Salary from max_salary m
Inner Join Worker t on m.DEPARTMENT=t.DEPARTMENT 
 and m.TotalSalary=t.Salary;

