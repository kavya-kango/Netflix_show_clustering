-- =====================================================================
-- Task 4: SQL for Data Analysis
-- This file contains a series of SQL commands to create, populate,
-- and query a simple e-commerce database.
-- =====================================================================


-- =====================================================================
-- Section 1: Database Setup (Schema and Data)
-- Create tables for customers, products, and orders, then insert
-- sample data to work with.
-- =====================================================================

-- Drop existing tables to ensure a clean setup (optional, useful for re-running)
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;

-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    city VARCHAR(255),
    country VARCHAR(255)
);

-- Create the Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10, 2)
);

-- Create the Orders table with foreign keys
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE
);

-- Insert sample data into all tables
INSERT INTO Customers (customer_id, customer_name, city, country) VALUES
(1, 'Alice Johnson', 'London', 'UK'),
(2, 'Bob Smith', 'New York', 'USA'),
(3, 'Charlie Brown', 'Paris', 'France'),
(4, 'Diana Prince', 'New York', 'USA');

INSERT INTO Products (product_id, product_name, price) VALUES
(101, 'Laptop', 1200.00),
(102, 'Mouse', 25.00),
(103, 'Keyboard', 75.00);

INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_date) VALUES
(1001, 1, 101, 1, '2025-09-01'),
(1002, 2, 102, 2, '2025-09-02'),
(1003, 1, 103, 1, '2025-09-03'),
(1004, 3, 101, 1, '2025-09-03'),
(1005, 2, 103, 1, '2025-09-04');

-- =====================================================================
-- Section 2: Basic Queries (SELECT, WHERE, GROUP BY, ORDER BY)
-- These queries cover fundamental data retrieval and aggregation.
-- =====================================================================

-- Query 2a: Find all customers from 'New York', ordered by name.
-- Uses: SELECT, FROM, WHERE, ORDER BY
SELECT customer_id, customer_name, city
FROM Customers
WHERE city = 'New York'
ORDER BY customer_name;

-- Query 2b: Count the number of orders per customer and show the top customers.
-- Uses: SELECT, COUNT (aggregate), FROM, GROUP BY, ORDER BY
SELECT
    customer_id,
    COUNT(order_id) AS number_of_orders
FROM Orders
GROUP BY customer_id
ORDER BY number_of_orders DESC;


-- =====================================================================
-- Section 3: Joining Tables (INNER JOIN, LEFT JOIN)
-- Joins are essential for combining data from multiple tables.
-- =====================================================================

-- Query 3a: List all orders with customer names and product details.
-- Uses: INNER JOIN to link three tables.
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    o.quantity,
    p.price,
    (o.quantity * p.price) AS total_price -- Calculated column
FROM Orders AS o
INNER JOIN Customers AS c ON o.customer_id = c.customer_id
INNER JOIN Products AS p ON o.product_id = p.product_id;

-- Query 3b: List all customers and their total spending, including customers who haven't ordered.
-- Uses: LEFT JOIN to ensure all customers are included.
-- Uses: SUM (aggregate), GROUP BY
SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM Customers AS c
LEFT JOIN Orders AS o ON c.customer_id = o.customer_id
LEFT JOIN Products AS p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


-- =====================================================================
-- Section 4: Subqueries
-- Subqueries (or inner queries) allow you to perform a query within another query.
-- =====================================================================

-- Query 4a: Find products that were ordered by 'Alice Johnson'.
-- The subquery finds Alice's customer_id first.
SELECT DISTINCT product_name
FROM Products
WHERE product_id IN (
    SELECT product_id FROM Orders WHERE customer_id = (
        SELECT customer_id FROM Customers WHERE customer_name = 'Alice Johnson'
    )
);


-- =====================================================================
-- Section 5: Creating and Using a View
-- Views are stored queries that can be treated like a table, useful for
-- simplifying complex and frequent analyses.
-- =====================================================================

-- Query 5a: Create a view for a detailed sales report.
CREATE VIEW V_Sales_Report AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.country,
    p.product_name,
    p.price,
    o.quantity,
    (o.quantity * p.price) AS total_price
FROM Orders AS o
JOIN Customers AS c ON o.customer_id = c.customer_id
JOIN Products AS p ON o.product_id = p.product_id;

-- Query 5b: Now, query the view to get all sales from the 'USA'.
-- This is much simpler than re-writing the whole JOIN query.
SELECT *
FROM V_Sales_Report
WHERE country = 'USA';


-- =====================================================================
-- Section 6: Optimizing with an Index
-- Indexes are special lookup tables that the database search engine can
-- use to speed up data retrieval, especially on large tables.
-- =====================================================================

-- Query 6a: Create an index to speed up searching for orders by `customer_id`.
-- This is useful for quickly finding a specific customer's order history.
-- The syntax might vary slightly between SQL dialects (e.g., some use `ON table (column)`).
CREATE INDEX idx_customer_id ON Orders (customer_id);

-- Note: You don't "run" an index, it's used automatically by the database.
-- For example, the following query would now be faster on a large dataset:
SELECT * FROM Orders WHERE customer_id = 2;


-- =====================================================================
-- Section 7: Time-Based Analysis (Monthly Revenue and Volume)
-- This query analyzes sales performance over time by calculating
-- total revenue and the number of orders for each month.
-- =====================================================================

-- Query 7a: Calculate total revenue and number of orders per month.
-- Note: Date extraction functions vary by SQL dialect. The following
-- are common examples for extracting the year and month.

-- SQLite:       strftime('%Y-%m', o.order_date)
-- PostgreSQL:   TO_CHAR(o.order_date, 'YYYY-MM')
-- MySQL:        DATE_FORMAT(o.order_date, '%Y-%m')

SELECT
    strftime('%Y-%m', o.order_date) AS sales_month, -- Using SQLite syntax for this example
    SUM(p.price * o.quantity) AS total_revenue,
    COUNT(o.order_id) AS number_of_orders
FROM
    Orders AS o
JOIN
    Products AS p ON o.product_id = p.product_id
GROUP BY
    sales_month
ORDER BY
    sales_month;

