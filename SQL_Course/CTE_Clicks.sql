WITH users_clicks AS (
SELECT fl.USERID, COUNT(*) NUM_LINK_CLICKS
FROM frontendeventlog fl
JOIN frontendeventdefinitions fd
ON fl.EVENTID = fd.EVENTID
WHERE fl.EVENTID = 5
GROUP BY fl.USERID
)
SELECT NUM_LINK_CLICKS, COUNT(*) NUM_USERS
FROM users_clicks
GROUP BY NUM_LINK_CLICKS