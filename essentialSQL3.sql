-- Comment: 

/* SQL Practices */
SELECT c.FirstName || " " || c.LastName as Name, i.total, length(i.BillingAddress) as len, upper(substr(i.BillingAddress,1,5)) as [test address], strftime('%Y-%m-%d',e.BirthDate) as BDAY,
(strftime('%Y-%m-%d','Now')-strftime('%Y-%m-%d',e.BirthDate)) as Age, count(*), round(avg(i.total),2)
FROM Customer as c INNER JOIN Invoice as i ON c.CustomerId = i.CustomerId INNER JOIN Employee as e ON c.SupportRepId=e.EmployeeId
--WHERE i.total <100
ORDER BY i.total DESC;