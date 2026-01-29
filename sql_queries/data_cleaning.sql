/*================ using database ============*/
use PizzaSalesDB;


/*================ featching data's ============*/
select * from pizza_sales;


/*================ checking null values ============*/
select
	sum(case when order_id is null then 1 else 0 end) as order_id_nulls,
	sum(case when pizza_id is null then 1 else 0 end) as pizza_id_nulls,
	sum(case when quantity is null then 1 else 0 end) as quantity_nulls,
	sum(case when order_date is null then 1 else 0 end) as order_date_nulls,
	sum(case when order_time is null then 1 else 0 end) as order_time_nulls,
	sum(case when unit_price is null then 1 else 0 end) as unit_price_nulls,
	sum(case when total_price is null then 1 else 0 end) as total_price_nulls,
	sum(case when pizza_size is null then 1 else 0 end) as pizza_size_nulls,
	sum(case when pizza_category is null then 1 else 0 end) as pizza_category_nulls,
	sum(case when pizza_ingredients is null then 1 else 0 end) as pizza_ingredients,
	sum(case when pizza_name is null then 1 else 0 end) as pizza_name
from pizza_sales;


/*================ remove duplicate's ============*/
select  count(*), order_id, pizza_name
	from pizza_sales
	group by order_id, pizza_name
	having count(*) > 1;


/*================ data types validations ============*/
select
    min(order_date) as min_date,
    max(order_date) as max_date,
    min(quantity) as min_qty,
    max(quantity) as max_qty,
    min(total_price) as min_price,
    max(total_price) as max_price
from pizza_sales;


/*================ invalid/negative values ============*/
select *
	from pizza_sales
	where quantity <= 0 OR total_price <= 0;