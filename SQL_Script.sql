-- Exploratory data analysis

SELECT * FROM globalStore.dbo.Orders$


SELECT * FROM globalStore.dbo.Orders$
ORDER BY [Row ID]


--Checking if Order ID is a unique identifier or not
SELECT [Order ID],COUNT(*)
FROM globalStore.dbo.Orders$
GROUP BY [Order ID]

-- Validating that the Order date is always before the Ship date
SELECT * FROM [globalStore].[dbo].[Orders$]
WHERE [Order Date]>[Ship Date]

-- Checking for duplicates
WITH row_num AS(
SELECT * ,ROW_NUMBER() OVER(
PARTITION BY [Order ID],[Product ID],[Product Name],[Sales],[Quantity],[Customer ID],[Sub-Category],[State],[Profit],[Ship Date],[Customer Name]
ORDER BY [Order ID]) as row_num
FROM globalStore.dbo.Orders$
)
SELECT *
FROM row_num
WHERE row_num >1



-- Exploring the Shipping modes
SELECT [Ship Mode],COUNT(*) FROM globalStore.dbo.Orders$
GROUP BY [Ship Mode]

-- Understand the difference between each ship mode

SELECT min(DATEDIFF(DAY, [Order Date],[Ship Date]))as minDays,max(DATEDIFF(DAY, [Order Date],[Ship Date]))as maxDays
FROM globalStore.dbo.Orders$
WHERE [Ship Mode]='First Class'

SELECT min(DATEDIFF(DAY, [Order Date],[Ship Date]))as minDays,max(DATEDIFF(DAY, [Order Date],[Ship Date]))as maxDays
FROM globalStore.dbo.Orders$
WHERE [Ship Mode]='Second Class'

SELECT min(DATEDIFF(DAY, [Order Date],[Ship Date]))as minDays,max(DATEDIFF(DAY, [Order Date],[Ship Date]))as maxDays
FROM globalStore.dbo.Orders$
WHERE [Ship Mode]='Standard Class'

--Customer Segments
SELECT Segment,COUNT(*)
FROM globalStore.dbo.Orders$
GROUP BY Segment

-- Most frequent countries
SELECT Country,City,Count(*)as numOrders
FROM globalStore.dbo.Orders$
GROUP BY Country,City
ORDER BY numOrders DESC

-- Order Categories
SELECT Category,COUNT(*) as freq
FROM globalStore.dbo.Orders$
GROUP BY Category
ORDER BY freq

-- Top Buyers
SELECT [Customer Name],COUNT(*) as freq
FROM globalStore.dbo.Orders$
GROUP BY [Customer Name]
ORDER BY freq DESC

