-- BASICS

CREATE DATABASE pizzahut;

SELECT * FROM pizzas;

SELECT * FROM orders;

ALTER TABLE orders MODIFY column date DATE;



SELECT * FROM  pizza_types;

CREATE TABLE orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));


SELECT * from orders;

CREATE TABLE order_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id));


select * from order_details;

-- Retrive the total number of orders placed

SELECT count(order_id) as total_orders from orders;

-- CALCULATE the total revenue generated  from pizza sales
SELECT 
round(sum(order_details.quantity * pizzas.price),2)as total_sales 
from order_details 
join pizzas 
on pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza
SELECT pizza_types.name , pizzas.price
FROM pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- Identify the most  common pizza size ordered..

SELECT pizzas.size ,  count(order_details.order_details_id)
FROM pizzas JOIN order_details
ON
pizzas.pizza_id = order_details.pizza_id
GROUP BY size order by count(order_details.order_details_id) DESC ;

-- LIST THE TOP 5 MOST ORDERED PIZZA TYPE ALONG WITH THEIR QUANTITES

SELECT * FROM order_details;

SELECT * FROM pizza_types;

SELECT pizza_types.name ,
SUM(order_details.quantity) AS quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5 ;

-- INTERMEDIATE 
 -- JOIN  THE NECESSARY TABLES TO  FIND  THE TOTAL QUANTITY  OF EACH PIZZA ORDERED
 SELECT * FROM order_details;
 SELECT * FROM pizzas;
 select * from pizza_types;
 
 SELECT pizza_types.category,
 SUM(order_details.quantity) as quantity
 FROM pizza_types JOIN pizzas
 ON pizza_types.pizza_type_id = pizzas.pizza_type_id
 JOIN order_details
 ON order_details.pizza_id = pizzas.pizza_id
 GROUP BY pizza_types.category
 ORDER BY quantity DESC;
 
 
 -- Determine the distribution of orders by hour of the day
 
 SELECT  HOUR(order_time) AS hour , COUNT(order_id) AS order_count
 FROM orders
 GROUP BY HOUR(order_time);
 
 
-- JOIN relevant tables to find the category-wise distribution of pizzas

SELECT category , count(name) from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day

SELECT round(avg(total),0) AS avg_pizza from 
(SELECT orders.order_date , SUM(order_details.quantity) AS total
FROM orders JOIN order_details
ON orders.order_id =  order_details.order_id
GROUP BY orders.order_date
ORDER BY total DESC) as total_order_per_day;


-- DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES BASED ON REVENUE

select * from pizza_types;

select * from order_details;

select * from pizzas;

SELECT pizza_types.name , SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types join pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue desc limit 3;

-- ADVANCED
-- CALCULATE THE PERCENTAGE CONTRIBUTION OF EACH PIZZA TYPE TO TOTAL REVENUE


SELECT pizza_types.category, round(SUM(order_details.quantity*pizzas.price)/(SELECT 
ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_sales
FROM
order_details
join
pizzas on pizzas.pizza_id = order_details.pizza_id)*100,2) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by revenue desc;

-- Analyze the cumulative revenue generated over time

select order_date, ROUND(sum(revenue) over(order by order_date),0) as cum_revenue
FROM
(SELECT  orders.order_date, SUM(order_details.quantity * pizzas.price)AS revenue
from order_details  join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as sales;



-- DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES
-- BASED ON REVENUE FOR EACH PIZZA CATEGORY


SELECT name 
,revenue from
(select category , name , revenue, rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category,pizza_types.name,
SUM((order_details.quantity) * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on
order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category , pizza_types.name) as a) as b
where rn <= 3 order by revenue desc limit 3;







