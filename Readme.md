# Итоговая контрольная работа

## Информация о проекте

Необходимо организовать систему учета для питомника в котором живут домашние и вьючные животные.

### Задание

1. Используя команду cat в терминале операционной системы Linux, создать два файла Домашние животные (заполнив файл собаками, кошками, хомяками) и Вьючные животными заполнив файл Лошадьми, верблюдами и ослы), а затем объединить их. Просмотреть содержимое созданного файла.
Переименовать файл, дав ему новое имя (Друзья человека).

```
cat > "Домашние животные"
cat > "Вьючные животные"
cat "Домашние животные" "Вьючные животные" > Animals
cat Animals
mv Animals mans_friends

```

2. Создать директорию, переместить файл туда.

```
mkdir zoo_System
mv mans_friends zoo_System
```

![Создание двух файлов с помощью команды `cat` и их перемещение в новую директорию](https://github.com/MoJIoToK/Control_work_on_the_specialization_block/blob/main/pic/1.png)

3. Подключить дополнительный репозиторий MySQL. Установить любой пакет
из этого репозитория.

```
sudo apt-get update
sudo wget https://dev.mysql.com/get/mysql-apt-config_0.8.23-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.23-1_all.deb
sudo apt-get update
sudo apt-get install mysql-server
```

![Подключение репозитория и установка пакета](https://github.com/MoJIoToK/Control_work_on_the_specialization_block/blob/main/pic/3..png)

4. Установить и удалить deb-пакет с помощью dpkg.

```
sudo wget http://ftp.us.debian.org/debian/pool/main/s/sl/sl_5.02-1_amd64.deb
sudo dpkg -i sl_5.02-1_amd64.deb
sudo dpkg -r sl
```

![Установка и удаления пакета](https://github.com/MoJIoToK/Control_work_on_the_specialization_block/blob/main/pic/4.%20install%20deb%20and%20delete.png)

5. Выложить историю команд в терминале ubuntu

```
history
```

![История](https://github.com/MoJIoToK/Control_work_on_the_specialization_block/blob/main/pic/history.png)

6. Нарисовать диаграмму, в которой есть класс родительский класс, домашние
животные и вьючные животные, в составы которых в случае домашних
животных войдут классы: собаки, кошки, хомяки, а в класс вьючные животные
войдут: Лошади, верблюды и ослы).

![Диаграмма](https://github.com/MoJIoToK/Control_work_on_the_specialization_block/blob/main/pic/Task6.png)

7. В подключенном MySQL репозитории создать базу данных “Друзья человека”.


```
create database Human_friends;
```

8. Создать таблицы с иерархией из диаграммы в БД

```
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
```

9. Заполнить низкоуровневые таблицы именами(животных), командами которые они выполняют и датами рождения

```
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
```

10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.

```
truncate table camels;

select name, birthday, commands from horses
union select name, birthday, commands from donkeys;
```

11. Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице.

```
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
```

12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.

```
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
```

13. Создать [класс с Инкапсуляцией методов и наследованием по диаграмме](https://github.com/MoJIoToK/Control_work_on_the_specialization_block/tree/main/Model).
14. Написать [программу, имитирующую работу реестра домашних животных](https://github.com/MoJIoToK/Control_work_on_the_specialization_block).

В программе должен быть реализован следующий функционал:
14.1. Завести новое животное
14.2. определять животное в правильный класс
14.3. увидеть список команд, которое выполняет животное
14.4. обучить животное новым командам
14.5. Реализовать навигацию по меню

15. Создайте класс [Счетчик](https://github.com/MoJIoToK/Control_work_on_the_specialization_block/blob/main/Controller/Counter.java), у которого есть метод add(), увеличивающий̆
значение внутренней̆int переменной̆на 1 при нажатие “Завести новое
животное” Сделайте так, чтобы с объектом такого типа можно было работать в
блоке try-with-resources. Нужно бросить исключение, если работа с объектом
типа счетчик была не в ресурсном try и/или ресурс остался открыт. Значение
считать в ресурсе try, если при заведения животного заполнены все поля.
