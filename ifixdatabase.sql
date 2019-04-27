CREATE database IF NOt exists ifix;
USE ifix;


CREATE TABLE if not exists staff (
emp_no INT NOT NULL,
first_name VARCHAR(14) NOT NULL,
last_name VARCHAR(16) NOT NULL,
phone_no varchar(14),
check(length(phone_no)>9),
title VARCHAR(20) NOT NULL,
sal_hour DECIMAL (4,2),
location_no varchar(5) NOT NULL,
PRIMARY KEY (emp_no),
foreign key(location_no) references location (l_id) ON DELETE cascade
);

CREATE TABLE IF NOT EXISTS location(
l_id varchar(5) NOT NULL,
address varchar(50) not null,
city varchar(20)  not null,
state char(2) not null,
phone_number varchar(15) not null,
primary key (l_id)

);

CREATE TABLE if not exists custumer (
c_number INT NOT NULL,
first_name VARCHAR(14) NOT NULL,
last_name VARCHAR(16) NOT NULL,
phone_no varchar(14),
emp_no int,
check(length(phone_no)>9),
PRIMARY KEY (c_number),
foreign key(emp_no) references staff (emp_no) ON DELETE SET NULL
);

CREATE TABLE if not exists product (
product_id varchar(7) NOT NULL,
service_type VARCHAR(14) NOT NULL,
price  decimal (5,2) NOT NULL,
phone_no varchar(14),
check(length(product_id)>9),
check (price>100),
PRIMARY KEY (product_id)
);

CREATE TABLE if not exists purchasing (
row_id int NOT null,
emp_no INT NOT NULL,
c_number INT NOT NULL,
product_id varchar(7),
purchase_date date not null,
primary key(row_id),
foreign key(emp_no) references staff(emp_no),
foreign key(product_id) references product(product_id),
foreign key(c_number) references custumer(c_number)

);
ALTER TABLE purchasing
CHANGE COLUMN row_id row_id INT NOT NULL AUTO_INCREMENT;


RENAME TABLE custumer TO customer;


ALTER TABLE product
DROP COLUMN phone_no;

CREATE VIEW employee AS
select PU.emp_no,s.first_name,s.last_name,sum(P.price) as total_made
from product P,purchasing PU,staff S
where P.product_id=PU.product_id AND PU.emp_no=S.emp_no 
group by PU.emp_no
order by sum(P.price) DESC;

select*
from employee

use ifix;
select count(s.emp_no),L.state,l.city
from staff s,location L
where s.location_no=L.l_id
group by s.location_no;
SELECT city,l_id
from location
where city="Baltimore";

select location_no,first_name,last_name,emp_no
from staff
where location_no=3;

select S.first_name,S.last_name, PU.emp_no as employee,count(P.product_id) as total_sale,sum(P.price) as total_made,S.title
from product P,purchasing PU,staff S
where P.product_id=PU.product_id AND PU.emp_no=S.emp_no
group by PU.emp_no
order by total_made DESC;

select PU.emp_no,s.first_name,s.last_name,sum(P.price) as total_made
from product P,purchasing PU,staff S
where P.product_id=PU.product_id AND PU.emp_no=S.emp_no 
group by PU.emp_no
order by sum(P.price) DESC;

SELECT S.first_name,S.last_name,L.city, L.l_id,L.state,S.title
from staff S,location L
where L.l_id=S.location_no AND  S.title='manager'
order by L.l_id;
SELECT *
from staff;

SELECT L.city,sum(P.price) as money_made
from location L,product P,purchasing PU,staff S
where L.l_id=S.location_no AND PU.emp_no=S.emp_no AND PU.product_id=P.product_id
group by L.city;

select purchase_date
from purchasing;

SELECT *
FROM product;

select *
from staff









