-- =========================================
-- Layer 4: Churn & Business Analysis
--
-- Objective:
-- Perform business-level analytical queries
-- using the customer_kpi and order_level tables.
-- =========================================

-- Monthly Revenue Trend
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(SUM(total_payment_value),2) AS monthly_revenue,
    COUNT(order_id) AS total_orders
FROM order_level
GROUP BY order_month
ORDER BY order_month;

-- Churn Distribution
SELECT
    churn_flag,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_kpi), 2) AS percentage
FROM customer_kpi
GROUP BY churn_flag;

-- Repeat Purchase Rate
SELECT
    ROUND(
        SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM customer_kpi;

-- Top Customers with Rank
SELECT *
FROM (
    SELECT
        customer_unique_id,
        total_spent,
        total_orders,
        RANK() OVER (ORDER BY total_spent DESC) AS spend_rank
    FROM customer_kpi
) ranked_customers
WHERE spend_rank <= 10;

-- Delayed Orders Percentage
SELECT
    ROUND(
        SUM(CASE WHEN delivery_delay_days > 0 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS delayed_order_percentage
FROM order_level;

-- Churn by Delivery Delay Category
SELECT
    CASE
        WHEN avg_delivery_delay <= 0 THEN 'On Time / Early'
        WHEN avg_delivery_delay BETWEEN 1 AND 5 THEN '1-5 Days Late'
        ELSE 'More Than 5 Days Late'
    END AS delay_bucket,
    COUNT(*) AS customers,
    ROUND(AVG(churn_flag) * 100, 2) AS churn_rate
FROM customer_kpi
GROUP BY delay_bucket
ORDER BY churn_rate DESC;

-- Churn by Freight Ratio
SELECT
    CASE
        WHEN avg_freight_ratio <= 0.10 THEN 'Low (<=0.10)'
        WHEN avg_freight_ratio <= 0.30 THEN 'Medium (0.10-0.30)'
        ELSE 'High (>0.30)'
    END AS freight_bucket,
    COUNT(*) AS customers,
    ROUND(AVG(churn_flag) * 100, 2) AS churn_rate
FROM customer_kpi
GROUP BY freight_bucket
ORDER BY churn_rate DESC;

-- Churn by State
SELECT
    customer_state,
    COUNT(*) AS total_customers,
    ROUND(AVG(churn_flag) * 100, 2) AS churn_rate
FROM customer_kpi
GROUP BY customer_state
ORDER BY total_customers DESC;

-- Payment Method Popularity
SELECT
    payment_type,
    COUNT(*) AS usage_count
FROM order_payments
GROUP BY payment_type
ORDER BY usage_count DESC;

-- Revenue Contribution by Spend Segment
WITH segmented AS (
    SELECT
        total_spent,
        NTILE(4) OVER (ORDER BY total_spent DESC) AS spend_quartile
    FROM customer_kpi
)

SELECT
    spend_quartile,
    COUNT(*) AS customers,
    ROUND(SUM(total_spent),2) AS total_revenue,
    ROUND(
        SUM(total_spent) * 100.0 /
        (SELECT SUM(total_spent) FROM customer_kpi),
        2
    ) AS revenue_percentage
FROM segmented
GROUP BY spend_quartile
ORDER BY spend_quartile;

-- Churn Rate by Spend Segment
WITH segmented AS (
    SELECT
        churn_flag,
        NTILE(4) OVER (ORDER BY total_spent DESC) AS spend_quartile
    FROM customer_kpi
)

SELECT
    spend_quartile,
    COUNT(*) AS customers,
    ROUND(AVG(churn_flag) * 100, 2) AS churn_rate
FROM segmented
GROUP BY spend_quartile
ORDER BY spend_quartile;
