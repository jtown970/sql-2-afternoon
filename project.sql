--PART 1 JOINS
-- 1:
select * from invoice
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
where invoice_line.unit_price > 0.99;

--2 
select i.invoice_date, c.first_name, c.last_name, i.total from invoice i
join customer c on i.customer_id = c.customer_id;

--3
select c.first_name, c.last_name, e.first_name, e.last_name 
from customer c
join employee e on c.support_rep_id = e.employee_id;

--4
select al.title, ar.name
from album al
join artist ar on al.artist_id = ar.artist_id;

--5
select pt.track_id
from playlist_track pt
join playlist p on p.playlist_id = pt.playlist_track_id
where p.name = 'Music';

--6
select t.name
from track t
join playlist_track pt on pt.track_id = t.track_id
where pt.playlist_id =5;

--7
select t.name, p.name
from track t
join playlist_track pt on pt.track_id = t.track_id
join playlist p on pt.playlist_id = p.playlist_id;

--8
select t.name, a.title
from track t 
join album a on t.album_id = a.album_id
join genre g on g.genre_id = t.genre_id
where g.name = 'Alternative & Punk';


--PART 2 NESTED QUERIES
--1
select * from invoice
where invoice_id in (select invoice_id 
                     from invoice_line 
                     where unit_price > 0.99);

--2
select * from playlist_track
where playlist_id in (select playlist_id from playlist
                      where name = 'Music');

--3
select name from track
where track_id in (select track_id from playlist_track 
                   where playlist_id = 5);

--4
select * from track
where genre_id in (select genre_id from genre
                   where name = 'Comedy');

--5
select * from track
where album_id in (select album_id from album 
                   where title = 'Fireball');

--6
select * from track
where album_id in (select album_id from album
                   where artist_id in (select artist_id from artist
                                       where name = 'Queen'));


--PART 3 UPDATING ROWS
--1
update customer
set fax = null
where fax is not null

--2
update customer
set company = 'Self'
where company is null

--3
update customer
set last_name = 'Thompson'
where first_name = 'Julia' and last_name = 'Barnett'

--4
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl'

--5
update track
set composer = 'The darkness around us'
where genre_id = (select genre_id from genre 
                  where name = 'Metal')
									and composer is null




-- PART 4 GROUP BY
--1
select count(*), g.name from track t
join genre g on t.genre_id = g.genre_id
group by g.name;

--2
select count(*), g.name from track t
join genre g on g.genre_id = t.genre_id
where g.name = 'Pop' or g.name = 'Rock'
group by g.name;

--3
select ar.name, count(*) from album al
join artist ar on ar.artist_id = al.artist_id
group by ar.name;



--PART 5 DISTINCT
--1
select distinct composer from track

--2
select distinct billing_postal_code from invoice

--3
select distinct company from customer


--PART 6 DELETE ROWS
--1
DELETE 
FROM practice_delete 
WHERE type = 'bronze';

--2
DELETE 
FROM practice_delete 
WHERE type = 'silver';

--3
DELETE 
FROM practice_delete 
WHERE value = 150;

--ECOMMERCE 

--1
create table users(
  user_id serial primary key,
  name text,
  email text
 );
create table product(
  product_id serial primary key,
  name text,
  price int
 );
create table orders(
  order_id serial primary key,
  product_id integer references product(product_id),
  user_id integer references users(user_id)
 );

 --2 make data to work with
insert into users(name, email)
values ('Jason', 'testemail@gmail.com');
insert into users(name, email)
values ('Cole', 'realemail@gmail.com');
insert into users(name, email)
values ('Drew', 'drewsemail@gmail.com');

insert into product(name, price)
values ('headphones', 100.00);
insert into product(name, price)
values ('coffee', 5.00);
 insert into product(name, price)
values ('backpack', 40.00);

insert into orders(product_id, user_id)
values 1, 1;
insert into orders(product_id, user_id)
values 2, 2;
insert into orders(product_id, user_id)
values 3, 3;

--3
select product_id from orders
where order_id = 1;

select * from orders

select sum(product_id) from orders
where order_id = 1
