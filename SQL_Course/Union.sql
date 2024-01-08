With all_subscriptions as(
SELECT *
FROM SubscriptionsProduct1
WHERE Active = 1

UNION
SELECT *
FROM SubscriptionsProduct2
WHERE Active = 1
)
select
	date_trunc('year', expirationdate) as exp_year, 
	count(*) as subscriptions
from 
	all_subscriptions
group by 
	date_trunc('year', expirationdate)