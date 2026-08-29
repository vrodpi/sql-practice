-- Database: Northwind
--
-- Purpose:
-- Classify customers in segments by loyalty and retrieve the average spent by segment.
--
-- Customers are classified in segments according to the number of orders made.
--
-- The total spent per customer is calculated as:
-- TotalSpent = SUM(Quantity x Unit Price)
-- 
-- The query uses CTE to return CustomerLoyalty table with the number
-- of orders per CustomerID, the corresponding segment, and the total
-- spent.
-- Then the total customers per segment and the average total sepnt are returned.


WITH CustomerLoyalty AS (
	SELECT c.CustomerID,
		   COUNT(DISTINCT o.OrderID) AS OrdersMade,

           -- Customers are classified in segments according
           -- to the orders made.
		   CASE 
				WHEN COUNT(DISTINCT o.OrderID) = 0 THEN 'No Orders'
				WHEN COUNT(DISTINCT o.OrderID) = 1 THEN 'One-time'
				WHEN COUNT(DISTINCT o.OrderID) BETWEEN 2 AND 5 THEN 'Returning'
				WHEN COUNT(DISTINCT o.OrderID) > 5 THEN 'Loyal'
		   END AS Segment,

           -- The total spent is calculated and NULL valors are
           -- replaced by 0.
		   COALESCE(SUM(p.Price * od.Quantity), 0) AS TotalSpent
	FROM Customers c
	LEFT JOIN Orders o
		ON o.CustomerID = c.CustomerID
	LEFT JOIN OrderDetails od
		ON od.OrderID = o.OrderID
	LEFT JOIN Products p
		ON p.ProductID = od.ProductID
	GROUP BY c.CustomerID
)
SELECT Segment,
	   COUNT(CustomerID) AS Customers,
	   ROUND(AVG(TotalSpent), 2) AS AverageSpent
FROM CustomerLoyalty
GROUP BY Segment
ORDER BY Customers DESC;