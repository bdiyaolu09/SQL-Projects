SELECT *
FROM updated_car_prices;

SELECT ROUND(Min(sellingprice),2) AS MIN_Price, 
ROUND(max(sellingprice),2) AS MAX_PRICE, 
ROUND(avg(sellingprice),2) AS AVG_PRICE, 
ROUND(std(sellingprice),2) AS STD
FROM updated_car_prices;

SELECT MAX(year) Current_Year, MIN(Year) Oldest_Year
FROM updated_car_prices;

SELECT COUNT(DISTINCT(make))
FROM updated_car_prices;

SELECT COUNT(*) AS Total_recent_car_sales
FROM updated_car_prices
WHERE YEAR(saledate) = 2015;

SELECT 
    CASE MONTH(saledate)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS month_name,
    SUM(Sellingprice) AS total_car_prices
FROM updated_car_prices
WHERE YEAR(saledate) = 2015
GROUP BY month_name
ORDER BY total_car_prices DESC;

SELECT   CASE MONTH(saledate)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS month_name,
    ROUND(AVG(Sellingprice),2) AS Average_car_prices
FROM updated_car_prices
WHERE YEAR(saledate) = 2015
GROUP BY month_name
ORDER BY Average_car_prices DESC;

SELECT 
    CASE MONTH(saledate)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS month_name, COUNT(make) AS total_car_by_month,
   SUM(Sellingprice) AS total_car_prices
FROM updated_car_prices
WHERE YEAR(saledate) = 2015
GROUP BY month_name
ORDER BY total_car_prices DESC;
SELECT 
    CASE
        WHEN MONTH(saledate) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(saledate) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(saledate) BETWEEN 7 AND 9 THEN 'Q3'
        WHEN MONTH(saledate) BETWEEN 10 AND 12 THEN 'Q4'
    END AS quarter,
    COUNT(make) AS total_cars_sold,
    SUM(Sellingprice) AS total_sales,
     ROUND(AVG(Sellingprice),2) AS Average_sales
FROM 
    updated_car_prices
WHERE 
    YEAR(saledate) = 2015
GROUP BY 
    quarter
ORDER BY 
    quarter;

ALTER TABLE updated_car_prices
CHANGE COLUMN C model VARCHAR(255);

SELECT make, model, SUM(sellingprice) AS Total_Price
FROM updated_car_prices
GROUP BY make, model
ORDER BY SUM(sellingprice) DESC
LIMIT 10;

SELECT make, model, round(AVG(sellingprice),2) AS AVG_Price
FROM updated_car_prices
GROUP BY make, model
ORDER BY AVG(sellingprice) DESC
LIMIT 10;

SELECT make, model, round(AVG(sellingprice),2) AS AVG_Price
FROM updated_car_prices
GROUP BY make, model
ORDER BY AVG(sellingprice) 
LIMIT 10;

SELECT make, model, COUNT(*) AS Total_sold
FROM updated_car_prices
GROUP BY make, model
ORDER BY Total_sold DESC
LIMIT 10;

SELECT state, make, model, COUNT(*) AS Total_Sold
FROM updated_car_prices
GROUP BY state, make, model
ORDER BY state, Total_sold DESC;


SELECT COUNT(DISTINCT(body)) AS Car_Type
FROM updated_car_prices;

SELECT DISTINCT(body) AS Car_Type
FROM updated_car_prices;

SELECT DISTINCT(body) AS Car_Category, COUNT(*) AS Count
FROM updated_car_prices
GROUP BY Car_Category
ORDER BY Count DESC
LIMIT 10;

SELECT COUNT(DISTINCT(make))
FROM updated_car_prices;

SELECT DISTINCT(Make) AS BRAND, COUNT(*) AS Count
FROM updated_car_prices
GROUP BY BRAND
ORDER BY Count DESC
LIMIT 10;

SELECT DISTINCT(state) AS state,  SUM(sellingprice) AS Total_Sales
FROM updated_car_prices
GROUP BY state
ORDER BY Total_sales DESC;



SELECT 
    CASE
        WHEN state IN ('FL', 'GA', 'AL', 'MS', 'SC', 'NC', 'TN') THEN 'Southeast'
        WHEN state IN ('TX', 'OK', 'AR', 'LA') THEN 'South Central'
        WHEN state IN ('CA', 'NV', 'AZ', 'HI') THEN 'West'
        WHEN state IN ('WA', 'OR', 'ID', 'MT', 'WY', 'AK') THEN 'Northwest'
        WHEN state IN ('CO', 'UT', 'NM') THEN 'Southwest'
        WHEN state IN ('NY', 'NJ', 'PA', 'DE', 'MD', 'DC') THEN 'Mid-Atlantic'
        WHEN state IN ('IL', 'IN', 'MI', 'OH', 'WI') THEN 'Midwest'
        WHEN state IN ('MN', 'IA', 'MO', 'KS', 'NE', 'SD', 'ND') THEN 'Plains'
        ELSE 'Other'
    END AS region, 
    COUNT(*) AS `COUNT`, 
  CONCAT(ROUND((COUNT(*) / (SELECT COUNT(*) FROM updated_car_prices))*100, 2), '%') AS Percentage
FROM updated_car_prices
GROUP BY region
ORDER BY `COUNT` DESC;

SELECT COUNT(DISTINCT(seller))
FROM updated_car_prices;


WITH TopSellers AS (
    SELECT seller, 
           COUNT(make) AS total_car_sold, 
           SUM(sellingprice) AS total_sales,
           AVG(sellingprice) AS avg_sales
    FROM updated_car_prices
    GROUP BY seller
    ORDER BY total_sales DESC
    LIMIT 10
)
SELECT seller, 
       total_car_sold,
       CONCAT('$', total_sales) AS total_sales,
       CONCAT('$', ROUND(avg_sales, 2)) AS average_sales
FROM TopSellers
ORDER BY total_sales DESC;

SELECT state, CONCAT('$',MAX(sellingprice)) AS Maximum_selling_price, CONCAT('$',MIN(sellingprice)) AS Minimum_selling_price
FROM updated_car_prices
GROUP BY state;

SELECT transmission, MAX(sellingprice) AS MaximumSellingPrice, MIN(sellingprice) AS MinimumSellingPrice, ROUND(AVG(sellingprice),2) AS AVG_SellingPrice
FROM updated_car_prices
GROUP BY transmission;

SELECT color, interior, COUNT(*) AS Total_Sold
FROM updated_car_prices
GROUP BY color, interior
ORDER BY Total_sold DESC
LIMIT 10;







