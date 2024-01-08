SELECT StatusMovementID,
       SubscriptionID,
       StatusID,
       MovementDate,
       LEAD(MovementDate, 1) OVER(ORDER BY MovementDate) NextStatusMovementDate,
       LEAD(MovementDate, 1) OVER(ORDER BY MovementDate) - MovementDate TimeInStatus
FROM PaymentStatusLog
WHERE SubscriptionID = 38844