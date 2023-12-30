

#######################################################    sql - project    ########################################################################################################################


# WE USE THE 'HR' AS IN HUMAN RESOURCES DATABASE FOR THIS PROJECT. 

# LET ME DESCRIBE AS TO WHAT THE DATABASE CONSISTS OF : 

# 'HR' HAS 7 TABLES :
#                    > COUNTRIES   :  country_id , country_name , region_id                                                                                                   : ( 3 columns * 25 rows )
#                    > DEPARTMENTS :  department_id , department_name , manager_id , location_id                                                                              : ( 4 columns * 27 rows )
#                    > EMPLOYEES   :  employee_id , first_name , last_name , email , phone_number , hire_date , job_id , salary , commission_pct , manager_id , department_id : ( 11 columns * 107 rows )
#                    > JOB_HISTORY :  employee_id , start_date , end_date , job_id , department_id                                                                            : ( 5 columns * 10 columns )
#                    > JOBS        :  job_id , job_title , min_salary , max_salary                                                                                            : ( 4 columns * 19 columns )
#                    > LOCATIONS   :  location_id , street_address , postal_code , city , state_province , country_id                                                         : ( 6 columns * 23 columns )
#                    > REGIONS     :  region_id , region_name                                                                                                                 : ( 2 columns * 4  columns)

#  I CREATED A LIST OF QUESTIONS WHICH COVER THE FOLLWING TOPICS : 
#                                                                 > DDL (DATA DEFINITION LANGUAGE) 
#                                                                                               > CREATE
#                                                                                               > DROP
#                                                                                               > ALTER
#                                                                                               > TRUNCATE
#                                                                                               > COMMENT
#                                                                                               > RENAME

#                                                                 > DQL (DATA QUERY LANGUAGE )
#                                                                                            > SELECT

#                                                                 > DML (DATA MANIPULATION LAGUAGE )
#                                                                                            > INSERT
#                                                                                            > UPDATE
#                                                                                            > DELETE
#                                                                                            > LOCK

#                                                                 > FUNCTIONS
#                                                                            > DISTINCT
#                                                                            > WHERE
#                                                                            > BETWEEN
#                                                                            > AND / OR
#                                                                            > LIKE
#                                                                            > IN
#                                                                            > ORDER BY
#                                                                            > GROUP BY
#                                                                            > COUNT
#                                                                            > HAVING

#                                                                 > AGGREGATE 
#                                                                            > AVG()
#                                                                            > COUNT()
#                                                                            > FIRST()
#                                                                            > LAST()
#                                                                            > MAX()
#                                                                            > MIN()
#                                                                            > SUM()

#                                                                  > JOINS
#                                                                            > INNNER JOIN
#                                                                            > LEFT JOIN
#                                                                            > RIGHT JOIN
#                                                                            > FULL JOIN

################################################################################################################################################################################################
use hr;

# 1.	Display all information in the tables EMP and DEPT.

select *
from employees inner join departments using(department_id);

# 2. Display only the hire date and employee name for each employee.

select distinct hire_date , concat(first_name," ",last_name) as NAME
from employees;

# 3. Display the ename concatenated with the job ID, separated by a comma and space, 
#   and name the column Employee and Title

select concat(first_name," ",last_name," ",","," ",job_id) as "Employee and Title"  
from employees;

# 4. Display the hire date, name and department number for all clerks.

select concat(first_name," ",last_name) as Name , hire_date , department_id , job_id
from employees
where job_id like "%RK";

# 5. Create a query to display all the data from the EMP table. 
#    Separate each column by a comma. Name the column THE OUTPUT

select concat(employee_id,",",first_name,",",last_name,",",email,",",phone_number,",",hire_date,",",job_id,",",salary,",",commission_pct,",",manager_id,",",department_id) as "THE OUTPUT"
from employees
where commission_pct is not null;  

#the code is right but "comission_pct" is null so the concatenated ans is "NULL" and where it is non null,it shows the concatenated ans in the right manner.
# hence put a condition to show only the result where the commision is not null.

# 6. Display the names and salaries of all employees with a salary greater than 2000.

select concat(first_name," ",last_name) as Name , salary
from employees
where salary > 2000;

# 7. Display the names and dates of employees with the column headers "Name" and "Start Date"

select concat(first_name," ",last_name) as Name , hire_date as Start_Date
from employees;

# 8. Display the names and hire dates of all employees in the order they were hired.

select concat(first_name," ",last_name) as Name , hire_date
from employees
order by hire_date;

# 9. Display the names and salaries of all employees in reverse salary order.

select concat(first_name," ",last_name) as Name , salary
from employees
order by salary desc;

# 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.

select concat(first_name," ",last_name) as "ename" , department_id as "deptno", salary
from employees
where commission_pct is not null
order by salary desc;

# 11. Display the last name and job title of all employees who do not have a manager

select last_name , job_title
from employees inner join jobs
using (job_id)
where manager_id is null;

# 12. Display the last name, job, and salary for all employees whose job is 
#      sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000

select last_name , job_title , salary
from employees inner join jobs
using (job_id)
where job_title in ("Sales Representative" , "Stock Clerk") and salary not in (2,500 , 3,500 , 5,000);

# 13. Display the maximum, minimum and average salary and commission earned.   

select max(salary) , min(salary) , avg(salary) , sum(commission_pct)
from employees
group by salary;

# 14. Display the department number, total salary payout and total commission payout for each department.

select department_id , sum(salary) , sum(commission_pct)
from employees
group by department_id;

# 15. Display the department number and number of employees in each department.

select department_id , count(employee_id)
from employees
group by department_id;

# 16. Display the department number and total salary of employees in each department.

select department_id , sum(salary) 
from employees
group by department_id;

# 17. Display the employee's name who doesn't earn a commission. Order the result set without using the column name

select concat(first_name , " " , last_name) as "employees with no commission earned"
from employees
where commission_pct is null;

# 18. Display the employees name, department id and commission. If an Employee doesn't earn the commission, 
#     then display as 'No commission'. Name the columns appropriately

select concat(first_name," ",last_name) as "NAME",department_id as "DEPARTMENT",
case
when commission_pct is null then "No commission"
else commission_pct
end as "COMMISSION"
from employees;

# 19. Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't
#     earn the commission, then display as 'No commission. Name the columns appropriately

select concat(first_name," ",last_name) as "Name",salary,
case
when commission_pct is null then "No commission"
else commission_pct*2
end as "Commission"
from employees;

# 20. Display the employee's name, department id who have the first name same as another 
#     employee in the same department

select department_id,
case
when first_name = first_name then first_name
else "No"
end as "Name"
from employees;           

# 21. Display the sum of salaries of the employees working under each Manager.

select manager_id , sum(employee_id) , sum(salary)
from employees
group by manager_id;

# 22. Select the Managers name, the count of employees working under and the department ID of the manager.

select e.last_name "manager", count(e.employee_id) "total employees" , m.department_id "manager department_id"
from employees e join employees m
on e.employee_id = m.manager_id
group by e.last_name, m.department_id;

# 23. Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name 
#     should have second letter 'a!

use hr;

select e.last_name  
from employees e join employees m
on e.employee_id = m.manager_id
where m.last_name like "%a%"     
group by e.last_name;

select e.last_name as "employee_name" , e.department_id as "emp.depart" ,e.salary as "emp.salary" 
from employees e join employees m
on e.employee_id = m.manager_id;

# 24. Display the average of sum of the salaries and group the result with the department id. Order the result with the department id.

select department_id ,(sum(salary))/(count(salary)) as sal
from employees
group by department_id;

# 25. Select the maximum salary of each department along with the department id

select department_id ,max(salary)
from employees
group by department_id;

# 26. Display the commission, if not null display 10% of salary, if null display a default value 

select 
case
when commission_pct is not null then (salary/10)*100
else null
end as commission
from employees;

# 27. Write a query that displays the employee's last names only from the string's 2-5th position with the first letter 
#     capitalized and all other letters lowercase, Give each column an appropriate label.

# to display the last name with 2 - 5 letters only and along wiht this  display the first letter capitalized and rest in lowe case
# so 2nd position is capital and 3 , 4 and 5 is lower case

select last_name , upper(substring(last_name,2,1)) as upper , lower(substring(last_name,3,3)) as lower
from employees;

# 28. Write a query that displays the employee's first name and last name along with a " in between for 
#     e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.

select concat(first_name,"-",last_name) as NAME , substring(hire_date,6,2) as month
from employees;   

# 29. Write a query to display the employee's last name and if half of the salary is greater than ten thousand then 
#     increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. Provide each column an appropriate label.

select last_name , 
case when (salary/2) > 10000 then salary+((salary/10)*100)+1500
else salary+((salary/11.5)*100)+1500
end as INCREMENTED_SAL
from employees;

# 30. Display the employee ID by Appending two zeros aft er 2nd digit and 'E' in the end, department id, salary 
#     and the manager name all in Upper case, if the Manager name consists of 'z' replace it with '$!

select employee_id , department_id , salary ,
case
when upper(concat(first_name," ",last_name)) like "%z%" then "$"
else upper(concat(first_name," ",last_name))
end as NAME
from employees;

# 31. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase,
#     and the length of the names, for all employees whose name starts with J, A, or M. Give each column an appropriate label.
#     Sort the results by the employees' last names

select first_name as FIRSTNAME , concat(upper(substring(last_name,1,1)),lower(substring(last_name,2))) as LASTNAME , length(concat(first_name," ",last_name)) as LENGTH_LASTNAME
from employees
where first_name like "J%" or first_name like "A%" or first_name like "M%"
order by last_name; 

# 32. Create a query to display the last name and salary for all employees. Format the salary to be 15 characters long, 
#     left-padded with $. Label the column SALARY

select last_name ,lpad(salary,15,"$")
from employees;

# 33. Display the employee's name if it is a palindrome

select first_name,
case 
when first_name = reverse(first_name) then first_name
else "null"
end as "palindrome"
from employees;       ## for first name

select last_name,
case 
when last_name = reverse(last_name) then last_name
else "null"
end as "palindrome"
from employees;         ## for last name

select concat(first_name," ",last_name) as NAME,
case 
when concat(first_name," ",last_name) = reverse(concat(first_name," ",last_name)) then concat(first_name," ",last_name)
else "null"
end as "palindrome"
from employees;        ## for complete name


###############################   none of these are PALINDROMES


# 34. Display First names of all employees as inticap.

select concat(substring(upper(first_name),1,1),substring(lower(first_name),2)) as INITCAP
from employees;     ################## "initcaps" does not exist in sql , hence used "substring"

# 35. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.

select SUBSTRING_INDEX(SUBSTRING_INDEX(street_address, " ", 2), " ", -1),street_address
from locations;

select substring(street_address," ")
from locations;                       

# 36. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end.
#     Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name.

select concat(first_name," ",substring(lower(first_name),1,1)," ",lower(last_name)," @systechusa.com") as E_MAIL_ADDRESS
from employees;

# 37. Display the names and job titles of all employees with the same job as Trenna.
 #################### 3 table  join

select concat(first_name," ",last_name) as NAME , job_title as TITLE
from employees inner join jobs
using (job_id)
where job_id like "%RK";    

# 38. Display the names and department name of all employees working in the same city as Trenna.

select concat(first_name," ",last_name) as NAME , department_name , city
from employees 
inner join departments using (department_id)
inner join locations using (location_id)
where first_name like "Trenna%";     #finding the city of trenna and then using "where" condition below to filter only that city.

select concat(first_name," ",last_name) as NAME , department_name , city
from employees 
inner join departments using (department_id)
inner join locations using (location_id)
where city like "South San Francisco";

# 39. Display the name of the employee whose salary is the lowest.

select concat(first_name," ",last_name) as Name ,salary
from employees
order by salary
limit 1;            

# 40. Display the names of all employees except the lowest paid.

select concat(first_name," ",last_name) ,salary
from employees
order by salary
limit 106 ;  

# 41. Write a query to display the last name, department number, department name for all employees.

select last_name , department_id as department_number ,  department_name
from employees join departments
using (department_id);

# 42. Create a unique list of all jobs that are in department 4. Include the location of the department in the output.

select department_id , job_title,city
from employees
inner join jobs using (job_id)
inner join departments using (department_id)
inner join locations using (location_id)
where department_id like 30;

# 43. Write a query to display the employee last name,department name,location id and city of all employees who earn commission.

select last_name , department_name , location_id , city , commission_pct
from employees
inner join departments using(department_id)
inner join locations using (location_id)
where commission_pct is not null;

# 44. Display the employee last name and department name of all employees who have an 'a' in their last name

select last_name , department_name
from employees
inner join departments using(department_id)
where last_name like "%a%";

# 45. Write a query to display the last name,job,department number and department name for all employees who work in OXFORD.

select last_name , department_id , job_title , department_name , city
from employees
inner join jobs using (job_id)
inner join departments using (department_id)
inner join locations using (location_id)
where city like "Oxford"; 

# 46. Display the employee last name and employee number along with their manager's last name and manager number.

select m.last_name "emp.last_name" , e.employee_id , e.last_name "man.last_name" , e.manager_id
from employees e join employees m
on e.employee_id = m.manager_id;

# 47. Display the employee last name and employee number along with their manager's last name and manager number 
#     (including the employees who have no manager).

select m.last_name "employee",e.employee_id "emp.id",e.last_name as "manager",e.manager_id as "man.id"
from employees e join employees m on e.employee_id = m.manager_id;

# 48. Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee.

select last_name,department_id,employee_id
from employees
order by department_id;       ###########    wrong question     ### DISREGARDED!!!

# 49. Create a query that displays the name,job,department name,salary,grade for all employees. Derive grade based on 
#     salary(>=50000=A, >=30000=B,<30000=C)

select concat(first_name," ",last_name) as NAME , job_title , department_name , salary , 
case
when salary >=50000 then "A" 
when salary >= 30000 then "B"
when salary < 30000 then "C"
else null
end as "Grade"
from employees
inner join jobs using (job_id)
inner join departments using(department_id);

# 50. Display the names and hire date for all employees who were hired before their managers along with their manager names 
#     and hire date. Label the columns as Employee name, emp_hire_date,manager name,man_hire_date

select m.last_name as "Employee name" , e.last_name as "Manager name" , m.last_name as "Employee" , e.hire_date as "man_hire_date",
case
when e.hire_date < m.hire_date then e.hire_date
else null
end as "emp_hire_date"
from employees e join employees m on e.employee_id = m.manager_id;
     
# 51. Write a query to display the last name and hire date of any employee in the same department as SALES.

select last_name , hire_date , department_name 
from employees 
inner join departments using (department_id)
where department_name like "Sales";

# 52. Create a query to display the employee numbers and last names of all employees who earn more than the average salary. 
#     Sort the results in ascending order of salary.

select employee_id , last_name , salary,
case
when salary > avg(salary) then salary
else null
end as sal                         ############  grouping error in question
from employees
order by salary;

# 53. Write a query that displays the employee numbers and last names of all employees who work in a department 
#     with any employee whose last name contains a 'u'

select employee_id,last_name,department_id
from employees
where last_name like "%u%";   

# 54. Display the last name, department number, and job ID of all employees whose department location is OXFORD.

select last_name,department_name,job_id,city
from employees
inner join departments using (department_id)
inner join locations using (location_id)
where city like "OXFORD";

# 55. Display the last name and salary of every employee who reports to Alberto Errazuriz.

select e.last_name "manager" , m.last_name "employee" , e.salary
from employees e
join employees m 
on e.employee_id = m.manager_id
where e.last_name = "Errazuriz";

# 56. Display the department number, last name, and job ID for every employee in the FINANCE department.

select department_id , last_name , job_id , department_name
from employees 
inner join departments using (department_id)
where department_name like "Finance";

# 57. Modify the above query to display the employee numbers, last names, and salaries of all employees who earn
#     more than the average salary and who work in a department with any employee with a 'u'in their name.

select employee_id , last_name , salary
from employees                             
inner join departments using (department_id)
where concat(first_name,last_name) like "%u%";

# 58. Display the names of all employees whose job title is the same as anyone in the sales dept.

select concat(first_name," ",last_name) as Name , job_title , department_name
from employees
inner join departments using (department_id)
inner join jobs using (job_id)
where department_name like "Sales";

# 59. Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. 
#     Employees in department 1 and 3 are given a 5% raise, employees in department 2 are given a 10% raise, employees 
#     in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise.

select concat(first_name," ",last_name) as NAME , employee_id , salary , 
case
when department_id in (10,30) then "5%"
when department_id like "20" then "10%"
when department_id in (40,50) then "15%"
when department_id like "60" then null
else null
end as raise_percentage
from employees;

# 60. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries.

select last_name ,  salary
from employees
order by salary desc
limit 3;

# 61. Display the names of all employees with their salary and commission earned. Employees with a null commission should 
#     have O in the commission column

select concat(first_name," ",last_name) as Name , salary,
case
when commission_pct is not null then commission_pct
else "0"
end as commission
from employees;

# 62. Display the Managers (name) with top three salaries along with their salaries and department information.

select e.department_id , department_name , e.last_name "manager name" ,  m.salary "manager_salary" , m.last_name "employee_name" ,e.salary "employee_salary" 
from employees e 
join employees m
on e.employee_id = m.manager_id
join departments d on e.department_id = d.department_id
order by e.salary desc
limit 3;

# DATE FUNCTION

# 63. Find the date difference between the hire date and resignation_date for all the employees. Display in no. of days, months 
#     and year(1 year 3 months 5 days). Emp_ID Hire Date Resignation_Date
#    1 1/1/2000 7/10/2013
#    2 4/12/2003 3/8/2017
#    3 22/9/2012 21/6/2015
#    4 13/4/2015 NULL
#    5 03/06/2016 NULL
#    6 08/08/2017 NULL
#    7 13/11/2016 NULL

create table empdate (
emp_id int ,
hire_date date , 
resignation_date date
);

insert into empdate values (1 , '1/1/2000' , '7/10/2013');
insert into empdate values (2 , '4/12/2003' , '3/8/2017');
insert into empdate values (3 , '22/9/2012' , '21/6/2015');
insert into empdate values (4 , '13/4/2015' , NULL);
insert into empdate values (6 , '08/08/2017' , NULL);
insert into empdate values (7 , '13/11/2016' , NULL);

select floor(datediff(resignation_date , hire_date)/365) as "years" , 
	   floor((datediff(resignation_date,hire_date)%365)/30) as "months" , 
            ((datediff(resignation_date,hire_date)%365)%30) as "days"
from empdate;  

# 64. Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)

select emp_id , date_format(hire_date,"%m/%d/%Y") as "hiredate_formatted" , 
case 
when resignation_date is not null then date_format(resignation_date,"%b %D , %Y")
else "DEC, 01th 1900"
end as "resignation_formatted_date"
from empdate;

# 65. Calcuate experience of the employee till date in Years and months(example 1 year and 3 months)
# we need to find the difference between the hiredate and till date and then showcase it like the given format.

select emp_id,hire_date , curdate() as "till_date", 
case 
when resignation_date is null then concat(floor(datediff(curdate(),hire_date)/365)," " ,"years" ," " ,floor((datediff(curdate(),hire_date)%365)/30) ," " , "months")
else "no longer working"
end as "experiance" 
from empdate; 