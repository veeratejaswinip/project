CREATE DATABASE ecommerce;
USE ecommerce;

SELECT * FROM ecommerce LIMIT 10;

SELECT * FROM ecommerce 
WHERE Return_Status = 'Returned';

SELECT 
    CASE 
        WHEN User_Age < 20 THEN 'Under 20'
        WHEN User_Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN User_Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN User_Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN User_Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END as AgeGroup,
    COUNT(*) as OrderCount
FROM ecommerce
GROUP BY AgeGroup
ORDER BY OrderCount DESC;

SELECT SUM(Product_Price * Order_Quantity) AS Total_Revenue 
FROM ecommerce;

SELECT AVG(Product_Price * Order_Quantity) AS Avg_Order_Value 
FROM ecommerce;

SELECT 
    Product_Category,
    SUM(Product_Price * Order_Quantity) AS Category_Revenue,
    ROUND(SUM(Product_Price * Order_Quantity) / 
        (SELECT SUM(Product_Price * Order_Quantity) FROM ecommerce) * 100, 2) AS Revenue_Percentage
FROM ecommerce
GROUP BY Product_Category
ORDER BY Category_Revenue DESC;

SELECT 
    Product_Category,
    AVG(Product_Price) AS Avg_Price,
    MIN(Product_Price) AS Min_Price,
    MAX(Product_Price) AS Max_Price
FROM ecommerce
GROUP BY Product_Category;

SELECT 
    Product_Category,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) AS Returned_Orders,
    ROUND(SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Return_Rate_Percentage
FROM ecommerce
GROUP BY Product_Category
ORDER BY Return_Rate_Percentage DESC;

SELECT 
    User_Gender,
    COUNT(*) AS Order_Count,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM ecommerce) * 100, 2) AS Percentage
FROM ecommerce
GROUP BY User_Gender;

SELECT 
    CASE
        WHEN Discount_Applied = 0 THEN 'No Discount'
        WHEN Discount_Applied < 10 THEN 'Small Discount (<10)'
        WHEN Discount_Applied < 20 THEN 'Medium Discount (10-19)'
        ELSE 'Large Discount (20+)'
    END AS Discount_Range,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) AS Returned_Orders,
    ROUND(SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Return_Rate
FROM ecommerce
GROUP BY Discount_Range
ORDER BY Discount_Range;

SELECT 
    Payment_Method,
    COUNT(*) AS Order_Count,
    SUM(Product_Price * Order_Quantity) AS Total_Revenue
FROM ecommerce
GROUP BY Payment_Method
ORDER BY Order_Count DESC;

SELECT 
    Shipping_Method,
    COUNT(*) AS Order_Count,
    AVG(Product_Price * Order_Quantity) AS Avg_Order_Value
FROM ecommerce
GROUP BY Shipping_Method
ORDER BY Avg_Order_Value DESC;