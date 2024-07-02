-- Comment

SELECT 
	c.LastName,
	c.FirstName,
	i.InvoiceId,
	i.CustomerId,
	i.InvoiceDate,
	e.EmployeeId,
	c.SupportRepId,
	i.total
FROM 
	Invoice AS i
INNER JOIN 
	Customer AS c
ON 
	i.CustomerId = c.CustomerId
INNER JOIN Employee AS e ON c.SupportRepId = e.EmployeeId	
ORDER BY 
	i.total DESC
LIMIT 10