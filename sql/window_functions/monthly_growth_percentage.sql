-- Database: Northwind
--
-- Purpose:
-- Calculate the company growth percentage per month.
--
-- The monthly growth percentage is calculated as:
-- (CurrentMonthRevenue - PreviousMonthRevenue) / PreviousMonthRevenue * 100
--
-- The querie uses CTE to retrieve MonthlyRevenue table with the 
-- current month revenue and the previous month revenue using
-- window functions. 
-- Then the monthly growth percentage is retrieved.


WITH MonthlyRevenue AS (
	SELECT strftime('%Y', o.OrderDate) AS Year,
		   strftime('%m', o.OrderDate) AS Month,
		   SUM(p.Price * od.Quantity) AS TotalRevenue,

           -- Retrieves the previous month revenue
		   LAG(SUM(p.Price * od.Quantity)) OVER(
						ORDER BY strftime('%Y', o.OrderDate),
						  		 strftime('%m', o.OrderDate)
						) AS PreviousMonthRevenue
	FROM Orders o
	JOIN OrderDetails od
		ON od.OrderID = o.OrderID
	JOIN Products p
		ON p.ProductID = od.ProductID
	GROUP BY Year, Month
	ORDER BY Year, Month
)
SELECT *,
       -- Calculates the monthly growth percentage
	   ROUND(
			(TotalRevenue - PreviousMonthRevenue) 
			/ PreviousMonthRevenue * 100, 2
			) AS GrowthPercentage
FROM MonthlyRevenue;