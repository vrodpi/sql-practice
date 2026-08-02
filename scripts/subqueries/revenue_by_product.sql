-- Database: Northwind
--
-- Purpose:
-- Calculate the total number of units sold and the total revenue
-- generated for each product.
--
-- Revenue is calculated as:
-- Revenue = Unit Price × Total Quantity Sold
--
-- Concepts practiced:
-- - Scalar subqueries
-- - Aggregate functions (SUM)
-- - GROUP BY
-- - Calculated columns
--
-- Note:
-- Product names and prices are retrieved using scalar subqueries.
-- In a production environment, JOINs would typically be preferred
-- for better readability and performance.

SELECT *,
       Price * Quantity AS Revenue
FROM (
    -- Group order details by product and calculate the total quantity sold.
    -- Scalar subqueries retrieve the product name and unit price.
    SELECT ProductID,
           (SELECT ProductName
              FROM Products
             WHERE OrderDetails.ProductID = ProductID) AS Name,
           (SELECT Price
              FROM Products
             WHERE OrderDetails.ProductID = ProductID) AS Price,
           SUM(Quantity) AS Quantity
    FROM OrderDetails
    GROUP BY ProductID
)
-- Sort products by revenue in descending order.
ORDER BY Revenue DESC;
