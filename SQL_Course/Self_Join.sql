SELECT e.EmployeeID,
       e.Name Employee_Name,
       m.Name Manager_Name,
       COALESCE(m.email, e.email) Contact_Email
FROM Employees e
LEFT JOIN Employees m
ON e.ManagerID = m.EmployeeID
WHERE e.Department = 'Sales'