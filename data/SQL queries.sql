
-- inspect the table 
SELECT *
FROM `amazon sale report`;

-- total columns

SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'amazon sale report';

-- checking for null values. we have to see which data has the most null 
SELECT 
    ROUND(COUNT(CASE WHEN `index` IS NULL OR `index` = '' OR `index` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS index_Null_Pct,
    ROUND(COUNT(CASE WHEN `Order ID` IS NULL OR `Order ID` = '' OR `Order ID` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS OrderID_Null_Pct,
    ROUND(COUNT(CASE WHEN `Date` IS NULL OR `Date` = '' OR `Date` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Date_Null_Pct,
    ROUND(COUNT(CASE WHEN `Status` IS NULL OR `Status` = '' OR `Status` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Status_Null_Pct,
    ROUND(COUNT(CASE WHEN `Fulfilment` IS NULL OR `Fulfilment` = '' OR `Fulfilment` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Fulfilment_Null_Pct,
    ROUND(COUNT(CASE WHEN `Sales Channel` IS NULL OR `Sales Channel` = '' OR `Sales Channel` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS SalesChannel_Null_Pct,
    ROUND(COUNT(CASE WHEN `ship-service-level` IS NULL OR `ship-service-level` = '' OR `ship-service-level` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ShipServiceLevel_Null_Pct,
    ROUND(COUNT(CASE WHEN `Style` IS NULL OR `Style` = '' OR `Style` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Style_Null_Pct,
    ROUND(COUNT(CASE WHEN `SKU` IS NULL OR `SKU` = '' OR `SKU` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS SKU_Null_Pct,
    ROUND(COUNT(CASE WHEN `Category` IS NULL OR `Category` = '' OR `Category` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Category_Null_Pct,
    ROUND(COUNT(CASE WHEN `Size` IS NULL OR `Size` = '' OR `Size` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Size_Null_Pct,
    ROUND(COUNT(CASE WHEN `ASIN` IS NULL OR `ASIN` = '' OR `ASIN` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ASIN_Null_Pct,
    ROUND(COUNT(CASE WHEN `Courier Status` IS NULL OR `Courier Status` = '' OR `Courier Status` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS CourierStatus_Null_Pct,
    ROUND(COUNT(CASE WHEN `Qty` IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS Qty_Null_Pct,
    ROUND(COUNT(CASE WHEN `currency` IS NULL OR `currency` = '' OR `currency` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Currency_Null_Pct,
    ROUND(COUNT(CASE WHEN `Amount` IS NULL OR `Amount` = '' OR `Amount` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Amount_Null_Pct,
    ROUND(COUNT(CASE WHEN `ship-city` IS NULL OR `ship-city` = '' OR `ship-city` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ShipCity_Null_Pct,
    ROUND(COUNT(CASE WHEN `ship-state` IS NULL OR `ship-state` = '' OR `ship-state` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ShipState_Null_Pct,
    ROUND(COUNT(CASE WHEN `ship-postal-code` IS NULL OR `ship-postal-code` = '' OR `ship-postal-code` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ShipPostalCode_Null_Pct,
    ROUND(COUNT(CASE WHEN `ship-country` IS NULL OR `ship-country` = '' OR `ship-country` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ShipCountry_Null_Pct,
    ROUND(COUNT(CASE WHEN `promotion-ids` IS NULL OR `promotion-ids` = '' OR `promotion-ids` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS PromotionIds_Null_Pct,
    ROUND(COUNT(CASE WHEN `B2B` IS NULL OR `B2B` = '' OR `B2B` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS B2B_Null_Pct,
    ROUND(COUNT(CASE WHEN `fulfilled-by` IS NULL OR `fulfilled-by` = '' OR `fulfilled-by` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS FulfilledBy_Null_Pct,
    ROUND(COUNT(CASE WHEN `Unnamed: 22` IS NULL OR `Unnamed: 22` = '' OR `Unnamed: 22` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Unnamed22_Null_Pct
FROM `amazon sale report`
;

-- checking courier status
	-- checking for its distinct values. 
	SELECT DISTINCT `Courier Status` AS courier_category
	FROM `amazon sale report`
	;  
	
    -- checking for status with courier status. for the null values.  
    SELECT 
		`status`, 
        `Fulfilment`,
        `Courier Status`,
        `fulfilled-by`,
        `ship-service-level`,
		COUNT(`Courier Status`) AS courier_category_count
    FROM `amazon sale report`
    GROUP BY `status`, `Fulfilment`, `Courier Status`, `fulfilled-by`, `ship-service-level`
    ; -- all the null values of status courier came from a merchant fullfilled-by easyship that was cancelled. 

-- check for the null in Qty column (NO null value was found). 
SELECT
	`Qty`,
	COUNT( `Qty`)
FROM `amazon sale report`
GROUP BY `Qty`
; -- the zero (0) value in this column has been accidentally recognize as null because of the query checking it. ROUND(COUNT(CASE WHEN `Qty` OR `ship-city` = '' OR `ship-city` = ' ' IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS Qty_Null_Pct,
    
-- checking for the values in  Amount 
SELECT
	`Amount`,
	COUNT( `Amount`)
FROM `amazon sale report`
GROUP BY `Amount`
; -- it has null value because those rows have 0 quantity and the item has been cancelled. 

-- checking the promotin-ids column 
SELECT
	`promotion-ids`, 
    `Courier Status`,
	COUNT( `promotion-ids`)
FROM `amazon sale report`
GROUP BY `promotion-ids`, `Courier Status`
; -- the orders with null promotions have 0 discoutns (pay in full price) or no awards were given (eg. free shipping).  

SELECT 
	`Fulfilment`,
    `Fulfilled-by`,
    COUNT(`Fulfilled-by`)
FROM `amazon sale report`
GROUP BY `Fulfilment`,`Fulfilled-by`
; -- all the null values in Fulfilled-by comes from  amazon in the fulfilment column.

SELECT 
	`Unnamed: 22`,
	COUNT(`Unnamed: 22`) AS unnamed
FROM `amazon sale report`
GROUP BY `Unnamed: 22`
; -- this column isnt useful. it isnt supposed to be here. its a phantom column. 


-- clean the table 
WITH cleaned_data AS (
	SELECT
    `Order ID`,
    `Date`,
    `Status`,
    `Fulfilment`,
    `Sales Channel`,
    `ship-service-level`,
    `Style`,
    `SKU`,
    `Category`,
    `Size`,
    `ASIN`,
		CASE 
			WHEN `Courier Status` IS NULL OR `Courier Status` = '' OR `Courier Status` = ' ' 
			THEN  'Cancelled Prior to Dispatch'
			ELSE `Courier Status`
			END AS Courier_status_cleaned,
		CASE 
			WHEN `Qty` IS NULL OR `Qty` = '' OR `Qty` = ' ' 
			THEN  0
			ELSE `Qty`
			END AS Qty_cleaned,
	`currency`,
		CASE 
			WHEN `Amount` IS NULL OR `Amount` = '' OR `Amount` = ' ' 
			THEN  0
			ELSE `Amount`
			END AS Amount_cleaned,
	`ship-city`,
    `ship-state`,
    `ship-postal-code`,
    `ship-country`,
		CASE 
			WHEN `promotion-ids` IS NULL OR `promotion-ids` = '' OR `promotion-ids` = ' ' 
			THEN  'No Promotion'
			ELSE `promotion-ids`
			END AS promotion_ids_cleaned,
	`B2B`,
		CASE 
			WHEN `fulfilled-by` IS NULL OR `fulfilled-by` = '' OR `fulfilled-by` = ' ' 
			THEN  'Amazon (FBA Network)'
			ELSE `fulfilled-by`
			END AS fulfilled_by_cleaned
	FROM `amazon sale report`
)

SELECT *
FROM cleaned_data
;



