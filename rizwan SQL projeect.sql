select * from  rizwan;

-- 			______________________Generic Questions:_____________________________
-- 1. How many unique cities does the data have?
select distinct City from walmart_sales_data;

-- 2. In which city is each branch?
select Branch,City from walmart_sales_data
group by Branch,City;

-- 3. How many unique product lines does the data have?
select distinct `Product line` from walmart_sales_data;

-- 4. What is the most common payment method?
select Payment,count(Payment) 
from walmart_sales_data
group by Payment
order by Payment desc limit 1;

-- 5. What is the most selling product line?
select `Product line`,count(Quantity) 
from walmart_sales_data
group by `Product line`
order by `Product line` desc limit 1;

-- 6. What is the total revenue by month?
select extract(year_month from Date) as month,
       round(sum(`gross income`), 2) as total_revenue
from walmart_sales_data
group by month
order by month;

-- 7. What month had the largest COGS?
select extract(year_month from Date) as month,
       max(cogs) as largest_cogs
from walmart_sales_data
group by month
order by largest_cogs desc limit 1;   

-- 8. What product line had the largest revenue?
select `Product line`,round(sum(`gross income`),2) larg_revenue 
from walmart_sales_data
group by `Product line`
order by larg_revenue desc limit 1;

-- 9. What is the city with the largest revenue?
select City,round(sum(`gross income`),2) larg_revenue 
from walmart_sales_data
group by City
order by larg_revenue desc limit 1;

-- 10. What product line had the largest VAT?
select `Product line`,round(sum(`Tax 5%`),2) larg_vat 
from walmart_sales_data
group by `Product line`
order by larg_vat desc limit 1;

-- 11. Fetch each product line and add a column to those product line showing 
-- "Good", "Bad". Good if its greater than average sales?
SELECT `Product line`,cogs,
CASE
	WHEN cogs > avg_sales THEN 'Good'
	ELSE 'Bad'
	END AS sales_category
    
FROM (SELECT `Product line`,cogs,AVG(cogs) 
      OVER (PARTITION BY `Product line`) AS avg_sales
      FROM walmart_sales_data) AS subquery
ORDER BY `Product line`, cogs;

-- 12. Which branch sold more products than average product sold?
SELECT branch,total_products_sold,
    CASE
        WHEN total_products_sold > avg_products THEN 'Above Average'
        ELSE 'Below or Equal to Average'
    END AS sales_category
FROM
    (SELECT branch,
        COUNT(`Product line`) AS total_products_sold,
        AVG(COUNT(`Product line`)) OVER () AS avg_products
FROM walmart_sales_data
GROUP BY branch) AS subquery
ORDER BY branch;

-- 13. What is the most common product line by gender?
select `Product line`,gender,count(`Product line`) as count_Pro
from walmart_sales_data
group by `Product line`,gender
order by count_Pro desc limit 1;

-- 14. What is the average rating of each product line?
select `Product line`, round(avg(rating),2) average_rat 
from walmart_sales_data
group by `Product line`
order by average_rat;

-- 15. Number of sales made in each time of the day per weekday?
SELECT
    DAYNAME(date) AS weekday,
    EXTRACT(HOUR FROM time) AS hour_of_day,
    COUNT(*) AS total_sales
FROM walmart_sales_data
GROUP BY
    weekday, hour_of_day
ORDER BY
    weekday, hour_of_day;

-- 16. Which of the customer types brings the most revenue?
select `Customer type`,round(sum(`gross income`),2) most_revenue
from walmart_sales_data
group by `Customer type`
order by most_revenue desc limit 1;
 
-- 17. Which city has the largest tax percent/ VAT (Value Added Tax)?
select City, sum(`Tax 5%`) as largest_tp from walmart_sales_data
group by city
order by largest_tp desc limit 1;

-- 18. Which customer type pays the most in VAT?
select `Customer type`,sum(`Tax 5%`) most_VAT
from walmart_sales_data
group by `Customer type`-- payment
order by most_VAT desc limit 1;

-- 19. How many unique customer types does the data have?
select distinct `Customer type` from walmart_sales_data;

-- 20. How many unique payment methods does the data have?
select distinct payment from walmart_sales_data;

-- 21. What is the most common customer type?
select `Customer type`,count(*) total_count
from walmart_sales_data
group by `Customer type`
order by total_count desc limit 1;

-- 22. Which customer type buys the most?
select `Customer type`,round(sum(cogs),2) total_buy
from walmart_sales_data
group by `Customer type`
order by total_buy desc limit 1;

-- 23. What is the gender of most of the customers?
select gender,count(*),max(`Customer type`) cust_type
from walmart_sales_data
group by gender
order by cust_type desc limit 1;

-- 24. What is the gender distribution per branch?
select branch,gender,count(gender) total_count from walmart_sales_data
group by branch,gender
order by branch;

-- 25. Which time of the day do customers give most ratings?
SELECT
    EXTRACT(HOUR FROM time) AS hour_of_day,
    COUNT(*) AS rating_count
FROM
    walmart_sales_data
GROUP BY
    hour_of_day
ORDER BY
    rating_count DESC
LIMIT 1;

-- 26. Which time of the day do customers give most ratings per branch?
SELECT
    branch,
    EXTRACT(HOUR FROM time) AS hour_of_day,
    COUNT(*) AS rating_count
FROM
    walmart_sales_data
GROUP BY
    branch, hour_of_day
ORDER BY
    branch, rating_count DESC;

-- 27. Which day of the week has the best avg ratings?
select dayname(date) as weekday,
      count(*) total_raitng_give,
      avg(rating) avg_r
      from walmart_sales_data
      
      group by weekday
      order by avg_r desc limit 1;
      
-- 28. Which day of the week has the best average ratings per branch?
select branch,
dayname(date) weekday,
count(*) total_rating,
avg(rating) average_rating
from walmart_sales_data

group by weekday,branch
order by average_rating desc limit 1;

									-- THANK_YOU