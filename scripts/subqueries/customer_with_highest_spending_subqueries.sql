-- Purpose:
-- Identify the client with highest total spend (Units Ordered x Cost per Unit)
-- using subqueries.
--
-- Exercise:
-- Practice using subqueries with multiple tables (Products, Orders, OrderDetails, Customers) 
-- to return the client with the highest money spent.


SELECT CustomerID,
	   CustomerName,
	   SUM(Quantity * PricexUnit) AS TotalSpent
FROM (
	-- Subqueries are used to retrieve the customer name and ID, and the product price.
	SELECT 
			-- Subquerie to retrieve CustomerID from Customers and Orders tables.
			(SELECT CustomerID 
				FROM Customers 
				WHERE CustomerID = (SELECT CustomerID 
									FROM Orders 
									WHERE OrderID = OrderDetails.OrderID)) AS CustomerID,
									
			-- Subquerie to retrieve CustomerName from Customers and Orders tables.
		    (SELECT CustomerName 
				FROM Customers 
				WHERE CustomerID = (SELECT CustomerID 
									FROM Orders 
									WHERE OrderID = OrderDetails.OrderID)) AS CustomerName,
									
		    Quantity,
			
			-- Subquerie to retrieve the product price from Products table.
			(SELECT Price 
				FROM Products 
				WHERE ProductID = OrderDetails.ProductID) AS PricexUnit
	FROM OrderDetails
)
GROUP BY CustomerID
HAVING TotalSpent = (

	-- Subqueries are used to calculate the maximum spent instead of "LIMIT 1".
	SELECT MAX(TotalSpent)
	FROM (
		SELECT SUM(Quantity * PricexUnit) AS TotalSpent
		FROM (
			SELECT (SELECT CustomerID 
					FROM Customers 
					WHERE CustomerID = (SELECT CustomerID 
										FROM Orders 
										WHERE OrderID = OrderDetails.OrderID)) AS CustomerID,
					Quantity,
					(SELECT Price 
					 FROM Products 
					 WHERE ProductID = OrderDetails.ProductID) AS PricexUnit
			FROM OrderDetails
			)
		GROUP BY CustomerID
		)
);
