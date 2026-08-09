import sqlite3
import pandas as pd
from pathlib import Path

DB_PATH = Path(__file__).resolve().parents[2] / "database" / "northwind.db"

with sqlite3.connect(DB_PATH) as nw:
    
    cursor = nw.cursor()
    
    cursor.execute('''
                   SELECT *
                   FROM Orders
                   ''')
    orders = cursor.fetchall()
    orders = pd.DataFrame(orders)
    print(orders)