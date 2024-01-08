WITH maxstatus_reached AS (
SELECT SubscriptionID,
	   MAX(StatusID) maxstatus
FROM PaymentStatusLog
GROUP BY SubscriptionID
),
cat_status AS (
SELECT Subscriptions.SubscriptionID, 
	case when maxstatus = 1 then 'PaymentWidgetOpened'
		when maxstatus = 2 then 'PaymentEntered'
		when maxstatus = 3 and currentstatus = 0 then 'User Error with Payment Submission'
		when maxstatus = 3 and currentstatus != 0 then 'Payment Submitted'
		when maxstatus = 4 and currentstatus = 0 then 'Payment Processing Error with Vendor'
		when maxstatus = 4 and currentstatus != 0 then 'Payment Success'
		when maxstatus = 5 then 'Complete'
		when maxstatus is null then 'User did not start payment process'
		end as paymentfunnelstage
FROM Subscriptions
LEFT JOIN maxstatus_reached
ON Subscriptions.SubscriptionID = maxstatus_reached.SubscriptionID
)
SELECT paymentfunnelstage, COUNT(SubscriptionID) subscriptions
FROM cat_status
GROUP BY paymentfunnelstage 