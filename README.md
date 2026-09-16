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

## 📊 Power BI Dashboard

The interactive Power BI dashboard provides a two-page view of e-commerce performance, combining sales, profitability, customer behavior, and product-level analysis.

### Page 1 — Executive Overview

The Overview page provides a high-level view of business performance:

- **₹12.25M Total Revenue** generated from **6,721 orders**
- **₹2.37M Total Profit** with an overall **19.34% profit margin**
- **2,335 Total Customers** with customer segmentation analysis
- Monthly revenue trend and significant MoM declines
- Top 10 products ranked by profit
- New vs. repeat customer distribution
- Interactive filters for **Year, Category, and Customer Segment**

### Page 2 — Deep Dive Analysis

The Deep Dive page investigates the key drivers behind revenue and profitability:

- Profit margin vs. average discount by category
- Customer Pareto analysis comparing the **Top 20% (467 customers)** with the **Bottom 80% (1,868 customers)**
- Average spend per customer across customer segments
- Sub-category performance based on orders, discounts, profit margin, and profit
- Identification of high-margin and low-margin sub-categories
- Data-driven findings and business recommendations

### Dashboard Features

- Interactive slicers and cross-filtering
- KPI cards for key business metrics
- Monthly trend analysis
- Profitability analysis
- Customer segmentation
- Pareto analysis
- Product and sub-category performance analysis
- Business-focused insights and recommendations

### Dashboard Preview

#### Overview Dashboard

![Overview Dashboard](./Dashboard%20overview.png)

#### Deep Dive Dashboard

![Deep Dive Dashboard](./Dashboard%20Deepdive.png)

📁 **[Download Power BI Dashboard](./e_commerce_project.pbix)**

## 💡 Key Business Findings

### 1. Revenue Performance
- Generated **₹12.25M revenue** from **6,721 orders** between 2022–2024.
- Monthly revenue showed significant fluctuations, including a **42% decline in June 2024**, the largest decline highlighted in the dashboard.
- Furniture and Electronics experienced the largest category-level declines during this period.

### 2. Profitability & Discount Pressure
- Overall profit reached **₹2.37M**, with a **19.34% profit margin**.
- Electronics had the highest discount pressure, with **18.6% average discount vs. 16.3% profit margin**.
- Fashion delivered the highest category margin at **22.8%**, while maintaining a lower **17.9% average discount**.

### 3. Product & Sub-Category Performance
- **Appliances (28.18%)** and **Bags (27.46%)** achieved the highest sub-category profit margins.
- **Phones (8.72%)**, **Decor (12.11%)**, and **Bookcases (12.18%)** showed the weakest margins.
- Bags Store generated approximately **₹84K profit**, making it the highest-profit product shown in the dashboard.

### 4. Customer Revenue Distribution
- The analysis covered **2,335 customers**.
- The **Top 20% (467 customers)** generated approximately **₹5.4M**, while the **Bottom 80% (1,868 customers)** generated approximately **₹6.9M**.
- This represents approximately **44% vs. 56% of revenue**, indicating that revenue is not concentrated entirely among the highest-value customers.

### 5. Customer Spending Gap
- Top 20% customers spent approximately **₹11.5K per customer**.
- Bottom 80% customers spent approximately **₹3.7K per customer**.
- This represents roughly a **3.1× difference in average customer spend**, highlighting an opportunity to increase spending among lower-value customer segments.

## 💡 Business Recommendation

### 1.Investigate Potential Supplier Disruption

- The **42% revenue decline in June 2024**, driven by **Furniture (-65%)** and **Electronics (-55%)**, may indicate a potential **supplier, inventory, or fulfillment disruption** rather than a discount-related issue. Review stock availability, supplier performance, and fulfillment delays, and strengthen backup-supplier and inventory planning to prevent similar revenue disruptions.

### 2.Reduce Losses Through Targeted Product-Level Actions

- The **bottom 10 products generated a total loss of ₹60,997**, driven by three major issues: **excessive discounting, thin profit margins, and high return rates**. Products such as **Bookcases, Sport, Laptop Campaign, Lighting Capital, and Appliances** had discounts of approximately **17–22%**, putting pressure on profitability. **Phones Industry, Phone Cover, and Watches Above** had thin margins of only **9–11%** combined with return rates of **50–65%**, indicating potential quality or product-mismatch issues. **Phones** showed a combined risk with a **19% discount and 38% return rate**, while **Cookware** generated losses with a profit margin below **10%**.

- **Recommendation:** Reduce discounts on low-margin products, investigate quality and product-mismatch issues behind high returns, and review or renegotiate low-margin products. Prioritize corrective action on products with **both high discounts and high return rates** to reduce the ₹60,997 loss and improve overall profitability.

### 3.Strengthen New-Customer Acquisition While Retaining Repeat Customers

- Repeat customers contribute **₹1.15 Cr (93.66%)** of total revenue, while new customers contribute only **₹7.76 Lakhs (6.34%)**. This indicates strong revenue dependence on existing customers and a relatively small contribution from new-customer acquisition.

- **Recommendation:** Continue strengthening repeat-customer retention while increasing new-customer acquisition through targeted marketing, first-purchase offers, referral programs, and personalized campaigns. Growing the new-customer revenue contribution can help diversify the customer base and reduce dependence on repeat purchases.

### 4.Increase Revenue by Upgrading Lower-Value Customers

- The customer distribution is more balanced than a traditional **80/20 Pareto pattern**: the **top 20% (467 customers)** contribute **44% of revenue**, while the **bottom 80% (1,868 customers)** contribute **56%**. However, there is a **3.14× customer spending gap**, with top 20% customers spending **₹11,546 per customer** compared with **₹3,670** for the bottom 80%.

- **Recommendation:** Target the bottom 80% customers, particularly those spending **₹6,000–₹8,000**, with personalized offers, cross-selling, and loyalty incentives to increase their purchase value. If **10% of the bottom 80% customers** can be upgraded toward higher spending levels, the estimated revenue opportunity is approximately **₹14.93 Lakhs**. 

### 5.Optimize Discounting to Protect Profitability

- Across categories, profit margins range from **16.30% to 22.80%**, while average discounts remain high at approximately **17–19%**. In **Electronics**, the **18.59% discount exceeds the 16.30% profit margin**, creating significant profitability pressure. **Phones are the most critical**, with only an **8.72% margin against an 18.61% discount**.

- **Recommendation:** Review and reduce discounts across categories, with stricter controls on low-margin products. For **Phones**, consider limiting discounts to around **10%** and reassessing pricing to protect margins while maintaining competitive sales.
