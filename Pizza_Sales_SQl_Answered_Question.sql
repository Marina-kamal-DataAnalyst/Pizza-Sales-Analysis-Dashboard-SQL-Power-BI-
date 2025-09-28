Create Database pizza_sales

use  pizza_sales

Select * from [pizza_sales].[dbo].[pizza_sales_Table]



--1 total_revenue

create view total_revenue as 
select sum(total_price) as total_revenue from pizza_sales_Table -- for power bi 

select * from total_revenue -- for run view( total_revenue_table)

--2 avg_order_value

drop view avg_order_value

create view avg_order_value as 

SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_sales_table;

select * from avg_order_value

--3 total_pizza_sold
select * from pizza_sales_Table

drop view total_pizza_sold

create view total_pizza_sold as
select count(pizza_id)   as total_pizza_sold from pizza_sales_Table;


;

----------------------------------------------------------------------------------------------------
select * from total_revenue ;
select * from total_pizza_sold ;
select * from avg_order_value ;
create view test as 
select SUM(quantity) as total_quantity , sum(total_price) as price from pizza_sales_Table ;
---------------------------------------------------------------------------------------------------

--4 total orders 
select * from pizza_sales_Table
create view total_orders as
select count(distinct order_id ) as total_orders from pizza_sales_Table

select * from total_orders

--5 average pizza per orders
CREATE VIEW average_pizza_per_order as 
select cast(
cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) AS decimal(10,2)) 
as average_pizza_per_orders from pizza_sales_Table ;

--6 Daily_Trend_for_Total_orders 
 CREATE VIEW Daily_Trend_for_Total_orders as
 select DATENAME(DW , order_date ) as day_name , count(distinct order_id) as Total_orders
 from pizza_sales_Table group by Datename(DW , order_date ) 

 --7 Monthly_Trend_For_orders
  CREATE VIEW Monthly_Trend_for_Total_orders as
  
  select DATENAME(MONTH,order_date) as month_name , count(distinct order_id) as total_orders  , MONTH(order_date) as month_number
  from pizza_sales_Table group by DATENAME(MONTH,order_date)  , MONTH(order_date) 
   select * from Monthly_Trend_for_Total_orders

   --8 % of sales by pizza category 
create view SALES_PER_BY_PIZZA_CATEGORY AS
   SELECT 
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(
        (SUM(total_price) * 100.0) / 
        (SELECT SUM(total_price) FROM pizza_sales_Table)
        AS DECIMAL(10,2)
    ) AS pct
FROM pizza_sales_Table
GROUP BY pizza_category;

select * from  SALES_PER_BY_PIZZA_CATEGORY  order by pct desc 


   --9 % of sales by pizza Size  
   create view SALES_PER_BY_PIZZA_Sizes AS
   select pizza_size , cast(sum(total_price) as decimal(10,2)) as total_revenue ,
   cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales_Table) as decimal(10,2))
  as PCT from  pizza_sales_Table 
  Group by pizza_size 

select * from  SALES_PER_BY_PIZZA_Sizes  order by pct desc

--10 Top 5 pizzas by Revenue
select top 10 * from pizza_sales_Table

create view top_5_pizza_by_revenue AS
select top 5 pizza_name , sum(total_price) as Total_Revenue
from pizza_sales_Table 
group by   pizza_name 

select * from top_5_pizza_by_revenue order by Total_Revenue desc

--11 Top 5 pizzas by Quantity
drop view top_5_pizza_by_quantity
create view top_5_pizza_by_quantity AS
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales_Table
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;



 
 --11 Bottom 5 pizzas by Quantity

create view bottom_5_pizza_by_quantity AS
SELECT top 5
    pizza_name,
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales_Table
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold asc;

--12 Top 5 pizzas by Quantity

create view Top_5_pizza_by_Total_Orders AS
SELECT top 5
    pizza_name,
    count(distinct order_id) AS Total_Orders
FROM pizza_sales_Table
GROUP BY pizza_name
ORDER BY Total_Orders desc;


--13 Bottom pizzas by Quantity

create view Bottom_5_pizza_by_Total_Orders AS
SELECT top 5
    pizza_name,
    count(distinct order_id) AS Total_Orders
FROM pizza_sales_Table
GROUP BY pizza_name
ORDER BY Total_Orders asc;




 

