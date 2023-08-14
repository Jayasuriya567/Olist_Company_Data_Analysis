#KPI_1
SELECT 
IF(WEEKDAY(olist_orders_dataset.order_purchase_timestamp) IN (5,6),"WEEKEND","WEEKDAY") AS DAY_KIND,
ROUND( SUM(olist_order_payments_dataset.payment_value)) AS Total_Payments
 FROM olist_orders_dataset 
 INNER JOIN olist_order_payments_dataset 
 ON olist_orders_dataset.order_id = olist_order_payments_dataset.order_id group by DAY_KIND;
 
 
 #KPI_2
 
 SELECT COUNT(*) As REVIEW_5_CREDIT_CARD FROM olist_order_payments_dataset
 INNER JOIN olist_order_reviews_dataset ON olist_order_payments_dataset.order_id = olist_order_reviews_dataset.order_id
 WHERE olist_order_payments_dataset.payment_type = "credit_card" AND olist_order_reviews_dataset.review_score = 5;
 
#KPI_3

SELECT
 p.product_category_name,
 ROUND(AVG(DATEDIFF(od.order_delivered_customer_date,od.order_purchase_timestamp))) AS avg_Delivery_Days
 FROM olist_products_dataset p
 INNER JOIN olist_order_items_dataset  oi  ON p.product_id = oi.product_id
 INNER JOIN olist_orders_dataset od ON oi.order_id = od.order_id
 WHERE p.product_category_name = "pet_shop"
 GROUP BY
  p.product_category_name;

#KPI_4

SELECT
c.customer_city,
ROUND(AVG(i.price),2) AS Average_Price,
ROUND(AVG(p.payment_value),2) AS Average_Payment
FROM olist_customers_dataset c 
INNER JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
INNER JOIN olist_order_items_dataset i ON o.order_id = i.order_id
INNER JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE c.customer_city = "sao paulo"
GROUP BY c.customer_city;

#KPI_5

SELECT r.review_score, ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,o.order_purchase_timestamp))) AS avg_delivery_days
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o ON r.order_id = o.order_id
GROUP BY r.review_score
ORDER BY r.review_score;





