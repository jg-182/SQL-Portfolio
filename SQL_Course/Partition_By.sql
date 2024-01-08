SELECT s.SalesEmployeeID, s.SaleDate, s.SaleAmount, 
       SUM(s.SaleAmount) OVER(PARTITION BY s.SalesEmployeeID ORDER BY s.SaleDate) Running_Total,
       CAST(SUM(s.SaleAmount) OVER(PARTITION BY s.SalesEmployeeID ORDER BY s.SaleDate) AS FLOAT) / e.Quota  Percent_Quota  
FROM Sales s
LEFT JOIN Employees e
ON s.SalesEmployeeID = e.EmployeeID
ORDER BY s.SalesEmployeeID, s.SaleDate