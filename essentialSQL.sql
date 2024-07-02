-- This is a training content

/****************************************
 Created by: Golam Gause Jaman			
 Date: 06/11/2024						
 Description: Exploring SQL essentials	
*****************************************/

SELECT 
	InvoiceDate AS Date, 
	InvoiceId AS 'ID', 
	BillingPostalCode AS [ZIP/CODE],
	total AS Total,
	CASE 
		WHEN total < 2.0 THEN "BASE"
		WHEN total BETWEEN 2.0 AND 6.99 THEN "BASE"
		WHEN total > 6.99 AND total < 15.0 THEN "Target"
		ELSE "TOP!"
	END AS "Performers",
	BillingCity AS [City]

FROM 
	Invoice

WHERE
	--total >= 1.98 AND total <= 5.0
	--total BETWEEN 1.98 AND 5.0
	--total = 1.98 OR total = 3.96
	--total IN (1.98, 3.96) -- IN selected (items)
	--total BETWEEN 1.98 AND 5.0 AND (total <> 1.98 AND total <> 3.96)
	--BillingCity = "Brussels"
	--BillingCity IN ("Brussels",'Orlando', 'Paris')
	--BillingCity LIKE '%B%n' -- % as wild like * in some language
	--InvoiceDate = "2010-05-22 00:00:00"
	--InvoiceDate LIKE "2010-05-22 %"
	--DATE(InvoiceDate) > "2010-05-22" AND total < 3.0 
	--total > 1.98 AND ((BillingCity LIKE "P%") OR (BillingCity LIKE "D%"))
	Performers = "TOP!" AND DATE(InvoiceDate) > "2012-01-01"
	
ORDER BY
	InvoiceDate DESC; -- Use ASC for ascending order

-- LIMIT 10; -- ; for end of code