SELECT UserID,
       SUM(CASE WHEN fl.EventID = 1 THEN 1 ELSE 0 END) AS VIEWEDHELPCENTERPAGE,
       SUM(CASE WHEN fl.EventID = 2 THEN 1 ELSE 0 END) AS CLICKEDFAQS,
       SUM(CASE WHEN fl.EventID = 3 THEN 1 ELSE 0 END) AS CLICKEDCONTACTSUPPORT,
       SUM(CASE WHEN fl.EventID = 4 THEN 1 ELSE 0 END) AS SUBMITTEDTICKET
FROM FrontendEventLog fl
LEFT JOIN FrontendEventDefinitions fd
ON fl.EventID = fd.EventID
WHERE EventType = 'Customer Support'
GROUP BY UserID
ORDER BY UserID