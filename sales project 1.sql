drop table if exists sales;
create table sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(10),
age INT,
category VARCHAR(15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

select * from sales;

select count(*) from sales;
select distinct count(customer_id) from sales;
select distinct category from sales;

select * from sales
where sale_date is null or sale_time is null
or customer_id is null or gender is null or age is null or category is null
or quantity is null or price_per_unit is null or cogs is null or total_sale is null;

delete from sales
where sale_date is null or sale_time is null
or customer_id is null or gender is null or age is null or category is null
or quantity is null or price_per_unit is null or cogs is null or total_sale is null;

select sale_date from sales
where sale_date = '2022-11-05';

select transactions_id from sales
where category = 'clothing' and 
quantity>=4 and
TO_CHAR(sale_date, 'YYYY-MM')='2022-11';

select category, sum(total_sale) from sales
group by category;

select avg(age) from sales
where category='Beauty';

select * from sales
where total_sale>1000;

select category, gender, count(*) from sales
group by category,gender;

select customer_id, total_sale from sales
order by total_sale desc
limit 5;

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM sales
GROUP BY category

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)

SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift