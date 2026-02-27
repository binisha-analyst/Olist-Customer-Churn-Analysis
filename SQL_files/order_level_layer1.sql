-- =========================================
-- Layer 2: Order-Level Table
-- Grain: 1 row per order
--
-- Objective:
-- Join aggregated order components
-- (items, payments, reviews) with
-- core order and customer information
-- to create a clean order-level dataset.
--
-- This layer ensures:
-- - No row multiplication
-- - Accurate revenue calculations
-- - Controlled data grain
-- - Derived metrics (delivery delay,
--   freight ratio)
--
-- This table serves as the foundation
-- for customer-level KPI modeling.
-- =========================================

-- BUILDING A CLEAN ORDER-LEVEL TABLE
DROP TABLE IF EXISTS order_level;

CREATE TABLE order_level AS
SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_state,
    
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    
    oi.total_items,
    oi.total_product_value,
    oi.total_freight_value,
    
    p.total_payment_value,
    p.total_payment_installments,
    
    r.avg_review_score,
    
    DATEDIFF(o.order_delivered_customer_date,
             o.order_estimated_delivery_date) AS delivery_delay_days,
             
    (oi.total_freight_value / NULLIF(oi.total_product_value,0)) AS freight_ratio

FROM orders o

LEFT JOIN customers c
    ON o.customer_id = c.customer_id

LEFT JOIN order_items_agg oi
    ON o.order_id = oi.order_id

LEFT JOIN payments_agg p
    ON o.order_id = p.order_id

LEFT JOIN reviews_agg r
    ON o.order_id = r.order_id;

-- NOW RECHECKING ON THE DUPLICATES
SELECT COUNT(*) FROM order_level;
SELECT COUNT(DISTINCT order_id) FROM order_level;

SELECT * FROM order_level;