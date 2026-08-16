-- Database: Northwind
--
-- Purpose:
-- Find the customers with no registered orders.
--
-- The query joins the Orders and Customers tables with 
-- a left join, and returns a list with the customers 
-- with no orders registered.

SELECT c.CustomerID,
	   c.CustomerName
FROM Customers c
LEFT JOIN Orders o
	ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL;