CREATE TABLE ZEPTO(
SKU_ID SERIAL PRIMARY KEY,
CATEGORY VARCHAR(120),
NAME VARCHAR(150) NOT NULL,
MRP NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGas INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

ALTER TABLE public.zepto RENAME COLUMN weightInGas  TO weightInGms;

SELECT COUNT(*) FROM ZEPTO;

SELECT * FROM ZEPTO LIMIT 10;

SELECT *FROM ZEPTO
WHERE name is NULL
OR
category is NULL
OR
mrp is NULL
or
discountPercent is NULL
or 
discountedSellingPrice is NULL
or 
weightInGas IS NULL
