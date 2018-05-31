WITH YoY (YearN, MonthN, Sales) AS (
	SELECT EXTRACT(YEAR FROM invoice_date) as YearN, EXTRACT(MONTH FROM invoice_date) as MonthN, SUM(line_total) as Sales
	FROM invoices as inv
	JOIN invoicelines as invl ON inv.invoiceid = invl.invoiceid
	GROUP BY 2, 1
	ORDER BY 1 DESC, 2 DESC
)
SELECT * FROM YoY