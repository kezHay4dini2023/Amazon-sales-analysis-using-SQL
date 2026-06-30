#  SQL: Amazon Profitability analysis 

we are going to analyze general sales trends by examining features which are months, category, currency, stock level, and customer service for each sale. 

the data that was use for this analysis can be found <a href="https://www.kaggle.com/datasets/thedevastator/unlock-profits-with-e-commerce-sales-data/data?select=Cloud+Warehouse+Compersion+Chart.csv">Here</a>

## Cleaning the Data
For this part of the project, I am cleaning the dataset by evaluating missing values, diagnosing data anomalies, and identifying irrelevant feature columns that should be removed to improve overall data analysis.

### Checking for Null Values
The first step in the cleaning process is to inspect the table structures, establish the absolute column count, and assess the distribution of true `NULL` values, empty strings (`''`), or blank space values (`' '`) across every column in the dataset to locate where data is most sparse.

```sql
-- View entire table layout
SELECT *
FROM `amazon sale report`;

-- Verify total number of columns
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'amazon sale report';

-- Calculate the percentage of missing/blank values per column
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
    ROUND(COUNT(CASE WHEN `Qty` IS NULL OR `ASIN` = '' OR `ASIN` = ' ' THEN 1 END) * 100.0 / COUNT(*), 2) AS Qty_Null_Pct,
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
FROM `amazon sale report`; 
```

- we see that have been detected to have null values such as: `Courier Status`, `Qty`, `Amount`, `promotion-ids`, `fulfilled-by` and `Unnamed: 22`

lets look at each of column at why they have null values

1. `Courier Status` - Every instance of a NULL or missing entry in the Courier Status column maps explicitly back to transactions handled by a third-party merchant using Easy Ship where the overarching order status was completely Cancelled. Because these items were cancelled prior to handover or transit dispatch, a shipping courier was never assigned or tracked.

``` sql
-- checking for status with courier status. for the null values.  
    SELECT 
		`status`, 
        `Fulfilment`,
        `Courier Status`,
        `fulfilled-by`,
		COUNT(`Courier Status`) AS courier_category_count
    FROM `amazon sale report`
    GROUP BY `status`, `Fulfilment`, `Courier Status`, `fulfilled-by`
    ; -- all the null values of status courier came from a merchant fullfilled-by easyship that was cancelled. 
```
<p align="center">
  <img src="images\courier_status.png" alt="courier status" width="100%">
</p>

2. `Qty` - No factual NULL values exist within the Qty column. Zero values (0) are recorded properly as integers. the 0 value was automatically assumed by the query to be a null value. 

``` sql
-- Checking for the values distribution in Qty column
SELECT
	`Qty`,
	COUNT( `Qty`)
FROM `amazon sale report`
GROUP BY `Qty`
; -- the zero (0) value in this column has been accidentally recognize as null because of the query checking it. ROUND(COUNT(CASE WHEN `Qty` OR `ship-city` = '' OR `ship-city` = ' ' IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS Qty_Null_Pct,
    
``` 
<p align="center">
  <img src="images\qty.png" alt="qty" width="100%">
</p>

3. `Amount` - Gaps inside the Amount column are perfectly correlated with rows where the transaction shows a quantity of 0 (which was mistakenly assumed by the query to be a null value) and a status of Cancelled. Since the orders were terminated and no physical goods were exchanged, zero financial revenue was generated, meaning these records represent a deliberate logical absence rather than a data input entry error.

``` sql
-- Checking for the values distribution in Amount column
SELECT
    `Amount`,
    COUNT(`Amount`)
FROM `amazon sale report`
GROUP BY `Amount`;
```
<p align="center">
  <img src="images\amount.png" alt="qty" width="100%">
</p>

4. `promotion-ids` - NULL fields inside promotion-ids simply denote standard orders where items were purchased at regular, full base retail prices. No coupon codes, promotional seasonal events, or special programmatic rewards (such as corporate free shipping or active award discounts) were attached to these specific checkouts.

``` sql 
-- Checking the promotion-ids column behavior
SELECT
    `promotion-ids`, 
    `Courier Status`,
    COUNT(`promotion-ids`)
FROM `amazon sale report`
GROUP BY `promotion-ids`, `Courier Status`;
```

<p align="center">
  <img src="images\promotion.png" alt="qty" width="100%">
</p>

5. `fulfilled-by` - All missing fields within the fulfilled-by column line up exactly with rows where the overarching Fulfilment channel is designated as Amazon. The database engine populates the fulfilled-by property strictly when an independent merchant manages their own fulfillment logistics (e.g., using Easy Ship).

``` sql
SELECT 
	`Fulfilment`,
    `Fulfilled-by`,
    COUNT(`Fulfilled-by`)
FROM `amazon sale report`
GROUP BY `Fulfilment`,`Fulfilled-by`
; -- all the null values in Fulfilled-by comes from  amazon in the fulfilment column.

```

<p align="center">
  <img src="images\fulfilled-by.png" alt="qty" width="100%">
</p>


6. `Unnamed: 22` - The column Unnamed: 22 is entirely empty across the entire dataset. This column is a common "Ghost/Phantom Column" generated during messy file export configurations. When spreadsheets with trailing whitespace or accidental cell active statuses are converted into a CSV structure, loader scripts parse the extra trailing delimiter as a blank 23rd field. This column carries zero analytical utility and will be permanently dropped from the table structure.

``` sql
SELECT 
	`Unnamed: 22`,
	COUNT(`Unnamed: 22`) AS unnamed
FROM `amazon sale report`
GROUP BY `Unnamed: 22`
; -- this column isnt useful. it isnt supposed to be here. its a phantom column. 
```
<p align="center">
  <img src="images\unnamed-22.png" alt="qty" width="100%">
</p>


### Filling out the Missing Values. 

``` sql 
-- clean the table 
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

```
- This SQL script uses a Common Table Expression (CTE) named cleaned_data alongside CASE statements to systematically identify and fill in missing or blank data fields across key columns. For categorical columns, missing or empty values are replaced with logical default contexts—such as converting blank courier statuses to 'Cancelled Prior to Dispatch', missing promotion IDs to 'No Promotion', and empty fulfillment fields to 'Amazon (FBA Network)'. For numerical columns like Qty and Amount, any null or blank entries are safely standardized to 0 to ensure mathematical consistency during downstream analysis. The result is a fully imputed, clean dataset that prevents empty values from skewing metrics or throwing errors in future queries.


```sql
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
```
- using this query we see that there is no more null values with the new table. 

