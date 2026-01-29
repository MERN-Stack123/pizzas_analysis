/*================ kpi's ============*/
	select
        count(distinct order_id) as total_orders,
        sum(quantity) as total_pizzas_sold,
        cast(sum(total_price) as decimal(10,2)) as total_revenue,
        cast(sum(total_price) / count(distinct order_id)as decimal(10,2)) as avg_order_value
        from pizza_sales;


/*================ category-wise performance ============*/
    select pizza_category,
       sum(quantity) as pizzas_sold,
       cast(sum(total_price) as decimal(10,2)) as revenue
       from pizza_sales
       group by pizza_category;

/*================ best & worst performing pizzas ============*/
    select pizza_name,
       sum(quantity) as total_sold,
       cast(sum(total_price) as decimal(10,2)) as revenue
       from pizza_sales
       group by pizza_name
       order by revenue desc;


/*================ time-based insights ============*/
    select
        datename(weekday, order_date) as day,
        datepart(hour, order_time) AS hour,
        count(order_id) as orders
        from pizza_sales
        group by 
            datename(weekday, order_date),
            datepart(hour, order_time)
        order by orders desc;
