show databases;

create database olist_store_analysis;

drop table olist_orders_dataset_cleaned;

select * from olist_customers_dataset_cleaned;
select * from olist_order_items_dataset_cleaned;
select * from olist_order_payments_dataset_cleaned;
select	* from olist_order_reviews_dataset_cleaned;
select * from olist_orders_dataset_cleaned;
select * from olist_products_dataset_cleaned;
select * from olist_sellers_dataset_cleaned;
select * from product_category_name_translation_cleaned;


use olist_store_analysis;

select * from olist_orders_dataset_cleaned;
select * from olist_order_payments_dataset_cleaned;
-- 1
SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(o.order_purchase_timestamp, '%m/%d/%Y %H:%i')) IN (1, 7) 
        THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS DayType,
    COUNT(DISTINCT o.order_id) AS TotalOrders,
    ROUND(SUM(p.payment_value)) AS TotalPayments,
    ROUND(AVG(p.payment_value)) AS AveragePayment
FROM olist_orders_dataset_cleaned o
JOIN olist_order_payments_dataset_cleaned p 
    ON o.order_id = p.order_id
WHERE o.order_purchase_timestamp IS NOT NULL 
AND STR_TO_DATE(o.order_purchase_timestamp, '%m/%d/%Y %H:%i') IS NOT NULL
GROUP BY DayType;

-- 2

select
count(distinct p.Order_id) as NumberofOrders
from
olist_order_payments_dataset_cleaned p
join
olist_order_reviews_dataset_cleaned r on p.order_id = r.order_id
where
r.review_score=5
and p.payment_type = 'credit_card';


select * from olist_orders_dataset_cleaned;
select * from olist_products_dataset_cleaned;
select * from olist_order_items_dataset_cleaned;

-- 3

SELECT 
    p.product_category_name,
    ROUND(AVG(DATEDIFF(
        STR_TO_DATE(o.order_delivered_customer_date, '%m/%d/%Y %H:%i'), 
        STR_TO_DATE(o.order_purchase_timestamp, '%m/%d/%Y %H:%i')
    ))) AS avg_delivery_time
FROM 
    olist_orders_dataset_cleaned o
JOIN 
    olist_order_items_dataset_cleaned i ON o.order_id = i.order_id
JOIN 
    olist_products_dataset_cleaned p ON p.product_id = i.product_id
WHERE 
    p.product_category_name = 'pet_shop'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_purchase_timestamp IS NOT NULL
GROUP BY 
    p.product_category_name;

-- 4
select
round(avg(i.price)) as average_price,
round(avg(p.payment_value)) as average_payment
from
olist_customers_dataset_cleaned c
join
olist_orders_dataset_cleaned o on c.customer_id=o.customer_id
join
olist_order_items_dataset_cleaned i on o.order_id = i.order_id
join
olist_order_payments_dataset_cleaned p on o.order_id = p.order_id
where
c.customer_city = 'Sao Paulo';


--  5

SELECT 
    ROUND(AVG(DATEDIFF(
        STR_TO_DATE(o.order_delivered_customer_date, '%m/%d/%Y %H:%i'), 
        STR_TO_DATE(o.order_purchase_timestamp, '%m/%d/%Y %H:%i')
    )), 0) AS AvgShippingDays,
    r.review_score
FROM 
    olist_orders_dataset_cleaned o
JOIN 
    olist_order_reviews_dataset_cleaned r ON o.order_id = r.order_id
WHERE 
    o.order_delivered_customer_date IS NOT NULL
    AND o.order_purchase_timestamp IS NOT NULL
GROUP BY 
    r.review_score;



















