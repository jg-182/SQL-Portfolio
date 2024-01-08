WITH product_revenue AS (
SELECT p.ProductName, DATE_TRUNC('month', s.OrderDate), SUM(s.Revenue) revenue
FROM Subscriptions s
JOIN Products p
ON s.ProductID = p.ProductID
WHERE s.OrderDate BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY p.ProductName, DATE_TRUNC('month', s.OrderDate)
)

SELECT ProductName, 
    MIN(revenue) MIN_REV, 
    MAX(revenue) MAX_REV, 
    AVG(revenue) AVG_REV, 
    STDDEV(revenue) STD_DEV_REV
FROM product_revenue
GROUP BY ProductName