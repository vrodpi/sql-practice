# Database: Northwind
#
# Purpose:
# Retrieve the 10 customers with the highest total spending.
#
# Total spending is calculated as:
# TotalSpent = Quantity × Unit Price
#
# Concepts practiced:
# - sqlite3
# - pandas.read_sql_query()
# - SQL JOINs
# - Aggregate functions (SUM)
# - GROUP BY
# - ORDER BY
# - LIMIT


import sqlite3
import pandas as pd
from pathlib import Path

# Database path relative to the project root.
DB_PATH = Path(__file__).resolve().parents[2] / 'database' / 'northwind.db'

with sqlite3.connect(DB_PATH) as nw:
    
    # Calculate the total amount spent by each customer
    # and retrieve the top 10 customers.
    query = '''
        SELECT c.CustomerName,
               SUM(od.Quantity * p.Price) AS TotalSpent
        FROM Orders o
        JOIN OrderDetails od
            ON od.OrderID = o.OrderID
        JOIN Products p
            ON p.ProductID = od.ProductID
        JOIN Customers c
            ON c.CustomerID = o.CustomerID
        GROUP BY o.CustomerID, c.CustomerName
        ORDER BY TotalSpent DESC
        LIMIT 10
    '''
    
    customers_by_total_spent = pd.read_sql_query(query, nw)

print(customers_by_total_spent)