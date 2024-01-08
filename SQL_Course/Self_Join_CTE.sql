WITH monthly_revenue AS (
SELECT 
    date_trunc('month', orderdate) AS order_month, 
    SUM(revenue) AS monthly_revenue
FROM 
    subscriptions
GROUP BY
    date_trunc('month', orderdate)
)

SELECT current.order_month CURRENT_MONTH,
       previous.order_month PREVIOUS_MONTH,
       current.monthly_revenue CURRENT_REVENUE,
       previous.monthly_revenue PREVIOUS_REVENUE
FROM monthly_revenue current
JOIN monthly_revenue previous
WHERE current.monthly_revenue > previous.monthly_revenue
AND datediff('month', previous.order_month, current.order_month) = 1