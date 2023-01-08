--1. List all customers who live in Texas (use JOINs)
select * from address;
select * from customer;

select customer.first_name, customer.last_name, address.district
from customer
full join address
on customer.address_id = address.address_id
where address.district = 'Texas';
--ANSWER: listed


--2. Get all payments above $6.99 with the Customer's Full Name
select first_name, last_name, payment.amount
from customer
full join payment
on customer.customer_id = payment.customer_id
where payment.amount > 6.99;
-- ANSWER: gotten



--3. Show all customers names who have made payments over $175(use subqueries)
select * from customer;
select * from payment;

select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
	order by sum(amount) desc
);
--ANSWER: shown


--4. List all customers that live in Nepal (use the city table)
select * from city;
select * from country;
select * from address;
select * from customer;

select first_name, last_name, customer.address_id, address.address_id, address.city_id, city.city_id, country.country_id, country.country
from customer
full join address
on address.address_id = customer.address_id
full join city
on city.city_id = address.city_id
full join country
on country.country_id = city.city_id
where country.country = 'Nepal';
--ANSWER: Nicholas Barfield


--5. Which staff member had the most transactions?
select * from payment;
select * from staff;


select staff_id, count(staff_id)
from payment
group by staff_id
order by count(staff_id) desc; 
--ANSWER: Jon Stephens


--6. How many movies of each rating are there?
select * from film;

select rating, count(rating) 
from film
group by rating order by count(rating);
--ANSWER: G - 178, PG - 194, R - 195, NC-17 - 209, PG-13 - 223



--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select customer_id, amount, count(customer_id)
from payment
where payment.amount > 6.99
group by customer_id, amount
having count(customer_id) = 1
order by customer_id;
--

select first_name, last_name, payment.amount, count(amount)
from customer
inner join payment
on customer.customer_id = payment.customer_id 
where payment.amount > 6.99
group by customer.customer_id, payment.amount
having count(amount) = 1
order by payment.amount;
--PRELIMINARY ANSWER: 1043 using both the above methods, but still don't think I am doing this right

select customer_id, amount
from payment
where amount > 6.99 and customer_id in (
	select count(customer_id)
	from payment
	group by customer_id
)
group by customer_id, amount
order by customer_id;
--119...? still not right, see below for what I am TRYING to do...

select customer_id, amount, count(customer_id)
from payment
where payment.amount > 6.99 and customer_id in (
--	in here I want to select a subset of the outer table that includes only rows showing a customer_id that appears only once in the outer table
)
group by customer_id, amount
having count(customer_id) = 1
order by customer_id;


--8. How many free rentals did our stores give away?
select * from rental;
select * from payment;

select count(rental.rental_id)
from rental
left join payment
on rental.rental_id = payment.rental_id
where payment.rental_id is null;

select count(rental_id)
from rental
where rental_id not in (
	select rental_id  
	from payment
);
--ANSWER = 1452 with both methods but again not sure i'm doing this right

select count(amount)
from payment
where amount = 0;
--ANSWER: 0


