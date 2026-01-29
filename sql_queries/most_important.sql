/*================ average order value ============*/
    select
        cast(sum(total_price) / count(distinct order_id) as decimal(10,2)) as avg_order_value
    from pizza_sales;


/*================ average pizzas per order ============*/
    select
        cast(sum(quantity) / count(distinct order_id) as decimal(10,2)) as avg_pizzas_per_order
        from pizza_sales;


/*================ revenue contirbution % ============*/
    select
        pizza_name,
        round(sum(total_price), 2) as revenue,
        cast(
            sum(total_price) * 100.0 /
            (select sum(total_price) from pizza_sales) as decimal(10,2)) 
            as revenue_pct
        from pizza_sales
        group by pizza_name
        order by revenue desc;


/*================ cumulative revenue(running total) ============*/
    select
        pizza_name,
        cast(sum(total_price) as decimal(10,2)) as revenue,
        cast(sum(sum(total_price)) over(
            order by sum(total_price) desc
        ) as decimal(10,2)) as cumulative_revenue
        from pizza_sales
        group by pizza_name;



/*================ low performing pizzas ============*/
    select
        pizza_name,
        sum(quantity) as total_sold,
        cast(sum(total_price) as decimal(10,2)) as revenue
        from pizza_sales
        group by pizza_name
        having sum(quantity) < 100 
        and 
        cast(sum(total_price) as decimal(10,2)) < 500
        order by revenue;


/*================ high value orders ============*/
    select
        order_id,
        cast(sum(total_price) as decimal(10,2)) as order_value
        from pizza_sales
        group by order_id
        having cast(sum(total_price) as decimal(10,2)) >
        (select avg(total_price) from pizza_sales)
        order by order_value desc;

