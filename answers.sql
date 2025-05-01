-- Question 1: Achieving 1NF (First Normal Form)
-- Problem: The 'Products' column contains multiple values in a single cell, violating 1NF.
-- Solution: Break each product into its own row while retaining the corresponding OrderID and CustomerName.

-- Original Table:
-- OrderID | CustomerName | Products
-- 101     | John Doe     | Laptop, Mouse

-- Create a normalized version in 1NF:
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Insert transformed data into 1NF-compliant table:
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Now each row represents a single product per order, satisfying 1NF.

-- ======================================================

-- Question 2: Achieving 2NF (Second Normal Form)
-- Problem: 'CustomerName' depends only on 'OrderID', not on the full composite key (OrderID, Product) — a partial dependency.
-- Solution: Split the table into two — one for Orders (OrderID, CustomerName) and one for OrderDetails (OrderID, Product, Quantity)

-- Original Table:
-- OrderID | CustomerName | Product | Quantity

-- Step 1: Create Orders table (OrderID as PK)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert unique orders and customers:
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 2: Create OrderDetails table (OrderID, Product as Composite PK)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert order details:
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Now, the partial dependency issue is resolved.
-- 'CustomerName' depends only on 'OrderID' in the Orders table,
-- and 'Product' and 'Quantity' depend on the composite key (OrderID, Product) in OrderDetails_2NF.

-- ======================================================

-- ✅ Done!
