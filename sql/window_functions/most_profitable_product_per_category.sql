-- Database: Northwind
--
-- Purpose:
-- Find the product with the highest revenue in each category.
--
-- The total revenue per product is calculated as:
-- TotalRevenue = SUM(Unit Price x Quantity)
--
-- The querie uses CTE to retrieve RankedCategories table with a 
-- ranking with the most profitable product per category using
-- window functions. Then the first product is selected.


WITH RankedCategories AS (
	SELECT c.CategoryID,
		   c.CategoryName,
		   p.ProductID,
		   p.ProductName,
		   SUM(p.Price * od.Quantity) AS TotalRevenue,

		   -- Calculates the ranking of products in each category
           ROW_NUMBER() OVER(
				PARTITION BY c.CategoryName
				ORDER BY SUM(p.Price * od.Quantity) DESC
				) AS Ranking
	FROM Products p
	JOIN Categories c
		ON c.CategoryID = p.CategoryID
	JOIN OrderDetails od
		ON od.ProductID = p.ProductID
	GROUP BY c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
)
SELECT CategoryName,
	   ProductName,
	   TotalRevenue
FROM RankedCategories
WHERE Ranking = 1;