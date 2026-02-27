# Olist Customer Churn Analyis

## Overview
This is an E-commerce Customer Churn Analysis Project where I analyzed customer behaviour to identify the churn patterns and prevent the company from churn.
The goal is to understand the factors influencing customer churn and provide data-driven recommendations for customer retention.

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
- layer 1 - Order Level Table
- layer 2 - Aggregations
- layer 3 - Customer KPI Table
- Layer 4 - Churn Analysis

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
- **Extremely High First-Purchase Drop-off**
Nearly 97% of customers did not return after their first purchase, indicating a very high first-purchase churn rate.
**Business Meaning:**
The company struggles with customer retention after initial acquisition. Marketing may be effective, but loyalty is weak.
- **Repeat Customers Are Extremely Valuable**
Only about 3% of customers placed more than one order, but they represent the retained segment.
**Business Meaning:**
Even a small increase in repeat purchases can significantly improve revenue stability.
- **Order Frequency Strongly Impacts Churn**
Customers with only 1 order = churned
Customers with 2+ orders = retained
**Business Meaning:**
Order frequency is the strongest churn indicator in this dataset.
This is your most powerful analytical conclusion.
- **Revenue Distribution is Positively Skewed**
Most customers have low total spending, while a small group contributes high revenue (right-skewed distribution).
**Business Meaning:**
The business likely depends heavily on a small segment of high-value customers.
- **Outliers Represent High-Value Customers**
There are noticeable high-value outliers in total spending and order value.
**Business Meaning:**
These customers may qualify for VIP retention strategies.
- **Correlation Insight**
Strong negative correlation between churn and total_orders
Strong negative correlation between churn and total_spend
**Business Meaning:**
Customers who spend more and order more are significantly less likely to churn.
That’s a clean analytical statement.

## Project Structure
Olist-Customer-Churn-Analysis/
│
├── Datasets/
├── SQL_files/
├── Notebooks/
├── Images/
└── README.md
