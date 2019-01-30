use sakila;

select first_name, last_name 
from actor;

Select concat(first_name, ' ', last_name) as 'Actor Name' from actor;

select first_name, last_name, actor_id
from actor
where first_name = 'Joe';

select first_name, last_name, actor_id
from actor
where last_name like '%GEN%';

select last_name, first_name, actor_id
from actor
where last_name like '$LI$';

select country, country_id
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

alter table actor add description blob;

alter table actor drop description;

select last_name, count(*) as 'actor name count' 
from actor 
group by last_name;

select last_name, count(*) as 'multiple name count' 
from actor 
group by last_name having count(*) > 1;

update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

update actor
set first_name = 'GROUCHO'
where first_name = 'HARPO' and last_name = 'WILLIAMS';

select * from address;

create table address (
address_id smallint(5) auto_increment not null,
address varchar(100),
address2 varchar(100) default null,
district varchar(100),
city_id smallint(5),
postal_code integer(10),
phone integer(10),
location blob,
last_update datetime,
primary key(address_id));

select first_name, last_name, address
from staff s
inner join address a
on s.address_id = a.address_id;

select first_name, last_name, amount
from staff s
inner join payment p
on s.staff_id = p.staff_id
where payment_date between '2005-08-01' and '2005-08-31'
group by s.staff_id;

select title, count(actor_id)
from film f
inner join film_actor i
on f.film_id = i.film_id
group by f.film_id;

select title as 'Film', count(inventory_id) as 'Number of Copies'
from film f
inner join inventory n
on f.film_id = n.film_id
where title = 'Hunchback Impossible'
group by f.film_id;

select first_name, last_name, sum(amount) as 'Total Amount Paid'
from customer c
inner join payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by last_name asc;

select title from film
where language_id in(select language_id 
from language where name = 'English')
and (title like 'K%') or (title like 'Q%');

Select concat(first_name, ' ', last_name) as 'Names of Actors in Alone Trip' 
from actor
where actor_id in(select actor_id from film_actor
where film_id in(select film_id from film where title = 'Alone Trip'));

select first_name, last_name, email
from customer
inner join address
using (address_id)
inner join city
using (city_id)
inner join country
using (country_id) where country.country = 'Canada';
        
select title, name
from film 
inner join film_category
using (film_id)
inner join category
using (category_id) where category.name = 'Family';

select film.title, count(film.title) as 'Times Rented'
from rental 
inner join inventory 
on rental.inventory_id = inventory.inventory_id
inner join film 
on inventory.film_id = film.film_id
group by film.title
order by times_rented desc;

select store.store_id, sum(amount)
from store
inner join staff
on store.store_id = staff.store_id
inner join payment  
on payment.staff_id = staff.staff_id
group by store.store_id
order by sum(amount);

select store_id, city, country
from store
inner join address
on store.address_id = address.address_id
inner join city
on address.city_id = city.city_id
inner join country
on city.country_id = country.country_id
group by store_id;

select c.name as 'Film', sum(p.amount) as 'Total Revenue'
from category as c
join film_category as fc on fc.category_id = c.category_id
join inventory as i on i.film_id = fc.film_id
join rental as r on r.inventory_id = i.inventory_id
join payment as p on p.rental_id = r.rental_id
group by c.name
order by sum(p.amount) desc
limit 5;

create view top_5_genre_revenue as 
	SELECT c.name as 'Film', sum(p.amount) as 'Total Revenue'
	from category as c
	join film_category as fc on fc.category_id = c.category_id
	join inventory as i on i.film_id = fc.film_id
	join rental as r on r.inventory_id = i.inventory_id
	join payment as p on p.rental_id = r.rental_id
	group by c.name
	order by sum(p.amount) desc
	limit 5;
    
select * from top_5_genre_revenue;

drop view top_5_genre_revenue;