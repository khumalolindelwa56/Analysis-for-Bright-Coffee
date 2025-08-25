-- I want to see the columns in my table and the date types
SELECT*
FROM brightshopanalytics
LIMIT 20;

SELECT MIN(transaction_time) AS opening_time,
FROM brightshopanalytics;

SELECT MAX(transaction_time) AS closing_time,
FROM brightshopanalytics;

    SELECT 
    --DATES
    TO_DATE (transaction_date) AS transaction_date,
    DAYOFMONTH(TO_DATE(transaction_date)) AS day_of_month,
    DAYNAME(TO_DATE(transaction_date)) AS day_name,
    MONTHNAME(TO_DATE(transaction_date)) AS month_name,
    TO_CHAR(TO_DATE(transaction_date),'YYYMM') AS month_id,

    --COUNTS

    COUNT(DISTINCT transaction_id) AS number_of_sales,
    COUNT(DISTINCT product_id) AS number_of_unique_products,
    COUNT(DISTINCT store_id) AS number_of_shops,

    CASE
   
    WHEN transaction_time BETWEEN '06:00:00'::TIME AND '11:59:59'::TIME THEN 'Morning'
    WHEN transaction_time BETWEEN '12:00:00'::TIME AND '16:59:59'::TIME THEN 'Afternoon'
    WHEN transaction_time BETWEEN '17:00:00'::TIME AND '19:59:59'::TIME THEN 'Evening'
    ELSE 'Night'
END AS time_bucket,

    CASE
    WHEN DAYNAME(transaction_date) NOT IN ('Saturday', 'Sunday') THEN 'Weekday'
    ELSE 'Weekend'
END AS day_classification,

--ROUND (SUM(IF NULL(transactio_qty,0)* IF NULL(unit_price,0)) AS revenue
    SUM(transaction_qty*unit_price),
    
    --CATEGORIES
    store_location,
    product_category,
    product_detail,
    product_type,
    
FROM brightshopanalytics,
GROUP BY ALL;
