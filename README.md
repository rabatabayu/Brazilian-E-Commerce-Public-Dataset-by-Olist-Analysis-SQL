# Olist E-Commerce Sales Analysis — SQL Project

## Project Overview
This project focuses on analyzing Olist Brazilian e-commerce sales data using PostgreSQL. The goal is to understand sales performance, customer purchasing behavior, product categories, and regional sales distribution to support data-driven business decisions and sustainable growth.

## Objectives
- Analyze overall sales performance and revenue trends.
- Identify customer purchasing behavior and repeat purchase patterns.
- Evaluate payment methods and transaction values.
- Identify top-performing product categories.
- Analyze seller distribution across different regions.
- Provide business recommendations to improve customer retention and sales performance.

## Dataset Overview
The dataset was obtained from Kaggle and contains Brazilian e-commerce transactions from Olist.

**Data Source:** [Kaggle – Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The analysis focuses on four main tables:

| Table | Description |
| --- | --- |
| `orders` | Order information, status, and purchase dates |
| `order_items` | Products, prices, and sellers associated with each order |
| `payments` | Payment methods and transaction values |
| `sellers` | Seller information and geographical locations |

## Tools
- **PostgreSQL** – Database Management and SQL Analysis
- **SQL Queries** – Data Extraction, Filtering, and Aggregation
- **JOIN & CTE** – Combining Tables and Organizing Complex Queries
- **Window Functions** – Advanced Sales and Customer Analysis

## Project Workflow

### 1. Data Exploration
- Examined database structure and table relationships.
- Identified primary and foreign keys.
- Checked transaction volumes and order status distributions.
- Explored payment methods, customer activity, and seller locations.

### 2. Sales Performance Analysis
- Analyzed monthly sales and transaction trends.
- Calculated total payment values and order volumes.
- Evaluated sales performance across product categories.
- Identified categories contributing the highest sales value.

### 3. Customer Behavior Analysis
- Classified customers based on purchase frequency.
- Identified one-time and repeat customers.
- Analyzed customer purchasing patterns.
- Evaluated opportunities for improving customer retention.

### 4. Payment Method Analysis
- Compared payment methods based on transaction volume.
- Calculated total payment values and average transaction amounts.
- Identified the most frequently used payment methods.

### 5. Regional Analysis
- Analyzed seller distribution across Brazilian states.
- Identified regions with the highest concentration of sellers.
- Evaluated geographical differences in marketplace participation.

## Key Findings

| Analysis | Finding |
| --- | --- |
| Total Orders | **99,441 orders** |
| Most Common Order Status | **Delivered: 96,478 orders** |
| Leading Payment Method | **Credit Card: 76,795 payment records** |
| Highest Sales Value Category | **Beauty & Health: approximately 1.23 million** |
| Largest Seller Region | **São Paulo (SP): 1,849 sellers** |
| One-Time Customers | **90,557 customers** |
| Repeat Customers | **2,801 customers** |

### Main Insights
1. **Sales Performance:** Monthly sales analysis reveals changes in transaction activity and payment values over time.
2. **Customer Retention:** One-time buyers dominate customer activity, highlighting opportunities to encourage repeat purchases.
3. **Payment Preferences:** Credit cards represent the most frequently used payment method and contribute the largest recorded payment value.
4. **Product Performance:** Beauty & Health, Watches & Gifts, and Bed & Bath are among the highest-performing categories by sales value.
5. **Regional Distribution:** São Paulo has the largest concentration of sellers, indicating a strong geographical concentration of marketplace supply.

## Business Recommendations
1. **Improve Customer Retention:** Develop loyalty programs, personalized promotions, and repeat-purchase incentives.
2. **Optimize Product Strategy:** Prioritize high-performing categories while evaluating opportunities to improve underperforming products.
3. **Strengthen Payment Experience:** Maintain convenient credit card payment options while supporting alternative payment methods.
4. **Expand Regional Opportunities:** Explore seller acquisition and marketplace expansion in regions with lower seller participation.
5. **Monitor Business Performance:** Regularly evaluate monthly sales, payment trends, and customer purchase frequency to support business decisions.

## Conclusion
The Olist E-Commerce Sales Analysis reveals important patterns in marketplace performance, customer behavior, payment preferences, and regional seller distribution.

The findings highlight opportunities to improve customer retention, optimize product strategies, and strengthen regional marketplace development.

By utilizing PostgreSQL and SQL-based analytical techniques, this project demonstrates how transactional data can be transformed into actionable business insights to support sustainable e-commerce growth.
