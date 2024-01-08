SELECT CustomerID, 
       COUNT(ProductID) NUM_PRODUCTS,
       SUM(NumberofUsers) TOTAL_USERS,
       CASE WHEN (SUM(NumberofUsers) >= 5000 OR COUNT(ProductID) = 1) THEN 1
            ELSE 0
        END UPSELL_OPPORTUNITY
FROM Subscriptions
GROUP BY CustomerID