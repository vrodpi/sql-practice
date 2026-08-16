-- Database: Northwind
--
-- Purpose:
-- Find the month with the highest income.
--
-- The total income per month is calculated as:
-- Income = SUM(Quantity × Unit Price)
--
-- The query joins the Orders, OrderDetails, and Products tables,
-- groups the results by year and month, and returns the month
-- with the highest income.


SELECT strftime('%Y', o.OrderDate) AS Year,
	   strftime('%m', o.OrderDate) AS Month,
	   SUM(p.Price * od.Quantity) AS Income
FROM Orders o
JOIN OrderDetails od
	ON od.OrderID = o.OrderID
JOIN Products p
	ON p.ProductID = od.ProductID
GROUP BY Year, Month
ORDER BY Income DESC
LIMIT 1;