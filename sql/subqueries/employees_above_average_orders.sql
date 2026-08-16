-- Database: Northwind
--
-- Purpose:
-- Retrieve employees whose total number of orders is greater than the
-- average number of orders per employee.
--
-- Concepts practiced:
-- - Scalar subqueries
-- - Aggregate functions (COUNT, AVG)
-- - GROUP BY
-- - HAVING
-- - ORDER BY

SELECT EmployeeID,
       -- Retrieve the employee's first and last name using scalar subqueries.
       (SELECT FirstName
        FROM Employees
        WHERE EmployeeID = Orders.EmployeeID) AS FirstName,
       (SELECT LastName
        FROM Employees
        WHERE EmployeeID = Orders.EmployeeID) AS LastName,
       COUNT(EmployeeID) AS TotalOrders
FROM Orders
GROUP BY EmployeeID
HAVING TotalOrders > (
                      -- Calculate the average number of orders per employee.
                      SELECT AVG(TotalOrders)
                      FROM (
                           SELECT COUNT(*) AS TotalOrders
                           FROM Orders
                           GROUP BY EmployeeID
                      )
)
ORDER BY TotalOrders DESC;
