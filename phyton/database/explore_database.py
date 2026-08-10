# Database: Northwind
#
# Purpose:
# Explore the database structure by listing all user-defined tables
# and counting the number of rows in each table.
#
# Concepts practiced:
# - sqlite3
# - Database connections
# - SQL queries from Python
# - Query results with fetchall() and fetchone()
# - pathlib


import sqlite3
from pathlib import Path

# Database path relative to the project root.
DB_PATH = Path(__file__).resolve().parents[2] / "database" / "northwind.db"


with sqlite3.connect(DB_PATH) as nw:
    
    cursor = nw.cursor()
    
    # Retrieve all user-defined tables from the database.
    # sqlite_sequence is excluded because it is an internal SQLite table.
    cursor.execute('''
                   SELECT name
                   FROM sqlite_master
                   WHERE type = "table" 
                        AND name != "sqlite_sequence"
                   ''')
    
    tables = cursor.fetchall()
    
    
    # Count and display the number of rows in each table.
    for (table,) in tables:
        cursor.execute(f'''
                       SELECT COUNT(*) 
                       FROM {table}
                       ''')
        
        rows = cursor.fetchone()[0]
        
        print(f'{table}: {rows} rows')