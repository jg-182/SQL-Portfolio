WITH all_cancelation_reasons AS(

SELECT SubscriptionID, CancelationReason1 cancelationreason
FROM Cancelations

UNION
SELECT SubscriptionID, CancelationReason2 cancelationreason
FROM Cancelations

UNION
SELECT SubscriptionID, CancelationReason3 cancelationreason
FROM Cancelations
)

SELECT 
    CAST(COUNT(
        CASE WHEN cancelationreason = 'Expensive' 
        THEN subscriptionid END) AS FLOAT)
    /COUNT(DISTINCT subscriptionid) AS percent_expensive
FROM    
    all_cancelation_reasons