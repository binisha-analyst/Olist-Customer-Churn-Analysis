-- =========================================
-- Layer 3: Customer KPI Layer
-- Grain: 1 row per customer
--
-- Objective:
-- Build a customer-level analytical table
-- from order-level data to support churn
-- analysis and behavioral segmentation.
--
-- This layer defines churn logic and
-- prepares features for downstream
-- analytics and visualization.
-- =========================================
DROP TABLE IF EXISTS customer_kpi;

CREATE TABLE customer_kpi AS
SELECT
    customer_unique_id,
    customer_state,
    
    COUNT(order_id) AS total_orders,
    
    SUM(total_payment_value) AS total_spent,
    
    AVG(total_payment_value) AS avg_order_value,
    
    MAX(order_purchase_timestamp) AS last_purchase_date,
    
    DATEDIFF(
        (SELECT MAX(order_purchase_timestamp) FROM order_level),
        MAX(order_purchase_timestamp)
    ) AS recency_days,
    
    AVG(delivery_delay_days) AS avg_delivery_delay,
    
    AVG(freight_ratio) AS avg_freight_ratio,
    
    CASE
        WHEN COUNT(order_id) = 1 THEN 1
        ELSE 0
    END AS churn_flag

FROM order_level
GROUP BY customer_unique_id, customer_state;

SELECT COUNT(*) FROM customer_kpi;

SELECT 
    churn_flag, 
    COUNT(*) 
FROM customer_kpi
GROUP BY churn_flag;