-- 7. Создание БД "Друзья человека"
create database Human_friends;

-- 8. Создание таблицы с иерархией из диаграммы в БД
use Human_friends;

create table Animal_class (
	ID int auto_increment primary key,
    class_name varchar(20)
);

insert into animal_class (class_name)
values ('вьючные'), ('домашние');

create table animal_pack (
	ID INT auto_increment primary key,
    genus varchar(20),
    id_class INT,
    foreign key (id_class) references animal_class (ID) on delete cascade on update cascade
);

insert into animal_pack (genus, id_class) 
values
('лошади', 1),
('ослы', 1),
('Верблюды', 1);

create table home_animals (
	ID int auto_increment primary key,
    genus varchar(20),
    id_class INT,
    foreign key (id_class) references animal_class (ID) on delete cascade on update cascade
);

insert into home_animals (genus, id_class) 
values
('кошки', 2),
('собаки', 2),
('хомяки', 2);

-- 9. Заполнение низкоуровневых таблиц

create table cats (
	ID int auto_increment primary key,
    name varchar(20),
    birthday date,
    commands varchar(30),
    genus int,
    foreign key (genus) references home_animals (ID) on delete cascade on update cascade
);

insert into cats (name, birthday, commands, genus)
values ('Вася', '2021-01-01', 'лапу', 1),
('Барсик', '2019-01-01', "ко мне", 1),  
('Томас', '2014-01-01', "", 1); 

create table dogs 
(       
    ID int auto_increment primary key,
    name varchar(20),
    birthday date,
    commands varchar(30),
    genus int,
    foreign key (genus) references home_animals (ID) on delete cascade on update cascade
);

insert into dogs (name, birthday, commands, genus)
values ('Барбос', '2023-01-01', 'ко мне, сидеть, голос', 2),
('Граф', '2022-06-05', "лапу, голос", 2),  
('Шарик', '2021-02-01', "фу, место, сидеть, след", 2), 
('Белка', '2020-03-10', "след, фас, фу, место", 2);

create table hamsters 
(       
    ID int auto_increment primary key,
    name varchar(20),
    birthday date,
    commands varchar(30),
    genus int,
    foreign key (genus) references home_animals (ID) on delete cascade on update cascade
);

insert into hamsters (name, birthday, commands, genus)
values ('Сардж', '2023-04-01', '', 3),
('Кореш', '2022-05-01', '', 3),  
('Черныщ', '2021-06-01', NULL, 3);

create table horses 
(       
    ID int auto_increment primary key,
    name varchar(20),
    birthday date,
    commands varchar(30),
    genus int,
    foreign key (genus) references home_animals (ID) on delete cascade on update cascade
);

insert into horses (name, birthday, commands, genus)
values ('Гром', '2022-07-01', 'бегом, шагом', 1),
('Закат', '2021-07-01', "бегом, шагом, хоп", 1),  
('Байкал', '2020-08-02', "бегом, шагом, хоп, брр", 1), 
('Спирит', '2019-09-01', "бегом, шагом, хоп", 1);

create table donkeys 
(       
    ID int auto_increment primary key,
    name varchar(20),
    birthday date,
    commands varchar(30),
    genus int,
    foreign key (genus) references home_animals (ID) on delete cascade on update cascade
);

insert into donkeys (name, birthday, commands, genus)
values ('Первый', '2023-10-01', "ко мне", 2),
('Второй', '2022-11-01', "", 2),  
('Третий', '2021-12-01', "", 2), 
('Четвертый', '2020-01-10', NULL, 2);

create table camels 
(       
    ID int auto_increment primary key,
    name varchar(20),
    birthday date,
    commands varchar(30),
    genus int,
    foreign key (genus) references home_animals (ID) on delete cascade on update cascade
);

insert into camels (name, birthday, commands, genus)
values ('Горбатая', '2023-10-01', 'вернись', 3),
('Гора', '2019-03-12', "остановись", 3),
('Борода', '2022-12-10', "улыбнись", 3);

select * from home_animals;

-- 10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. 
-- Объединить таблицы лошади, и ослы в одну таблицу.

truncate table camels;

select name, birthday, commands from horses
union select name, birthday, commands from donkeys;

-- 11. Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но 
-- младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице

create temporary table animals as 
select *, 'Лошади' as genus_animal from horses
union select *, 'Ослы' as genus_animal from donkeys
union select *, 'Собаки' as genus_animal from dogs
union select *, 'Кошки' as genus_animal from cats
union select *, 'Хомяки' as genus_animal from hamsters;

create table yang_animal as
select name, birthday, commands, genus, timestampdiff(month, birthday, CURDATE()) as age_in_month
from animals where birthday between ADDDATE(curdate(), interval -3 year) and ADDDATE(CURDATE(), interval -1 year);
 
select * from yang_animal;

-- 12. Объединить все таблицы в одну, при этом сохраняя поля, 
-- указывающие на прошлую принадлежность к старым таблицам.

select h.name, h.birthday, h.commands, pa.genus, ya.age_in_month 
from horses h
left join yang_animal ya on ya.name = h.name
left join animal_pack pa on pa.ID = h.genus
union 
select d.name, d.birthday, d.commands, pa.genus, ya.age_in_month 
from donkeys d 
left join yang_animal ya on ya.name = d.name
left join animal_pack pa on pa.ID = d.genus
union
select c.name, c.birthday, c.commands, ha.genus, ya.age_in_month 
FROM cats c
left join yang_animal ya on ya.name = c.name
left join home_animals ha on ha.ID = c.genus
union
select d.name, d.birthday, d.commands, ha.genus, ya.age_in_month 
from dogs d
left join yang_animal ya on ya.name = d.name
left join home_animals ha on ha.ID = d.genus
union
select hm.Name, hm.birthday, hm.commands, ha.genus, ya.age_in_month 
from hamsters hm
left join yang_animal ya on ya.name = hm.name
left join home_animals ha on ha.ID = hm.genus;
