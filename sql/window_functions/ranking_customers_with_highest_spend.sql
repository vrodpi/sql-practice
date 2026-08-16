-- Database: Northwind
--
-- Purpose:
-- Create a ranking of the customers with most money spent across all orders.
--
-- The total amount spent by each customer is calculated as:
-- TotalSpent = SUM(Quantity × Unit Price)
--
-- The query joins the Orders, OrderDetails, Products, and Customers
-- tables, groups the results by customer, and returns a ranking
-- of the customers with highest spend using window functions.


SELECT c.CustomerID,
	   c.CustomerName,
	   SUM(p.Price * od.Quantity) AS TotalSpent,
	   RANK() OVER (
			ORDER BY SUM(p.Price * od.Quantity) DESC) AS Ranking
FROM Customers c
JOIN Orders o
	ON o.CustomerID = c. CustomerID
JOIN OrderDetails od
	ON od.OrderID = o.OrderID
JOIN Products p
	ON p.ProductID = od.ProductID
GROUP BY c.CustomerID, c.CustomerName;