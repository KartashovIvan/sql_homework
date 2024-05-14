create database javaacademy;
create schema univers;

create table if not exists univers.faculty (
id int primary key,
faculty_name varchar(100),
ducation_cost numeric(9,2));

create table if not exists univers.course (
id int primary key,
course_number int,
faculty_id int references univers.faculty(id));

create table if not exists univers.students (
id int primary key,
name_student varchar(100),
surname varchar(100),
patronymic varchar(100),
type_training varchar(100),
course_id int references univers.course(id));

insert into univers.faculty values (1,'Инженерный',30000);
insert into univers.faculty values (2,'Экономический',49000);

insert into univers.course values (1,1,1);
insert into univers.course values (2,1,2);
insert into univers.course values (3,4,2);

insert into univers.students values (1,'Петр','Петров','Петрович','бюджетник',1);
insert into univers.students values (2,'Иван','Иванов','Иваныч','частник',1);
insert into univers.students values (3,'Сергей','Михно','Иваныч','бюджетник',3);
insert into univers.students values (4,'Ирина','Стоцкая','Юрьевна','частник',3);
insert into univers.students values (5,'Настасья','Младич',null,'частник',2);

--Вывести всех студентов, кто платит больше 30_000.
select s.name_student ,s.surname ,s.patronymic ,f.ducation_cost 
from univers.students s 
join univers.course c on s.course_id = c.id 
join univers.faculty f on c.faculty_id = f.id  
where f.ducation_cost > (30000);

--Перевести всех студентов Петровых на 1 курс экономического факультета.
update univers.students set course_id = 2 where surname = 'Петров';

--Вывести всех студентов без отчества или фамилии.
select * from univers.students s where surname isnull or patronymic isnull;

--Вывести всех студентов содержащих в фамилии или в имени или в отчестве "ван"
select
* 
from
univers.students s 
where 
name_student like '%ван%' or surname like '%ван%' or patronymic like '%ван%';

--Удалить все записи из всех таблиц.
TRUNCATE TABLE univers.students;
TRUNCATE TABLE univers.course;
TRUNCATE TABLE univers.faculty;
