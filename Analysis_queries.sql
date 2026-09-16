
-- CUSTOMERS
CREATE TABLE "e_commerce".customers (
    Customer_ID    VARCHAR(20) PRIMARY KEY,
    Customer_Name  VARCHAR(100) NOT NULL,
    Segment        VARCHAR(50),
    Region         VARCHAR(50),
    City           VARCHAR(50),
    Signup_Date    DATE
);

-- PRODUCTS
CREATE TABLE "e_commerce".products (
    Product_ID     VARCHAR(20) PRIMARY KEY,
    Product_Name   VARCHAR(150) NOT NULL,
    Category       VARCHAR(50),
    Sub_Category   VARCHAR(50),
    Cost_Price     NUMERIC(10,2) CHECK (Cost_Price >= 0),
    Selling_Price  NUMERIC(10,2) CHECK (Selling_Price >= 0),
    Supplier       VARCHAR(100)
);

-- ORDERS
CREATE TABLE "e_commerce".orders (
    Order_ID         VARCHAR(20) PRIMARY KEY,
    Customer_ID      VARCHAR(20) REFERENCES "e_commerce".customers(Customer_ID),
    Product_ID       VARCHAR(20) REFERENCES "e_commerce".products(Product_ID),
    Order_Date       DATE NOT NULL,
    Quantity         INT CHECK (Quantity > 0),
    Sales            NUMERIC(10,2) CHECK (Sales >= 0),
    Profit           NUMERIC(10,2),
    Discount         NUMERIC(5,2) CHECK (Discount >= 0 AND Discount <= 1),
    Shipping_Mode    VARCHAR(50),
    Payment_Method   VARCHAR(50),
    Return_Status    VARCHAR(20),
    Delivery_Days    INT CHECK (Delivery_Days >= 0)
);
SELECT *FROM "e_commerce". orders;
SELECT *FROM "e_commerce".customers;
SELECT *FROM "e_commerce".products;

SELECT current_database();
SELECT current_schema();
--ecommerce analysis--
-- 1. Row counts 
SELECT 'customers' AS table_name, COUNT(*) FROM "e_commerce".customers
UNION ALL
SELECT 'products', COUNT(*) FROM "e_commerce".products
UNION ALL
SELECT 'orders', COUNT(*) FROM "e_commerce".orders;

-- 2. Duplicate orders
SELECT 
   Order_ID, 
   COUNT(*) 
FROM "e_commerce".orders 
GROUP BY Order_ID 
HAVING COUNT(*) > 1;

-- 3. Nulls in critical columns
SELECT COUNT(*) AS null_customer_id FROM "e_commerce".orders WHERE Customer_ID IS NULL;
SELECT COUNT(*) AS null_product_id FROM "e_commerce".orders WHERE Product_ID IS NULL;
SELECT COUNT(*) AS null_sales FROM "e_commerce".orders WHERE Sales IS NULL;

--Monthly gowth check(Trend Analysis)(with out cte's)
SELECT 
    DATE_TRUNC('month', Order_Date)::DATE AS month,
    ROUND(SUM(Sales)::NUMERIC, 2) AS total_sales,
    ROUND(LAG(SUM(Sales)) OVER (ORDER BY DATE_TRUNC('month', Order_Date)::DATE)::NUMERIC, 2) AS prev_month_sales,
    ROUND((100.0 * (SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY DATE_TRUNC('month', Order_Date)::DATE)) 
        / LAG(SUM(Sales)) OVER (ORDER BY DATE_TRUNC('month', Order_Date)::DATE))::NUMERIC, 2) AS mom_growth_pct
FROM "e_commerce".orders
GROUP BY DATE_TRUNC('month', Order_Date)::DATE
ORDER BY 1;

--Monthly Growth Check Using CTE's
  WITH Monthly_Sales AS (
    SELECT
	     DATE_TRUNC('month',Order_Date)::DATE AS Month,
		 ROUND(SUM(sales):: NUMERIC,2 )AS total_sales
    FROM "e_commerce".orders
	GROUP BY  DATE_TRUNC('month',Order_Date)::DATE
)
SELECT 
     Month,
	 total_sales,
	 LAG(total_sales) OVER (ORDER BY MONTH) AS pre_mon_sales,
	 ROUND((100*(total_sales-LAG(total_sales) OVER (ORDER BY MONTH))
	            /LAG(total_sales) OVER (ORDER BY MONTH)):: NUMERIC,2) AS mom_growth_pct
     FROM Monthly_sales
	 ORDER BY month;
--deep analysis for june 2024 loss(category wise)--
SELECT 
    p.Category,
 ROUND(SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2024-05-01' 
        THEN o.Sales ELSE 0 END)::NUMERIC, 2) AS may_sales,
    ROUND(SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2023-06-01' 
        THEN o.Sales ELSE 0 END)::NUMERIC, 2) AS jun_sales,
    ROUND((100.0 * (
        SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2024-05-01' THEN o.Sales ELSE 0 END) -
        SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2023-06-01' THEN o.Sales ELSE 0 END)
    ) / NULLIF(SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2024-05-01' 
        THEN o.Sales ELSE 0 END), 0))::NUMERIC, 2) AS mom_change_pct
FROM "e_commerce".orders o
JOIN "e_commerce".products p ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY mom_change_pct ASC;
--sub_category wise analysis for june 2024 loss--
SELECT 
    p.Category,
    p.Sub_Category,
    ROUND(SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2024-05-01' 
        THEN o.Sales ELSE 0 END)::NUMERIC, 2) AS may_sales,
    ROUND(SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2024-06-01' 
        THEN o.Sales ELSE 0 END)::NUMERIC, 2) AS jun_sales,
    ROUND((100.0 * (
        SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2024-06-01' THEN o.Sales ELSE 0 END) -
        SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2024-05-01' THEN o.Sales ELSE 0 END)
    ) / NULLIF(SUM(CASE WHEN DATE_TRUNC('month', o.Order_Date)::DATE = '2024-05-01' 
        THEN o.Sales ELSE 0 END), 0))::NUMERIC, 2) AS drop_pct
FROM "e_commerce".orders o
JOIN "e_commerce".products p ON o.Product_ID = p.Product_ID
GROUP BY p.Category, p.Sub_Category
ORDER BY drop_pct ASC;

--checking is that june 2024 historically get loss every year campare to previous month--
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS year,
    ROUND(SUM(CASE WHEN EXTRACT(MONTH FROM Order_Date) = 6 
        THEN Sales ELSE 0 END)::NUMERIC, 2) AS june_sales,
    ROUND(SUM(CASE WHEN EXTRACT(MONTH FROM Order_Date) = 5 
        THEN Sales ELSE 0 END)::NUMERIC, 2) AS may_sales,
    ROUND((100.0 * (
        SUM(CASE WHEN EXTRACT(MONTH FROM Order_Date) = 6 THEN Sales ELSE 0 END) -
        SUM(CASE WHEN EXTRACT(MONTH FROM Order_Date) = 5 THEN Sales ELSE 0 END)
    ) / NULLIF(SUM(CASE WHEN EXTRACT(MONTH FROM Order_Date) = 5 
        THEN Sales ELSE 0 END), 0))::NUMERIC, 2) AS may_to_jun_change
FROM "e_commerce".orders
GROUP BY 1
ORDER BY 1;

--checking for jan 2024 losss is hitorically every year campare to previous month--
WITH monthly_totals AS (
    SELECT 
        DATE_TRUNC('month', Order_Date)::DATE AS month,
        ROUND(SUM(Sales)::NUMERIC, 2) AS total_sales
    FROM "e_commerce".orders
    GROUP BY DATE_TRUNC('month', Order_Date)::DATE
),
with_previous AS (
    SELECT 
        month,
        total_sales AS current_month_sales,
        LAG(total_sales) OVER (ORDER BY month) AS prev_month_sales,
        EXTRACT(MONTH FROM month) AS month_num,
        EXTRACT(YEAR FROM month) AS year
    FROM monthly_totals
)
SELECT 
    year,
    month,
    current_month_sales AS jan_sales,
    prev_month_sales AS dec_sales,
    ROUND((100.0 * (current_month_sales - prev_month_sales) 
        / NULLIF(prev_month_sales, 0))::NUMERIC, 2) AS jan_vs_prev_dec_pct
FROM with_previous
WHERE month_num=1
ORDER BY month;
	 
--TOP 10 products generating most profit--
SELECT 
     p.product_name,
	 p.category,
	 p.sub_category,
	 SUM(o.quantity) AS units_sold,
	 ROUND(SUM(o.sales)::NUMERIC,2) AS total_sales,
	 ROUND(SUM(o.profit)::NUMERIC,2) AS total_profits,
	 ROUND((100.0*SUM(o.profit)/NULLIF(SUM(o.sales),0))::NUMERIC,2) AS profit_margin_pct
 FROM "e_commerce".orders o
 JOIN "e_commerce".products p ON o.product_id=p.product_id
 GROUP BY p.product_name,p.category,p.sub_category 
 ORDER BY total_profits DESC
 LIMIT 10;
--TOP 10 products generating loss--
SELECT 
     p.product_name,
	 p.category,
	 p.sub_category,
	 SUM(o.quantity) AS units_sold,
	 ROUND(SUM(o.sales)::NUMERIC,2) AS total_sales,
	 ROUND(SUM(o.profit)::NUMERIC,2) AS total_profits,
	 ROUND((100.0*SUM(o.profit)/NULLIF(SUM(o.sales),0))::NUMERIC,2) AS profit_margin_pct
 FROM "e_commerce".orders o
 JOIN "e_commerce".products p ON o.product_id=p.product_id
 GROUP BY p.product_name,p.category,p.sub_category 
 ORDER BY total_profits ASC
 LIMIT 10

--Deep Analysis for loss making products--
--Discount check for loss products--
 SELECT 
    p.Product_name,
    p.category,
    ROUND(AVG(o.discount)::NUMERIC, 4) AS avg_discount,
    ROUND(AVG(o.discount) * 100::NUMERIC, 2) AS avg_discount_pct,
    ROUND(SUM(o.Profit)::NUMERIC, 2) AS total_profit
FROM "e_commerce".orders o
JOIN "e_commerce".products p ON o.Product_id = p.Product_id
WHERE p.Product_name IN (
    'Phones First',
    'Phones Industry', 
    'Phones Cover',
    'Bookcases Sport',
    'Cookware Break',
    'Shoes Else',
    'Lighting Capital',
    'Appliances Close',
    'Watches Above',
	'Laptops Campaing'
)
GROUP BY p.Product_name, p.category
ORDER BY avg_discount DESC;

--check overall heavy discounts--
SELECT 
    p.Product_name,
	p.category,
    ROUND(AVG(o.discount) * 100::NUMERIC, 2) AS avg_discount_pct,
    ROUND(SUM(o.profit)::NUMERIC, 2) AS total_profit
FROM "e_commerce".orders o
JOIN "e_commerce".products p ON o.Product_id = p.Product_id
GROUP BY p.product_name,p.category
HAVING SUM(o.Profit) < 0
ORDER BY avg_discount_pct DESC;

--checking gross margin pct for loss products--
SELECT 
    product_name,
	category,
    cost_price,
    selling_price,
    ROUND(((selling_price - cost_price) / NULLIF(selling_price, 0) * 100)::NUMERIC, 2) AS gross_margin_pct
FROM "e_commerce".products
ORDER BY gross_margin_pct ASC
LIMIT 15;

--checking return rate pct for loss products--
SELECT 
    p.Product_name,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN o.return_status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND((100.0 * SUM(CASE WHEN o.Return_Status = 'Returned' THEN 1 ELSE 0 END) 
        / COUNT(*))::NUMERIC, 2) AS return_rate_pct
FROM "e_commerce".orders o
JOIN "e_commerce".products p ON o.Product_id = p.Product_id
GROUP BY p.Product_name
HAVING SUM(o.Profit) < 0
ORDER BY return_rate_pct DESC;

--customer Analysis---(churn analysis)--
WITH customers_orders AS(
SELECT
     o.customer_id,
	 COUNT(o.order_id) AS order_count,
	 ROUND(SUM(o.sales)::NUMERIC,2) AS total_sales,
	 ROUND(SUM(o.profit)::NUMERIC,2) AS total_profit
FROM "e_commerce".orders o
GROUP BY o.customer_id
)
 SELECT 
      CASE WHEN order_count= 1 THEN 'new_customer' ELSE 'repeat_customer' END AS customer_type,
	  COUNT(*) AS num_of_customers,
	  ROUND(SUM(total_sales)::NUMERIC,2) AS total_revenue,
	  ROUND(AVG(total_sales)::NUMERIC,2) AS avg_revenue_per_customer,
	  ROUND(SUM(total_profit)::NUMERIC,2) AS total_profits,
	  ROUND((100.0 * COUNT(*) / SUM(COUNT(*)) OVER())::NUMERIC, 2) AS pct_of_customers,
      ROUND((100.0 * SUM(total_sales) / SUM(SUM(total_sales)) OVER())::NUMERIC, 2) AS pct_of_revenue
 FROM customers_orders
 GROUP BY 1;
--pareto princple--(is there any 20/80 business revenue)
WITH customers_revenue AS(
     SELECT 
        o.Customer_ID,
        c.Customer_Name,
        c.Segment,
        ROUND(SUM(o.Sales)::NUMERIC, 2) AS total_sales,
        COUNT(o.Order_ID) AS total_orders
    FROM "e_commerce".orders o
    JOIN "e_commerce".customers c ON o.Customer_ID = c.Customer_ID
    GROUP BY o.Customer_ID, c.Customer_Name, c.Segment
),
revenue_ranking AS(
     SELECT
	     Customer_ID,
	     Customer_Name,
		 Segment,
		 total_sales,
		 total_orders,
	 RANK() OVER(ORDER BY total_sales DESC) AS ranking_revenue,
	 COUNT(*) OVER() AS total_customers
	 FROM customers_revenue
)
    SELECT
	   CASE WHEN ranking_revenue <=0.2*total_customers THEN 'TOP 20%' ELSE 'BOTTOM 80%' END AS customers_group,
	      COUNT(*) num_of_customers,
	      ROUND(SUM(total_sales)::NUMERIC, 2) AS total_revenue,
          ROUND(AVG(total_sales)::NUMERIC, 2) AS avg_revenue_per_customer,
          ROUND((100*SUM(total_sales)/SUM(SUM(total_sales)) OVER())::NUMERIC,2) AS total_revenue_pct
		  FROM revenue_ranking
		  GROUP BY 1
		  ORDER BY total_revenue DESC;
--category analysis(profit magin%,discount impact on category)          
SELECT
    p.category,
	COUNT(o.order_id) AS total_orders,
	SUM(o.quantity) AS total_units_sold,
	ROUND(SUM(o.sales)::NUMERIC,2) AS total_sales,
	ROUND(SUM(o.profit)::NUMERIC,2) AS total_profit,
	ROUND(AVG(o.discount*100)::NUMERIC,2) AS avg_discount_pct,
	ROUND(AVG(o.delivery_days)::NUMERIC,2) AS avg_delivery_days,
	ROUND((100*SUM(o.profit)/NULLIF (SUM(o.sales),0))::NUMERIC,2) AS profit_margin_pct
  FROM "e_commerce".orders o
  JOIN "e_commerce".products p ON o.product_id=p.product_id
  GROUP BY 1
  ORDER BY profit_margin_pct DESC;
--sub_category wise analysis(profit margin %,total revenue %)--
SELECT 
    p.Category,
    p.Sub_Category,
    COUNT(o.Order_ID) AS total_orders,
    SUM(o.Quantity) AS total_units_sold,
    ROUND(SUM(o.Sales)::NUMERIC, 2) AS total_sales,
    ROUND(SUM(o.Profit)::NUMERIC, 2) AS total_profit,
    ROUND((100.0 * SUM(o.Profit) / NULLIF(SUM(o.Sales), 0))::NUMERIC, 2) AS profit_margin_pct,
    ROUND((AVG(o.Discount) * 100)::NUMERIC, 2) AS avg_discount_pct,
     ROUND((100.0 * SUM(o.Sales) / SUM(SUM(o.Sales)) OVER())::NUMERIC, 2) AS pct_of_total_revenue
FROM "e_commerce".orders o
JOIN "e_commerce".products p ON o.Product_ID = p.Product_ID
GROUP BY p.Category, p.Sub_Category
ORDER BY total_sales DESC;
--region analysis--  
SELECT 
    c.Region,
    ROUND(SUM(o.Sales)::NUMERIC, 2) AS total_sales,
    ROUND(SUM(o.Profit)::NUMERIC, 2) AS total_profit,
    ROUND((100.0 * SUM(o.Profit) / 
        NULLIF(SUM(o.Sales), 0))::NUMERIC, 2) AS margin_pct
FROM "e_commerce".orders o
JOIN "e_commerce".customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Region
ORDER BY margin_pct DESC;

SELECT current_user, current_database();




	  