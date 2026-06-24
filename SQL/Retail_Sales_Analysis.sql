use superstore_analysis;

# Key Business Questions

-- 1. How has the company's overall revenue, profit, and profit margin performed during the analysis period?
select round(sum(sales),2) as Revenue,
round(sum(profit),2) as Prpfit,
round((sum(profit) / sum(sales)) * 100,2) as "profit Margin %"
from superstore;

-- 2. Which product categories and sub-categories are the primary drivers of revenue and profitability?
SELECT 
    category,
    ROUND(SUM(sales), 2) AS Revenue,
    ROUND(SUM(profit), 2) AS Profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS 'Profit Margin %'
FROM
    superstore
GROUP BY category
ORDER BY Revenue DESC;

-- 3. Which products generate the highest revenue and profit, and which products consistently underperform?
SELECT 
    product_name,
    ROUND(SUM(sales), 2) AS Revenue,
    ROUND(SUM(profit), 2) AS Profit
FROM
    superstore
GROUP BY product_name
ORDER BY Revenue DESC
LIMIT 10;
-- UNDERPERFORMING PRODUCTS
SELECT 
    product_name,
    ROUND(SUM(sales), 2) AS Revenue,
    ROUND(SUM(profit), 2) AS Profit
FROM
    superstore
GROUP BY product_name
HAVING Profit < 0
ORDER BY Revenue ASC
LIMIT 10;

-- 4. Who are the most valuable customers based on revenue contribution and profitability?
SELECT 
    customer_name,
    ROUND(SUM(sales), 2) AS Revenue,
    ROUND(SUM(profit), 2) AS Profit
FROM
    superstore
GROUP BY customer_name
ORDER BY Revenue DESC
LIMIT 10;
-- Profitability Query
SELECT 
    customer_name, ROUND(SUM(profit), 2) AS Profit
FROM
    superstore
GROUP BY customer_name
ORDER BY Profit DESC
LIMIT 10;

-- 5. Which customer segments contribute the most to overall business performance?
SELECT 
    segment,
    ROUND(SUM(sales), 2) AS Revenue,
    ROUND(SUM(profit), 2) AS Profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS 'Profit Margin %'
FROM
    superstore
GROUP BY segment
ORDER BY Revenue DESC;

-- 6. Which regions and states contribute most significantly to revenue and profit generation?
-- REGION PERFORMANCE
WITH region_performance AS (
	SELECT 
		region,
		ROUND(SUM(sales), 2) AS Revenue,
		ROUND(SUM(profit), 2) AS Profit
	FROM superstore
	GROUP BY region
)
SELECT 
	region,
	Revenue,
    Profit,
	round((Profit/Revenue) * 100,2) AS "Profit Margin %"
FROM region_performance
ORDER BY Revenue DESC;
-- STATE PERRFORMANCE
WITH state_performance AS (
	SELECT 
		state,
		ROUND(SUM(sales), 2) AS Revenue,
		ROUND(SUM(profit), 2) AS Profit
	FROM superstore
	GROUP BY state
)
SELECT *
FROM state_performance
ORDER BY Revenue DESC
limit 10;
-- LOSS-MAKING STATES
WITH state_performance AS (
	SELECT 
		state,
		ROUND(SUM(sales), 2) AS Revenue,
		ROUND(SUM(profit), 2) AS Profit
	FROM superstore
	GROUP BY state
)
SELECT *
FROM state_performance
WHERE Profit < 0
ORDER BY Profit;

-- 7. Are there geographic markets where high sales volumes are not translating into strong profitability?
-- CALCULATE REVENUE & PROFIT BY STATES
WITH state_performance AS (
	SELECT
		state,
        ROUND(SUM(sales),2) AS Revenue,
        ROUND(SUM(profit),2)AS Profit,
        ROUND((SUM(profit) / SUM(sales)) * 100 , 2) AS "Profit Margin %"
	FROM superstore
    GROUP BY state
)
SELECT *
FROM state_performance
ORDER BY Revenue desc;
-- FIND THE HIGHH REVENUE BUT LOW PROFIT STATES
WITH state_performance AS (
	SELECT
		state,
        ROUND(SUM(sales),2) AS Revenue,
        ROUND(SUM(profit),2)AS Profit,
        ROUND((SUM(profit) / SUM(sales)) * 100 , 2) AS "Profit Margin %"
	FROM superstore
    GROUP BY state
)
SELECT * 
FROM state_performance
WHERE Revenue >
(
	SELECT AVG(Revenue)
    FROM state_performance
)
AND "Profit Margin %" < 5
ORDER BY Revenue DESC;

-- 8. What is the impact of discounting strategies on revenue growth and profit margins?
SELECT 
    discount,
    ROUND(SUM(sales), 2) AS Revenue,
    ROUND(SUM(profit), 2) AS Profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS 'Profit Margin %'
FROM
    superstore
GROUP BY discount
ORDER BY discount;

-- 9. How does shipping performance influence operational efficiency and customer service effectiveness?
SELECT 
    shipping_days,
    ROUND(SUM(sales), 2) AS Revenue,
    ROUND(SUM(profit), 2) AS Profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS 'Profit Margin %'
FROM
    superstore
GROUP BY shipping_days
ORDER BY shipping_days;

-- Which customer segments generate the highest revenue, profit, and profit margin?
SELECT 
    segment,
    ROUND(SUM(sales), 2) AS Revenue,
    ROUND(SUM(profit), 2) AS Profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS 'Proft Margin %'
FROM
    superstore
GROUP BY segment
ORDER BY Profit DESC;