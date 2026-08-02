# SQL Practice

A collection of SQL practice scripts and exercises using the **Northwind** sample database.

## Repository Structure

```
.
├── database/
│   └── northwind.db
├── scripts/
│   └── best-selling_products.sql
│   └── highest_total_spend_client.sql
│   └── orders_per_employee.sql
│   └── revenue_by_product.sql
└── README.md
```

## About

This repository contains SQL queries and exercises completed while practicing SQL concepts.

The scripts focus on topics such as:

- SELECT statements
- Filtering and sorting
- Aggregations
- GROUP BY
- Subqueries
- Joins

More exercises will be added as I continue learning and practicing.

## Requirements

- DB Browser for SQLite (or any SQLite-compatible client)
- `northwind.db` included in this repository

## Running the Scripts

1. Open `database/northwind.db` in your preferred SQLite client.
2. Open any script from the `scripts/` directory.
3. Execute the query.

## Current Exercises

| Script | Description |
|---------|-------------|
| `best-selling_products.sql` | Calculates the best-selling products compared to the average of total products sold using subqueries. |
| `highest_total_spend_customer.sql` | Calculates the client with highest spend using subqueries and multiple tables. |
| `orders_per_employee.sql` | Calculates the employees with more orders than an average employee using subqueries. |
| `revenue_by_product.sql` | Calculates the total units sold and revenue generated for each product using subqueries. |
| `revenue_by_product_with_join.sql` | Calculates the total units sold and revenue generated for each product using join functions. |


## License

This repository is intended for learning and practice purposes.
