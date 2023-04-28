--What are the top 5 brands by receipts scanned for most recent month?

SELECT b."NAME", COUNT(r."OID") AS "Receipts Scanned", r."DATESCANNED"
FROM "trans" r
JOIN "item" i ON r."OID" = i."OID"
JOIN "brands" as b ON i."brandCode" = b."BRANDCODE"
WHERE EXTRACT(year FROM r."DATESCANNED") = 2021 is TRUE
GROUP BY b."NAME", r."DATESCANNED"
ORDER BY COUNT(r."OID") DESC
;


--When considering average spend from receipts with'rewardsReceiptStatus of Accepted' or 'Rejectedwhich is greater?

SELECT "rewardsReceiptStatus", AVG("totalSpent") AS avgSpend
FROM trans
WHERE "rewardsReceiptStatus" IN ('FINISHED', 'REJECTED')
GROUP BY "rewardsReceiptStatus";

--When considering total number of items purchased from receipts with
--'rewardsReceiptStatus' of ' Accepted' or 'Reiected?which is greater?

SELECT "rewardsReceiptStatus", SUM("purchasedItemCount") AS totalItemsPurchased 
FROM trans 
WHERE "rewardsReceiptStatus" IN ('FINISHED', 'REJECTED')
GROUP BY "rewardsReceiptStatus";

--Which brand has the most spend among users who were created within the past 6 months?

SELECT b."NAME", SUM(r."totalSpent") AS total_spend
FROM "trans" r
JOIN "item" i ON r."OID" = i."OID"
JOIN "brands" b ON i."brandCode" = b."BRANDCODE"
JOIN "users" u ON r."userId" = u."USERID"
WHERE EXTRACT(MONTH FROM u."CREATEDATE") >= 1
AND EXTRACT(YEAR FROM u."CREATEDATE") >= 2020
AND r."rewardsReceiptStatus" IN ('FINISHED', 'REJECTED')
GROUP BY b."NAME"
ORDER BY total_spend DESC
;
