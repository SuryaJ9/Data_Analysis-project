-- List the top 5 most ordered pizza types along with their quantities.
-- Analysing how to appproach problem statement(Ctrl B) for beautify
SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantities
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantities DESC
LIMIT 5;

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

-- select * from order_details;


-- Determine the distribution of orders by hour of the day.
