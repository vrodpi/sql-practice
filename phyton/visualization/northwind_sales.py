import sqlite3
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter
from pathlib import Path

DB_PATH = Path(__file__).resolve().parents[2] / 'database' / 'northwind.db'

with sqlite3.connect(DB_PATH) as nw:
    query = '''
        SELECT od.ProductID,
               p.ProductName,
               SUM(p.Price * od.Quantity) AS TotalRevenue
        FROM OrderDetails od
        JOIN Products p
            ON p.ProductID = od.ProductID
        GROUP BY od.ProductID
        ORDER BY TotalRevenue DESC
        LIMIT 10
    '''
    revenue_by_product = pd.read_sql_query(query, nw)
        

revenue_by_product.plot(
    x = 'ProductName', y = 'TotalRevenue', 
    kind = 'bar', legend = False,
    figsize = (10, 7), zorder = 2
    )

plt.title('TOP 10 PRODUCTS BY REVENUE', fontsize = 15, fontweight = 'bold')

plt.xlabel('Product Name', fontsize = 14)
plt.xticks(rotation = 45)

plt.ylabel('Revenue', fontsize = 14)
plt.gca().yaxis.set_major_formatter('${x:,.0f}')

plt.tight_layout()
plt.grid(True, zorder = 0)

PLOT_PATH = Path(__file__).resolve().parents[1] / 'reports' / 'top_products_by_revenue.png'
plt.savefig(PLOT_PATH)
    