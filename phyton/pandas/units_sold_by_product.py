# Database: Northwind
#
# Purpose:
# Calculate the products with more units sold using pandas.
#
# Concepts practiced:
# - sqlite3
# - pandas.read_sql_query()
# - DataFrame column selection
# - merge()
# - groupby()
# - sort_values()
# - reset_index()


import sqlite3
import pandas as pd
from pathlib import Path

# Database path relative to the project root.
DB_PATH = Path(__file__).resolve().parents[2] / 'database' / 'northwind.db'

with sqlite3.connect(DB_PATH) as nw:
    query_od = '''
        SELECT *
        FROM OrderDetails od
    '''
    order_details = pd.read_sql_query(query_od, nw)
    
    query_p = '''
        SELECT ProductID,
               ProductName
        FROM Products p
    '''
    products = pd.read_sql_query(query_p, nw)
    
# Combine product name with order details using ProductID.
units_sold = products.merge(order_details, on = 'ProductID')

# Aggregate units sold by product, sorting from lowest to highest
# and reset the dataframe index
units_sold = (
    units_sold
    .groupby(['ProductID', 'ProductName'], as_index = False)['Quantity']
    .sum()
    .sort_values('Quantity', ascending = False)
    .reset_index(drop = True)
)

print(units_sold.head())
    