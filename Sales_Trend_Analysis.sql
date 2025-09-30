-- Basic monthly aggregation using EXTRACT function
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month,
    SUM(`Total Revenue`) AS Monthly_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume
FROM `online sales data`
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
         EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d'))
ORDER BY Year, Month;

-- Enhanced version with month names and additional metrics
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month,
    MONTHNAME(STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month_Name,
    SUM(`Total Revenue`) AS Monthly_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume,
    ROUND(AVG(`Total Revenue`), 2) AS Average_Order_Value,
    SUM(`Units Sold`) AS Total_Units_Sold
FROM `online sales data`
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
         EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')),
         MONTHNAME(STR_TO_DATE(`Date`, '%Y-%m-%d'))
ORDER BY Year, Month;


-- Limit results to specific time periods (e.g., 2024 data only)
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month,
    SUM(`Total Revenue`) AS Monthly_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume
FROM `online sales data`
WHERE STR_TO_DATE(`Date`, '%Y-%m-%d') >= '2024-01-01' 
    AND STR_TO_DATE(`Date`, '%Y-%m-%d') <= '2024-12-31'
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
         EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d'))
ORDER BY Year, Month;


-- Monthly trend with period-over-period comparison
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month,
    SUM(`Total Revenue`) AS Monthly_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume,
    LAG(SUM(`Total Revenue`)) OVER (ORDER BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
                                             EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d'))) AS Previous_Month_Revenue,
    ROUND(((SUM(`Total Revenue`) - LAG(SUM(`Total Revenue`)) OVER (ORDER BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
                                                                            EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')))) / 
           LAG(SUM(`Total Revenue`)) OVER (ORDER BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
                                                   EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')))) * 100, 2) AS Revenue_Growth_Percent
FROM `online sales data`
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
         EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d'))
ORDER BY Year, Month;


-- Monthly analysis by product category
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month,
    `Product Category`,
    SUM(`Total Revenue`) AS Monthly_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume,
    SUM(`Units Sold`) AS Total_Units_Sold,
    ROUND(SUM(`Total Revenue`) / SUM(`Units Sold`), 2) AS Revenue_Per_Unit
FROM `online sales data`
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
         EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')),
         `Product Category`
ORDER BY Year, Month, Monthly_Revenue DESC;


-- Monthly analysis by geographic region
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month,
    `Region`,
    SUM(`Total Revenue`) AS Monthly_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume,
    ROUND(AVG(`Total Revenue`), 2) AS Average_Transaction_Value
FROM `online sales data`
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
         EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')),
         `Region`
ORDER BY Year, Month, Monthly_Revenue DESC;


-- Quarterly revenue and volume analysis
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Year,
    EXTRACT(QUARTER FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Quarter,
    CONCAT('Q', EXTRACT(QUARTER FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), ' ', EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d'))) AS Quarter_Label,
    SUM(`Total Revenue`) AS Quarterly_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume,
    SUM(`Units Sold`) AS Total_Units_Sold
FROM `online sales data`
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')),
         EXTRACT(QUARTER FROM STR_TO_DATE(`Date`, '%Y-%m-%d')),
         CONCAT('Q', EXTRACT(QUARTER FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), ' ', EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')))
ORDER BY Year, Quarter;



-- Comprehensive monthly sales dashboard
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month,
    MONTHNAME(STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month_Name,
    SUM(`Total Revenue`) AS Monthly_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume,
    SUM(`Units Sold`) AS Total_Units_Sold,
    ROUND(AVG(`Total Revenue`), 2) AS Average_Transaction_Value,
    MIN(`Total Revenue`) AS Min_Transaction_Value,
    MAX(`Total Revenue`) AS Max_Transaction_Value,
    COUNT(DISTINCT `Product Category`) AS Categories_Sold,
    COUNT(DISTINCT `Region`) AS Active_Regions,
    COUNT(DISTINCT `Payment Method`) AS Payment_Methods_Used
FROM `online sales data`
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
         EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')),
         MONTHNAME(STR_TO_DATE(`Date`, '%Y-%m-%d'))
ORDER BY Year, Month;


-- Identify top performing months across all years
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month,
    MONTHNAME(STR_TO_DATE(`Date`, '%Y-%m-%d')) AS Month_Name,
    SUM(`Total Revenue`) AS Monthly_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume,
    RANK() OVER (ORDER BY SUM(`Total Revenue`) DESC) AS Revenue_Rank
FROM `online sales data`
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(`Date`, '%Y-%m-%d')), 
         EXTRACT(MONTH FROM STR_TO_DATE(`Date`, '%Y-%m-%d')),
         MONTHNAME(STR_TO_DATE(`Date`, '%Y-%m-%d'))
ORDER BY Monthly_Revenue DESC
LIMIT 12;





