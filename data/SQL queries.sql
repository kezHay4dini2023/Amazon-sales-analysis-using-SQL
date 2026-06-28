SELECT *
FROM `amazon sale report`; 

SELECT *
FROM `cloud warehouse compersion chart`;

SELECT *
FROM `expense iigf`;

SELECT * 
FROM `international sale report`; 

SELECT * 
FROM `may-2022`;

SELECT * 
FROM `p  l march 2021`;

SELECT * 
FROM e_commerce_profitabilityanalysis.`sale report`;


SELECT 
	*, 
    (
    CASE 
    WHEN `amazon sale report`.Fulfilment = 'Amazon' THEN 'INCREFF'
    WHEN `amazon sale report`.Fulfilment = 'Merchant' THEN 'Shiprocket' 
    ELSE 'other merchant'
    END 
	) AS Fulfilment_companies
FROM `amazon sale report`
;