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
WHERE NAME IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

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

SELECT mrp, discountedSellingPrice FROM ZEPTO

--Business Insights

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM ZEPTO
ORDER BY discountPercent DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name,mrp
FROM ZEPTO
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;

--Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM ZEPTO
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM ZEPTO
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM ZEPTO
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM ZEPTO
WHERE weightInGms >= 100
ORDER BY price_per_gram;

--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM ZEPTO;

--Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM ZEPTO
GROUP BY category
ORDER BY total_weight;
