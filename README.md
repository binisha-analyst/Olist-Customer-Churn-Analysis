# Olist Customer Churn Analysis

## Overview
This project analyzes customer purchasing behavior from an e-commerce dataset to identify churn patterns and uncover key business insights.
The objective is to understand the primary drivers of customer churn and provide actionable, data-driven recommendations to improve customer retention and long-term revenue stability.

## Business Problem
***What is Churn:***
Churn in business refers to the percentage of customers or subscribers who stop using a company's product or service during a specific timeframe, directly impacting revenue and growth.

***Why it matters in ecommerce:***
- **Revenue Impact:** E-commerce relies on repeat purchases. High churn directly reduces monthly recurring revenue (MRR) and customer lifetime value (CLV).
- **High Acquisition Costs:** It is far more expensive to acquire a new customer than to retain an existing one. High churn forces businesses to constantly spend on marketing just to maintain, rather than grow, their customer base.
- **Growth Inhibitor:** If churn exceeds the rate of new customer acquisition, the business will shrink.
- **Indicator of Health:** A high churn rate signals underlying problems, such as poor product quality, bad customer service, or superior competitor offerings.

The goal of this project is to analyze a rich, real-world e-commerce dataset to understand the primary drivers of customer churn. 

## Project Architecture

The analysis was built using a layered data transformation approach:

- **Layer 1 – Order-Level Table:** Cleaned and standardized transactional data.
- **Layer 2 – Aggregations:** Generated order-level and revenue-based aggregations.
- **Layer 3 – Customer KPI Table:** Built customer-level metrics such as total orders, total spend, and purchase frequency.
- **Layer 4 – Churn Analysis:** Defined churn logic and performed behavioral and statistical analysis.

## Tools & Technologies
- SQL (Data transformation & KPI building)
- Python (Pandas, Matplotlib)
- Jupyter Notebook
- Git & GitHub

## Key Analysis Performed
- Churn Rate Calculation
- Feature Behaviour vs Churn
- Correlation Analysis
- Distribution and skewness analysis
- Outlier detection

## Key Insights
### 1. Extremely High First-Purchase Drop-off
Nearly 97% of customers did not return after their first purchase, indicating a very high first-purchase churn rate.

**Business Meaning:**
The company struggles with customer retention after initial acquisition. Marketing may be effective, but loyalty is weak.
### 2. Repeat Customers Are Extremely Valuable
Only about 3% of customers placed more than one order, but they represent the retained segment.

**Business Meaning:**
Even a small increase in repeat purchases can significantly improve revenue stability.
### 3. Order Frequency Strongly Impacts Churn
Customers with only 1 order = churned
Customers with 2+ orders = retained

**Business Meaning:**
Order frequency is the strongest churn indicator in this dataset.
This is your most powerful analytical conclusion.
### 4. Revenue Distribution is Positively Skewed
Most customers have low total spending, while a small group contributes high revenue (right-skewed distribution).

**Business Meaning:**
The business likely depends heavily on a small segment of high-value customers.
### 5. Outliers Represent High-Value Customers
There are noticeable high-value outliers in total spending and order value.

**Business Meaning:**
These customers may qualify for VIP retention strategies.
### 6. Correlation Insight
Strong negative correlation between churn and total_orders
Strong negative correlation between churn and total_spend

**Business Meaning:**
Customers who spend more and order more are significantly less likely to churn.
That’s a clean analytical statement.

## Strategic Recommendations

Based on the analysis, the following strategies are recommended:

- Introduce post-purchase engagement campaigns to encourage second orders.
- Provide loyalty incentives for first-time buyers.
- Identify and target high-value customers with retention programs.
- Develop personalized marketing based on purchase behavior.

## Project Structure
Olist-Customer-Churn-Analysis/

├── Datasets/       → Raw datasets used for analysis

├── SQL_files/      → Layered SQL transformation scripts

├── Notebooks/      → Python EDA and statistical validation

├── Images/         → Visual outputs for documentation
