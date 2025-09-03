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
or
category is NULL
or
mrp is NULL
or
discountPercent is NULL
or 
discountedSellingPrice is NULL
or 
weightInGms IS NULL
or
availableQuantity IS Null
or
outOfStock is Null
or
quantity is Null;

SELECT DISTINCT category
FROM ZEPTO
ORDER BY category


SELECT outOfStock, COUNT(sku_id)
FROM ZEPTO
GROUP BY outOfStock;


SELECT name, COUNT(sku_id) as "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(sku_id)>1
ORDER BY COUNT(sku_id) DESC;

--data cleaning
SELECT * FROM ZEPTO
Where mrp=0 or discountedSellingPrice=0;

DELETE from ZEPTO where mrp=0;

UPDATE ZEPTO
SET mrp=mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice FROM ZEPTOl 


