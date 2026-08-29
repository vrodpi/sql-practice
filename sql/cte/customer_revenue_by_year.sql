-- Database: Northwind
--
-- Purpose:
-- Calculate the yearly growth in total revenue by customer, 
-- only customers with orders in 1996 and 1997 are considered.
--
-- Yearly growth is calculated as:
-- Growth = 1997 Revenue - 1996 Revenue 
-- 
-- The query uses CTE to return CustomerRevenue table with the 
-- yearly total revenue by customer. 
-- A second table, YearlyRevenue, is used to split the column 'Year' 
-- in two differents columns: 'Revenue1996' and 'Revenue1997'.
-- Finally, the revenue growth per customer is retrieved. 


WITH CustomerRevenue AS (
	SELECT c.CustomerID,
		   c.CustomerName,
		   strftime('%Y', o.OrderDate) AS Year,
		   SUM(p.Price * od.Quantity) AS Revenue
	FROM Orders o
	JOIN Customers c
		ON c.CustomerID = o.CustomerID
	JOIN OrderDetails od
		ON od.OrderID = o.OrderID
	JOIN Products p
		ON p.ProductID = od.ProductID
	GROUP BY c.CustomerID, c.CustomerName, Year
), 
YearlyRevenue AS (
SELECT CustomerID,
	   CustomerName,
	   SUM(CASE WHEN Year = '1996' THEN Revenue END) AS Revenue1996,
	   SUM(CASE WHEN Year = '1997' THEN Revenue END) AS Revenue1997
FROM CustomerRevenue
GROUP BY CustomerID, CustomerName
)
SELECT CustomerID,
	   CustomerName,
	   Revenue1996,
	   Revenue1997,
	   Revenue1997 - Revenue1996 AS Growth
FROM YearlyRevenue
WHERE Revenue1996 IS NOT NULL
	  AND Revenue1997 IS NOT NULL
ORDER BY Growth DESC;