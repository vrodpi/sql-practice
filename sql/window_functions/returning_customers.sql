-- Database: Northwind
--
-- Purpose:
-- Calculate the percentage of returning customers over total customers.
--
-- Returning customers are considered as customers with 2 or more orders.
-- 
-- The query uses CTE to return OrdersPerCustomer table with the number
-- of orders per CustomerID (including customers with no orders).
-- Then the total customers, returning customers, and percentage of
-- returning customers are returned.


WITH OrdersPerCustomer AS (
	SELECT c.CustomerID,
		   COUNT(o.OrderID) AS OrdersMade
	FROM Customers c
	LEFT JOIN Orders o
		ON o.CustomerID = c.CustomerID
	GROUP BY c.CustomerID
)
SELECT COUNT(CustomerID) AS TotalCustomers,
       --Retrieves the customers with at least 2 orders
	   COUNT(CASE WHEN OrdersMade >= 2 THEN 1 END) AS ReturningCustomers,
	   ROUND(COUNT(CASE WHEN OrdersMade >= 2 THEN 1 END) * 100.0 
			/ COUNT(CustomerID)
			, 2
			) AS ReturningCustomerPercentage
FROM OrdersPerCustomer;