
-- Join the necessary tables to find the total quantity of each pizza category ordered
SELECT 
    pizza_types.category, SUM(order_details.quantity) as tot_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
group by pizza_types.category, order_details.quantity;


-- Determine the distribution of orders by hour of the day.

select hour(time),count(order_id) from orders
group by hour(time);

-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) as cnt from pizza_types
group by category
order by cnt DESC;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select date(orders.date) as Date,order_details.quantity 
from orders join order_details
on orders.order_id = order_details.order_id
group by date;

-- Group the orders by date and 
-- calculate the average number of pizzas ordered per day.
select date(date),round(avg(order_id),0) as avg_per_day from orders
group by date(date);

select * from orders;

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name, sum(order_details.quantity * pizzas.price) as revenue
 from pizza_types
join pizzas on
pizzas.pizza_type_id = pizza_types.pizza_type_id
join  
order_details on
order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by revenue desc
limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

with revenue_data AS(
select pizza_types.name as pizza_type,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
),
total as (
select sum(revenue) as total_revenue from revenue_data
),
average as (
select avg(revenue) as total_average from revenue_data
)
select 
rd.pizza_type,
rd.revenue,
round(ag.total_average,0) as avg,
round((rd.revenue / t.total_revenue) * 100,2)
as percentage
from revenue_data rd, total t, average ag
order by rd.revenue DESC; 

-- Medium Level
-- Analyze the cumulative revenue generated over time.
select time,sum(revenue) over(order by time) as cum_revenue
from
(select hour(orders.time) as time, 
sum(order_details.quantity * pizzas.price) as revenue
from order_details 
join
pizzas on pizzas.pizza_id = order_details.pizza_id
join
orders on orders.order_id = order_details.order_id
group by time) as sales;

-- Determine the top 3 most ordered pizza types
-- based on revenue for each pizza category

SELECT 
    pizza_types.category AS category,
    pizza_types.name AS name,
    SUM(pizzas.price * order_details.quantity) AS revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category , pizza_types.name
ORDER BY revenue DESC
limit 3;
