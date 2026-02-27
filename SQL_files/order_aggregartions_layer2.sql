-- =========================================
-- Layer 1: Order Aggregations
-- Purpose: Convert 1-to-many tables into
-- 1 row per order
-- =========================================

-- SETTING SCHEMA
USE ecommerce_db;

-- BULIDINGING CLEAN TRANSACTION TABLE
DROP TABLE IF EXISTS transaction_base;

CREATE TABLE transaction_base AS
SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_state,
    
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    
    p.payment_type,
    p.payment_value,
    
    r.review_score,
    
    -- Delivery delay (actual - estimated)
    DATEDIFF(o.order_delivered_customer_date, 
             o.order_estimated_delivery_date) AS delivery_delay_days

FROM orders o

LEFT JOIN customers c
    ON o.customer_id = c.customer_id

LEFT JOIN order_items oi
    ON o.order_id = oi.order_id

LEFT JOIN order_payments p
    ON o.order_id = p.order_id

LEFT JOIN order_reviews r
    ON o.order_id = r.order_id;

-- CHECKING ON THE DUPLICATES
SELECT COUNT(*) FROM transaction_base;
SELECT COUNT(DISTINCT order_id) FROM transaction_base;

SELECT order_id, COUNT(*) 
FROM transaction_base
GROUP BY order_id
ORDER BY COUNT(*) DESC
LIMIT 10;

-- DROPPING THE CREATED TABLE AS THE JOINING EXPLICITLY CREATED CARTESIAN EFFECT FOR SOME ORDERS
DROP TABLE IF EXISTS transaction_base;

-- BUILDING AGAIN USING AGGREGATIONS

-- Aggregate order_items → 1 row per order
DROP TABLE IF EXISTS order_items_agg;

CREATE TABLE order_items_agg AS
SELECT
    order_id,
    COUNT(order_item_id) AS total_items,
    SUM(price) AS total_product_value,
    SUM(freight_value) AS total_freight_value
FROM order_items
GROUP BY order_id;

SELECT COUNT(*) FROM order_items_agg;

-- Aggregate Payments (1 Row Per Order)
DROP TABLE IF EXISTS payments_agg;

CREATE TABLE payments_agg AS
SELECT
    order_id,
    SUM(payment_value) AS total_payment_value,
    COUNT(payment_sequential) AS total_payment_installments
FROM order_payments
GROUP BY order_id;

SELECT COUNT(*) FROM payments_agg;

-- Aggregate Reviews (1 Row Per Order)
DROP TABLE IF EXISTS reviews_agg;

CREATE TABLE reviews_agg AS
SELECT
    order_id,
    AVG(review_score) AS avg_review_score
FROM order_reviews
GROUP BY order_id;

SELECT count(*) FROM reviews_agg;


