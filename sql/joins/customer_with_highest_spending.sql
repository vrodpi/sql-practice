-- Database: Northwind
--
-- Purpose:
-- Find the customer who has spent the most money across all orders.
--
-- The total amount spent by each customer is calculated as:
-- TotalSpent = SUM(Quantity × Unit Price)
--
-- The query joins the Orders, OrderDetails, Products, and Customers
-- tables, groups the results by customer, and returns the customer
-- with the highest total spending.

SELECT c.CustomerID,
	   c.CustomerName,
	   SUM(od.Quantity * p.Price) AS TotalSpent
FROM OrderDetails od
JOIN Orders o 
	ON od.OrderID = o.OrderID 
JOIN Products p
	ON od.ProductID = p.ProductID 
JOIN Customers c
	ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSpent DESC
LIMIT 1
