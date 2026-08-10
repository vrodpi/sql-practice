# Database: Northwind
#
# Purpose:
# Retrieve the 10 products with more units sold and display the 
# total qunatity and the corresponding product names.
#
# Concepts practiced:
# - sqlite3
# - pandas.read_sql_query()
# - SQL JOINs
# - GROUP BY
# - ORDER BY
# - LIMIT


import sqlite3
import pandas as pd
from pathlib import Path

# Database path relative to the project root.
DB_PATH = Path(__file__).resolve().parents[2] / 'database' / 'northwind.db'

with sqlite3.connect(DB_PATH) as nw:
    
    # Retrieve the 10 products with more units sold.    
    query = '''
        SELECT ProductName, 
               SUM(Quantity) as TotalQuantity
        FROM OrderDetails od
        JOIN Products p
            ON od.ProductID = p.ProductID
        GROUP BY od.ProductID
        ORDER BY TotalQuantity DESC
        LIMIT 10
    '''
    
    top_10_products = pd.read_sql_query(query, nw)

print(top_10_products)