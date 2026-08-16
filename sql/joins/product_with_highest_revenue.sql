-- Database: Northwind
--
-- Purpose:
-- Find the product with the highest revenue.
--
-- The total revenue per product is calculated as:
-- TotalRevenue = SUM(Unit Price x Quantity)
--
-- The query joins the OrderDetails, Products, and Customers
-- tables, groups the results by product, and returns the product
-- with the highest total revenue.

SELECT od.ProductID,
	   p.ProductName,
	   SUM(p.Price * od.Quantity) AS TotalRevenue
FROM OrderDetails od
JOIN Products p
	ON p.ProductID = od.ProductID
GROUP BY od.ProductID, p.ProductName
ORDER BY TotalRevenue DESC
LIMIT 1;