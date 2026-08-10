# Database: Northwind
#
# Purpose:
# Retrieve the 10 customers with the highest number of orders.
#
# Concepts practiced:
# - sqlite3
# - pandas.read_sql_query()
# - SQL JOINs
# - Aggregate functions (COUNT)
# - GROUP BY
# - ORDER BY
# - LIMIT


import sqlite3
import pandas as pd
from pathlib import Path

# Database path relative to the project root.
DB_PATH = Path(__file__).resolve().parents[2] / 'database' / 'northwind.db'

with sqlite3.connect(DB_PATH) as nw:
    
    # Count the number of orders placed by each customer
    # and retrieve the top 10 customers.
    query = '''
        SELECT CustomerName,
               COUNT(o.OrderID) as TotalOrders
        FROM Orders o
        JOIN Customers c
            ON o.CustomerID = c.CustomerID
        GROUP BY o.CustomerID
        ORDER BY TotalOrders DESC
        LIMIT 10
    '''
    
    top_10_customers = pd.read_sql_query(query, nw)

print(top_10_customers)