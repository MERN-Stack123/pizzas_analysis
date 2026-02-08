/*================ exploratory data analysis ============*/


	/*================ Univariate ============*/
		/*================ total orders ============*/
		select count(distinct order_id) astotal_orders
			from pizza_sales;


		/*================ total revenue ============*/
		select round(sum(total_price), 2) as total_revenue
			from pizza_sales;


		/*================ pizza category distribution ============*/
		select pizza_category, count(*) as total_orders
			from pizza_sales
			group by pizza_category
			order by total_orders desc;


		/*================ pizza size distribution ============*/
		select pizza_size, sum(quantity) as total_quantity
			from pizza_sales
			group by pizza_size
			order by total_quantity desc;


		/*================ top 10 pizzas(by quantity) ============*/
		select top 10 pizza_name,
			sum(quantity) as total_sold
			from pizza_sales
			group by pizza_name
			order by total_sold desc;


	/*================ bivariate analysis ============*/
		/*================ revenue by pizza category ============*/
		select pizza_category,
			round(sum(total_price), 2) as revenue
			from pizza_sales
			group by pizza_category
			order by revenue desc;


		/*================ revenue by pizza size ============*/
		select pizza_size,
			round(sum(total_price), 2) as revenue
			from pizza_sales
			group by pizza_size
			order by revenue desc;


		/*================ order by day of week ============*/
		select
			datename(weekday, order_date) as day_name,
			count(distinct order_id) as total_orders
			from pizza_sales
			group by datename(weekday, order_date)
			order by total_orders desc;


		/*================ order by hour(peak time analysis) ============*/
		select
			datepart(hour, order_time) as hour,
			count(distinct order_id) as total_orders
			from pizza_sales
			group by datepart(hour, order_time)
			order by total_orders desc;


	/*================ multivariate analysis ============*/
		/*================ category + size + revenue ============*/
		select pizza_category,
			pizza_size,
			round(sum(total_price), 2) as revenue
			from pizza_sales
			group by pizza_category, pizza_size
			order by revenue desc;


		/*================ top pizza per category ============*/
		select pizza_category,
			pizza_name,
	  		sum(quantity) as total_sold
			from pizza_sales
			group by pizza_category, pizza_name
			order by pizza_category, total_sold desc;


		/*================ daily revenue trend ============*/
		select order_date,
			cast(sum(total_price) as decimal(10,2)) as daily_revenue,
			count(distinct order_id) as total_orders
			from pizza_sales
			group by order_date
			order by order_date;


		/*================ monthly revenue trend ============*/
		select
			datename(month, order_date) as month_name,
			datepart(month, order_date) as month_no,
			cast(sum(total_price) as decimal(10,2)) as revenue
		from pizza_sales
		group by datename(month, order_date), datepart(month, order_date)
		order by month_no;


		/*================ average order value ============*/
		select
		    cast(sum(total_price) / count(distinct order_id) as decimal(10,2)) as avg_order_value
			from pizza_sales;


		/*================ bottom 5 pizzas (by quantity) ============*/
		select top 5
			pizza_name,
			sum(quantity) as total_sold
		from pizza_sales
		group by pizza_name
		order by total_sold asc;


		/*================ category revenue contribution (%) ============*/
		select
			pizza_category,
			cast(
				sum(total_price) * 100.0 /
				(select sum(total_price) from pizza_sales)
				as decimal(5,2)
			) as revenue_percentage
		from pizza_sales
		group by pizza_category
		order by revenue_percentage desc;
