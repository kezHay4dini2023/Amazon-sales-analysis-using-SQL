
-- inspect the table 
SELECT *
FROM `amazon sale report`;

SELECT 
	COUNT(*)
FROM `amazon sale report`;

-- need to resend the table again. 
-- DROP TABLE `amazon sale report`; 
-- DROP TABLE `amazon_sale_report`;
-- DROP TABLE `new_amazon_sales`;
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

-- DROP TABLE new_amazon_sales_report; 

-- CREATE and clean the table 
CREATE TABLE new_amazon_sales_report AS
WITH cleaned_data AS (
	SELECT
    `index`, 
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
; -- creating a new table. 

SELECT * 
FROM `new_amazon_sales_report`; 

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
    ROUND(COUNT(CASE WHEN `Courier_status_cleaned` IS NULL OR `Courier_status_cleaned` = '' OR `Courier_status_cleaned` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS CourierStatus_Null_Pct,
    ROUND(COUNT(CASE WHEN `Qty_cleaned` IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS Qty_Null_Pct,
    ROUND(COUNT(CASE WHEN `currency` IS NULL OR `currency` = '' OR `currency` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Currency_Null_Pct,
    ROUND(COUNT(CASE WHEN `Amount_cleaned` IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS Amount_Null_Pct,
    ROUND(COUNT(CASE WHEN `ship-city` IS NULL OR `ship-city` = '' OR `ship-city` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ShipCity_Null_Pct,
    ROUND(COUNT(CASE WHEN `ship-state` IS NULL OR `ship-state` = '' OR `ship-state` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ShipState_Null_Pct,
    ROUND(COUNT(CASE WHEN `ship-postal-code` IS NULL OR `ship-postal-code` = '' OR `ship-postal-code` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ShipPostalCode_Null_Pct,
    ROUND(COUNT(CASE WHEN `ship-country` IS NULL OR `ship-country` = '' OR `ship-country` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS ShipCountry_Null_Pct,
    ROUND(COUNT(CASE WHEN `promotion_ids_cleaned` IS NULL OR `promotion_ids_cleaned` = '' OR `promotion_ids_cleaned` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS PromotionIds_Null_Pct,
    ROUND(COUNT(CASE WHEN `B2B` IS NULL OR `B2B` = '' OR `B2B` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS B2B_Null_Pct,
    ROUND(COUNT(CASE WHEN `fulfilled_by_cleaned` IS NULL OR `fulfilled_by_cleaned` = '' OR `fulfilled_by_cleaned` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS FulfilledBy_Null_Pct
FROM `new_amazon_sales_report`;


-- create feature engineering 

SELECT * 
FROM `new_amazon_sales_report`; 


SELECT 
	DISTINCT `Date`,
    COUNT(`Date`)
FROM `new_amazon_sales_report`
GROUP BY `Date`
; 

-- checking for status, quantity and ammount relation. 
SELECT 
	`Status`,
    `Qty_cleaned`,
    COUNT(`Qty_cleaned`)
FROM `new_amazon_sales_report`
GROUP BY `Status`, `Qty_cleaned`
;
	-- adding a new feature to the table `new_amazon_sales_report`
		-- adding revenue 
		ALTER TABLE `new_amazon_sales_report`
			ADD `Revenue` DECIMAL(10, 2);
		
		SET SQL_SAFE_UPDATES = 0;

		UPDATE `new_amazon_sales_report`
			SET `Revenue` =
				CASE
					WHEN `Status` = 'Cancelled' THEN 0
					ELSE `Amount_cleaned`
				END;

		SET SQL_SAFE_UPDATES = 1;
		
		-- adding IsCancelled 
        ALTER TABLE `new_amazon_sales_report`
			ADD `IsCancelled` BOOLEAN;
		SET SQL_SAFE_UPDATES = 0;
        
		UPDATE `new_amazon_sales_report`
			SET `IsCancelled` =
				CASE
					WHEN `Status` = 'Cancelled' THEN 1
					ELSE 0
				END;
		SET SQL_SAFE_UPDATES = 1;
        
        -- adding IsDelivered
        ALTER TABLE `new_amazon_sales_report`
			ADD `IsDelivered` BOOLEAN;
		SET SQL_SAFE_UPDATES = 0;
        
		UPDATE `new_amazon_sales_report`
			SET `IsDelivered` =
				CASE
					WHEN `Status` LIKE '%Delivered%' THEN 1
					ELSE 0
				END;
		SET SQL_SAFE_UPDATES = 1;
        
        -- adding avg_unit_price
        SELECT 
			`SKU`,
            COUNT(`SKU`),
            SUM(`Qty_cleaned`),
			AVG(
            CASE WHEN `Qty_cleaned` = 0 THEN 0 ELSE 
            `Amount_cleaned`/`Qty_cleaned`
            END
            ) AS avg_unit_price
        FROM `new_amazon_sales_report`
        GROUP BY `SKU`,`Amount_cleaned`, `Qty_cleaned`
        ; -- checking if it would make sense to give a value on unit price based on the average SKU GROUP of unit_price. but what if those SKU all have 0 quantity. 
        
        -- adding UnitPrice feature
        ALTER TABLE `new_amazon_sales_report`
			ADD `UnitPrice` DECIMAL(10, 2);
            
		SET SQL_SAFE_UPDATES = 0;
			UPDATE new_amazon_sales_report AS t
				SET UnitPrice =
				CASE
					WHEN t.Qty_cleaned > 0 THEN
						t.Amount_cleaned / t.Qty_cleaned
					ELSE
						NULL
				END
                ;
		SET SQL_SAFE_UPDATES = 1; -- sales unit price. 
        
            -- ALTER TABLE `new_amazon_sales_report`
-- 			DROP `UnitPrice`; 
--             SHOW PROCESSLIST;
-- 			-- KILL 43;
-- 			-- KILL 46;
-- 			 KILL 57;
--              KILL 65; 
--              KILL 62;
			-- alter date
            SET SQL_SAFE_UPDATES = 0;

				-- 1. Convert the text dates into the standard MySQL format (YYYY-MM-DD)
				UPDATE `new_amazon_sales_report`
				SET `Date` = DATE_FORMAT(STR_TO_DATE(`Date`, '%m-%d-%y'), '%Y-%m-%d');

				-- 2. Permanently change the column type to DATE
				ALTER TABLE `new_amazon_sales_report` MODIFY COLUMN `Date` DATE;

			SET SQL_SAFE_UPDATES = 1;
            
			-- adding OrderYear 
			ALTER TABLE `new_amazon_sales_report`
            ADD orderYear INT AS (YEAR(`Date`)); 
            
            -- adding OrderMonth
			ALTER TABLE `new_amazon_sales_report`
            ADD orderMonth INT AS (MONTH(`Date`)); 
            
            -- adding Monthname
            ALTER TABLE `new_amazon_sales_report`
            ADD MonthName VARCHAR(20) AS (MONTHNAME(`Date`));
            
            -- adding Quarter 
			ALTER TABLE `new_amazon_sales_report`
            ADD OrderQuarter INT AS (QUARTER(`Date`)); 
            
            -- adding OrderDay 
            ALTER TABLE `new_amazon_sales_report`
            ADD OrderDay  INT AS (DAY(`Date`)); 
            
            -- adding Weekday
            ALTER TABLE `new_amazon_sales_report`
            ADD Weekday VARCHAR(20) AS (weekday(`Date`));
            
            
SELECT `Date`,
	COUNT(`Date`)
FROM `new_amazon_sales_report`
GROUP BY `Date`
;

SELECT COUNT(*)
FROM `new_amazon_sales_report`
;

SELECT *
FROM `new_amazon_sales_report`
;

