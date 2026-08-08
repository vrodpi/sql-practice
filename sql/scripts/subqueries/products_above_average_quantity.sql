-- Database: Northwind
--
-- Purpose:
-- Retrieve products whose ordered quantity is greater than the average
-- quantity across all order details.
--
-- Concepts practiced:
-- - Scalar subqueries
-- - Aggregate functions (AVG)
-- - GROUP BY
-- - ORDER BY

SELECT ProductID,
       (
        -- Retrieve the corresponding product name.
        SELECT ProductName
        FROM Products
        WHERE ProductID = OrderDetails.ProductID
       ) AS ProductName,
       Quantity 
FROM OrderDetails
WHERE Quantity > (
                   -- Calculate the average quantity across all order details.
                   SELECT AVG(Quantity)
                   FROM OrderDetails
                 )
GROUP BY ProductID
ORDER BY Quantity DESC;
