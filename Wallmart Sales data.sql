create database salesdatawallmart;
use salesdatawallmart;
create table sales
(
invoice_id varchar(30) not null primary key,
branch varchar(5) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(10) not null,
product_line varchar(100) not null,
unit_price decimal(10,2) not null,
quantity int not null,
vat float(6,4) not null,
total decimal(12,4) not null,
date datetime not null,
time time not null,
payment_method varchar(15) not null,
cogs decimal(10,2) not null,
gross_margin_pct float(11,9),
gross_income decimal(12,4) not null,
rating float(2,1) 
);

 show tables;

insert into sales(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time, payment_method, cogs, gross_margin_pct, gross_income, rating)
values('123-456', 'A','kochi','new','male',	'health','12.21','7', '18.7','223456',	'2019-03-12','13:08:00','cash','5.89',	'4.233344478',	'12.2356',	'9.2')
insert into sales(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time, payment_method, cogs, gross_margin_pct, gross_income, rating)
values('234-345','C','tvm',	'loyal','female','beauty','45.89','8','18.7','445667','2019-02-06',	'12:20:00',	'creditcard','6.88','4.233344478','10.678',	'4.5');
insert into sales(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time, payment_method, cogs, gross_margin_pct, gross_income, rating)
values('567-678','A','kochi','impulse',	'male',	'electronics','34.67','9',	'12','678905','2019-04-30','18:45:00',	'e-wallet',	'9.77',	'4.233344478','45.567',	'5.6');
insert into sales(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time, payment_method, cogs, gross_margin_pct, gross_income, rating)
values('689-890','B','kozhikode','angry','female','home','13.67','4','12','234890',	'2019-05-24','12:14:00','cash',	'2.55','4.233344478','14.3456',	'7.8');
insert into sales(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time, payment_method, cogs, gross_margin_pct, gross_income, rating)
values('256-790','B','kozhikode','new',	'male', 'food',	'89.91','3','14','456789','2019-07-10',	'19:30:00',	'creditcard','3.67','4.233344478','78.8907','8.9');
insert into sales(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time, payment_method, cogs, gross_margin_pct, gross_income, rating)
values('145-278','A','kochi','loyal','female','beauty',	'11.25','5','16','789901','2019-02-22','20:50:00','e-wallet','4.75','4.233344478','48.3678','5.8');
insert into sales(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time, payment_method, cogs, gross_margin_pct, gross_income, rating)
values('543-876','C','tvm',	'impulse','male','food','24.32','2','18','257678','2019-06-20',	'14:23:00',	'cash',	'5.44',	'4.233344478','50.1245','2.4')
insert into sales(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time, payment_method, cogs, gross_margin_pct, gross_income, rating)
values('763-240','C','tvm','angry',	'female','electronics','67.23','6','18','245368','2019-08-18','15:35:00','creditcard','7.66','4.233344478','26.3895','3.1');

select * from salesdatawallmart.sales;

-- time_of_day
select time from sales;
select time,
(case when 'time' between "00:00:00" and "12:00::00" then "Morning"
when 'time' between "12:01:00" and "16:00::00" then "Afternoon"
else "Evening"
end
) As time_of_date from sales;

alter table sales add column time_of_day varchar(20);
update sales
set time_of_day = (case when 'time' between "00:00:00" and "12:00::00" then "Morning"
when 'time' between "12:01:00" and "16:00::00" then "Afternoon"
else "Evening"
end
);

-- day_name
alter table sales add column day_name varchar(10);
update sales
set day_name = (case when 'day_name' then "Monday"
when 'day_name' then "Tuesday"
when 'day_name' then "Wednesday"
when 'day_name' then "Thursday"
when 'day_name' then "Friday"
when 'day_name' then "Saturday"
else "Sunday"
end
);

-- how many unique cities does the data have?
select distinct city from sales;

-- in which city is each branch?
select distinct branch from sales;

select distinct city, branch from sales;
-- how many unique product lines does the data have?
SELECT
	DISTINCT product_line
FROM sales;

-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;

-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(gross_margin_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT 
	AVG(quantity) AS avg_qnty
FROM sales;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM sales
GROUP BY product_line;

-- Which branch sold more products than average product sold?
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment_method
FROM sales;

-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day.
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city has the largest tax/VAT percent?
SELECT
	city,
    ROUND(AVG(vat), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	AVG(vat) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;

-- --------------------------------------------------------------------
-- -------------------------------------------------------------------