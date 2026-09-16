# E-Commerce-Sales-Analytics-Dashboard
Analyzed e-commerce performance to identify revenue trends, profitability issues, discount impact, and customer opportunities, translating findings into actionable business recommendations. Tools: PostgreSQL, SQL, Power BI, DAX.
## 📊 Dashboard
### Overview Dashboard
[View Overview Dashboard](./Dashboard%20overview.png)
### Deep Dive Dashboard
[View Deepdive Dashboard](./Dashboard%20Deepdive.png)
## ❓ Business Questions Answered

**Q1. Revenue Trend Analysis**
How did monthly revenue grow or decline over 30 months,
and which months showed the biggest anomalies?

**Q2. Product Profitability Analysis**
Which products are driving the most profit and which
products are losing money — and what is the root cause?

**Q3. Customer Segmentation Analysis**
What percentage of customers are repeat buyers and how
much revenue do they contribute vs new customers?

**Q4. High Value Customer Analysis (Pareto 80/20)**
Do the top 20% of customers drive 80% of revenue and
how concentrated is our revenue risk?

**Q5. Profit Margin & Discount Impact Analysis**
Which product categories have the thinnest profit margins
and is heavy discounting the root cause behind it?

**Q6. Sub-Category Performance Breakdown**
Which specific sub-categories are star performers and
which ones need immediate business intervention?

## 🔍 Analysis Performed

### 1. Revenue & Sales Trend Analysis
- Analyzed ₹12.25M total revenue across 6,721 orders from 2022–2024.
- Evaluated monthly revenue and Month-over-Month (MoM) changes to identify significant sales fluctuations.
- Identified major declines of 19% in early 2023, 24% in late 2023, and 42% in June 2024.
- Compared category and product performance to identify key contributors to revenue.

### 2. Profitability & Discount Analysis
- Calculated overall profit of ₹2.37M with a 19.34% profit margin.
- Compared average discount rates against profit margins across four categories.
- Identified Electronics as the only category where average discount (18.6%) exceeded profit margin (16.3%).
- Performed sub-category analysis to identify products with low margins and high discount exposure.

### 3. Product & Sub-Category Analysis
- Analyzed 10+ sub-categories using orders, discounts, profit margins, and total profit.
- Identified Appliances (28.18%) and Bags (27.46%) as the highest-margin sub-categories.
- Identified Phones (8.72%), Bookcases (12.18%), and Decor (12.11%) as low-margin areas.
- Ranked products by profit to identify the strongest contributors to overall profitability.

### 4. Customer Segmentation Analysis
- Analyzed 2,335 customers based on purchasing behavior.
- Compared New vs. Repeat customers, with Repeat customers contributing 93.66% of the customer base.
- Performed Pareto analysis by comparing the Top 20% (467 customers) with the Bottom 80% (1,868 customers).
- Compared average customer spending of ₹11,546 for the Top 20% against ₹3,670 for the Bottom 80%.

### 5. Business Impact Analysis
- Connected revenue trends, discount levels, product margins, and customer behavior to identify business performance gaps.
- Used the analysis to identify opportunities for discount optimization, high-margin category growth, and increasing customer spending.
- Translated data-driven findings into actionable business recommendations.

## 🧮 SQL Analysis

PostgreSQL was used to transform the business questions into
data-driven analysis. SQL queries were developed to analyze:

- Monthly revenue trends and MoM changes
- Product and category profitability
- Customer segmentation and repeat-purchase behavior
- Top 20% vs Bottom 80% customer revenue contribution
- Profit margin vs discount impact
- Sub-category performance and ranking
- High-profit and low-profit products

### Key SQL Techniques

- `GROUP BY` and aggregate functions
- `CASE WHEN` for business logic
- Date and time functions
- Common Table Expressions (CTEs)
- Window functions
- `RANK()` / `ROW_NUMBER()`
- Subqueries
- Customer segmentation
- Revenue and profit calculations

📄 **[View Complete SQL Analysis](./Analysis_queries.sql)**

