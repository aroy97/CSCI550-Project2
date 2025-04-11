CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR,
    city VARCHAR,
    credit_score INTEGER
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO customers VALUES
    (1, 'John Smith', 'New York', 750),
    (2, 'Mary Johnson', 'Los Angeles', 820),
    (3, 'Robert Brown', 'Chicago', 680),
    (4, 'Patricia Wilson', 'Houston', 710),
    (5, 'Michael Davis', 'Phoenix', 790);

INSERT INTO orders VALUES
    (101, 1, '2023-01-15', 120.50),
    (102, 3, '2023-01-20', 65.75),
    (103, 2, '2023-02-05', 220.99),
    (104, 2, '2023-02-28', 50.25),
    (105, 4, '2023-03-10', 175.60),
    (106, 1, '2023-03-22', 85.40);
