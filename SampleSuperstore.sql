-- Name of the Dataset: Superstore Dataset
-- Source: https://www.kaggle.com/datasets/vivek468/superstore-dataset-final/data

-- Check the dataset
SELECT * 
FROM SampleSuperstore

-- Remove Row_ID Column

ALTER TABLE dbo.SampleSuperstore
DROP COLUMN "Row_ID"

-- Check Country column

SELECT COUNT(DISTINCT Country) As Countries
FROM Project1..SampleSuperstore

-- Remove Country column

ALTER TABLE Project1..SampleSuperstore
DROP COLUMN Country

-- Change date format

UPDATE SampleSuperstore
SET Order_Date = CONVERT(Date,Order_Date), Ship_Date = CONVERT(Date,Ship_Date)

-- Delete rows with NULLS. These rows were deleted because we couldn't get any info of the sales 

SELECT *
FROM dbo.SampleSuperstore
WHERE Product_Name LIKE 'Imation%'
ORDER BY Product_Name

DELETE FROM SampleSuperstore
WHERE Sales IS NULL

-- Change data types

-- Sales

ALTER TABLE SampleSuperstore
Add SalesUpdate Float

UPDATE SampleSuperstore
SET SalesUpdate = CONVERT(Float, Sales)

-- Discount

ALTER TABLE SampleSuperstore
Add DiscountUpdate Float

UPDATE SampleSuperstore
SET DiscountUpdate = CONVERT(Float, Discount)

-- Profit

ALTER TABLE SampleSuperstore
Add ProfitUpdate Float

UPDATE SampleSuperstore
SET ProfitUpdate = CONVERT(Float, Profit)



-- DATA EXPLORATION

-- Total sales and total profit

SELECT ROUND(SUM(SalesUpdate),2) AS TotalSales, ROUND(SUM(ProfitUpdate),2) AS TotalProfit
FROM SampleSuperstore

-- Number of customers per state

SELECT COUNT(DISTINCT Customer_ID) AS NumberOfCustomers, State
FROM dbo.SampleSuperstore
GROUP BY State

-- Number of unique products that were sold

SELECT COUNT(DISTINCT Product_Name) AS NumberOfProducts
FROM dbo.SampleSuperstore

-- Sales and Profit by State

SELECT State, ROUND(SUM(SalesUpdate),2) AS SalesByState, ROUND(SUM(ProfitUpdate),2) AS ProfitByState
FROM SampleSuperstore
GROUP BY State
ORDER BY ProfitByState DESC

-- Sales by City on the top 3 states with the most sales

SELECT City, State, ROUND(SUM(SalesUpdate),2) AS SalesByCityTopStates
FROM SampleSuperstore
WHERE State IN ('California','New York','Texas')
GROUP BY City, State
ORDER BY SalesByCityTopStates DESC

-- Profit by City on the top 3 states with the most profit

SELECT City, State, ROUND(SUM(ProfitUpdate),2) AS ProfitByCityTopStates
FROM SampleSuperstore
WHERE State IN ('California','New York','Washington')
GROUP BY City, State
ORDER BY ProfitByCityTopStates DESC

-- Sales and Profit by Ship Mode

SELECT Ship_Mode, ROUND(SUM(SalesUpdate),2) AS SalesByShipMode, ROUND(SUM(ProfitUpdate),2) AS ProfitByShipMode
FROM SampleSuperstore
GROUP BY Ship_Mode
ORDER BY ProfitByShipMode DESC

-- Sales and Profit by Segment

SELECT Segment, ROUND(SUM(SalesUpdate),2) AS SalesBySegment, ROUND(SUM(ProfitUpdate),2) AS ProfitBySegment
FROM SampleSuperstore
GROUP BY Segment
ORDER BY ProfitBySegment DESC

-- Sales and Profit by Product Category and Subcategory

SELECT ISNULL(Category,'TOTAL') AS Category, ISNULL(Sub_Category,'SUBTOTAL') AS SubCategory, ROUND(SUM(SalesUpdate),2) AS Sales, ROUND(SUM(ProfitUpdate),2) AS Profit
FROM SampleSuperstore
GROUP BY ROLLUP(Category, Sub_Category)

-- Category Ranking by Sales per year

WITH CatYearRank AS
(SELECT YEAR(Order_Date) AS Year, Category, ROUND(SUM(SalesUpdate),2) AS SalesStateYear, 
       RANK() OVER (PARTITION BY YEAR(Order_Date) ORDER BY ROUND(SUM(SalesUpdate),2) DESC) AS CatRanking
FROM SampleSuperstore
GROUP BY YEAR(Order_Date), Category)
SELECT *
FROM CatYearRank
WHERE CatRanking BETWEEN 1 AND 3

-- Sales and Profits by Discount Provided

SELECT  DiscountUpdate, ROUND(SUM(SalesUpdate),2) SalesDiscount, ROUND(SUM(ProfitUpdate),2) ProfitDiscount
FROM SampleSuperstore
GROUP BY DiscountUpdate
ORDER BY DiscountUpdate DESC

-- Sales and Profit by Year
SELECT YEAR(Order_Date) AS Year, SUM(SalesUpdate) AS SalesByYear, ROUND(SUM(ProfitUpdate),2) AS ProfitByYear
FROM SampleSuperstore
GROUP BY YEAR(Order_Date)
ORDER BY ProfitByYear DESC

-- Top products by year

-- Sales

WITH ProductRank AS
(SELECT YEAR(Order_Date) AS Year, Product_Name, ROUND(SUM(SalesUpdate),2) AS SalesStateYear, 
       RANK() OVER (PARTITION BY YEAR(Order_Date) ORDER BY ROUND(SUM(SalesUpdate),2) DESC) AS Ranking
FROM SampleSuperstore
GROUP BY YEAR(Order_Date), Product_Name)
SELECT *
FROM ProductRank
WHERE Ranking BETWEEN 1 AND 3

-- Profit

WITH ProductsRank AS
(SELECT YEAR(Order_Date) AS Year, Product_Name, ROUND(SUM(ProfitUpdate),2) AS ProfitStateYear, 
       RANK() OVER (PARTITION BY YEAR(Order_Date) ORDER BY ROUND(SUM(ProfitUpdate),2) DESC) AS Rankings
FROM SampleSuperstore
GROUP BY YEAR(Order_Date), Product_Name)
SELECT *
FROM ProductsRank
WHERE Rankings BETWEEN 1 AND 3


-- Customers

-- Sales by Customers in the top 3 states with the most sales

SELECT Customer_Name, State, ROUND(SUM(SalesUpdate),2) AS SalesByCustomer
FROM SampleSuperstore
WHERE State IN ('California','New York','Texas')
GROUP BY Customer_Name, State
ORDER BY SalesByCustomer DESC

-- Profit by Customers in the top 3 states with the most profit
SELECT Customer_Name, State, ROUND(SUM(ProfitUpdate),2) AS ProfitByCustomer
FROM SampleSuperstore
WHERE State IN ('California','New York','Washington')
GROUP BY Customer_Name, State
ORDER BY ProfitByCustomer DESC


