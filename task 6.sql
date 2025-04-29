CREATE TABLE sales_data (
    TransactionID INTEGER PRIMARY KEY,
    TransactionDate DATE,
    ProductCategory VARCHAR(50),
    ProductName VARCHAR(100),
    UnitsSold INTEGER,
    UnitPrice DECIMAL(10, 2),
    TotalRevenue DECIMAL(10, 2),
    Region VARCHAR(50),
    PaymentMethod VARCHAR(50)
);

COPY sales_data FROM 'C:\Program Files\PostgreSQL\16\data\dataset\Online Sales Data.csv'
DELIMITER ','
CSV HEADER;

select* from sales_data;

	
SELECT
    EXTRACT(YEAR FROM TransactionDate) AS sales_year,
    TO_CHAR(TransactionDate, 'Month') AS sales_month_name,
    SUM(TotalRevenue) AS monthly_revenue,
    COUNT(DISTINCT TransactionID) AS monthly_order_volume
FROM
    sales_data
GROUP BY
    sales_year, sales_month_name
ORDER BY
    sales_year, MIN(EXTRACT(MONTH FROM TransactionDate));	
	

--Revenue by region that which region having highest revenue 

SELECT
    Region,
    SUM(TotalRevenue) AS TotalRevenueByRegion
FROM
    sales_data
GROUP BY
    Region
ORDER BY
    Region;
	
--Top 5 selling product categories 

SELECT
    ProductCategory,
    SUM(TotalRevenue) AS TotalRevenue
FROM
    sales_data
GROUP BY
    ProductCategory
ORDER BY
    TotalRevenue DESC
LIMIT 5;

-- top 10 productname which is selling 
SELECT
    productname,
    SUM(TotalRevenue) AS TotalRevenue
FROM
    sales_data
GROUP BY
    productname
ORDER BY
    TotalRevenue DESC
LIMIT 10;
	