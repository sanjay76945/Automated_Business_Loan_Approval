-- We will start with DDL & DML commands
-- Let us create the table and import the data 



CREATE TABLE loan_application (
    LoanNr_ChkDgt VARCHAR(50),   -- Assuming alphanumeric identifier
    Name VARCHAR(255),           -- Name of the borrower
    City VARCHAR(100),           -- City of the borrower
    State VARCHAR(50),           -- State of the borrower
    Zip VARCHAR(10),             -- ZIP code
    Bank VARCHAR(255),           -- Bank name
    BankState VARCHAR(50),       -- State of the bank
    NAICS VARCHAR(10),           -- NAICS industry code
    ApprovalDate DATE,           -- Date when loan was approved
    ApprovalFY VARCHAR(10),      -- Fiscal year of loan approval
    Term INT,                    -- Loan term in months
    NoEmp INT,                   -- Number of employees
    NewExist INT,                -- 1 for Existing business, 2 for New business
    CreateJob INT,               -- Number of jobs created
    RetainedJob INT,             -- Number of jobs retained
    FranchiseCode VARCHAR(10),   -- Franchise code (if applicable)
    UrbanRural INT,              -- 1 for Urban, 2 for Rural, 0 for undefined
    RevLineCr CHAR(1),           -- Y for Revolving Line of Credit, N for No
    LowDoc CHAR(1),              -- Y for Low Documentation Loan, N for No
    ChgOffDate DATE,             -- Charge-off date (if loan defaults)
    DisbursementDate DATE,       -- Date loan was disbursed
    DisbursementGross NUMERIC(15, 2), -- Disbursement amount
    BalanceGross NUMERIC(15, 2), -- Outstanding balance
    MIS_Status VARCHAR(10),      -- Loan status (e.g., "PIF" for paid in full, "CHGOFF" for charged off)
    ChgOffPrinGr NUMERIC(15, 2), -- Charge-off principal amount
    GrAppv NUMERIC(15, 2),       -- Gross approved amount
    SBA_Appv NUMERIC(15, 2)      -- SBA's guaranteed approved amount
);

-- Now let us load the data in the created table by using following query

COPY loan_application
FROM 'C:\Users\sp769\Downloads\SBAnational(3).csv'
DELIMITER ',' 
CSV HEADER;

-- Handling Null values

-- Count null values for each column
SELECT 
    COUNT(*) FILTER (WHERE LoanNr_ChkDgt IS NULL) AS LoanNr_ChkDgt_nulls,
    COUNT(*) FILTER (WHERE Name IS NULL) AS Name_nulls,
    COUNT(*) FILTER (WHERE City IS NULL) AS City_nulls,
    COUNT(*) FILTER (WHERE State IS NULL) AS State_nulls,
    COUNT(*) FILTER (WHERE Zip IS NULL) AS Zip_nulls,
    COUNT(*) FILTER (WHERE Bank IS NULL) AS Bank_nulls,
    COUNT(*) FILTER (WHERE BankState IS NULL) AS BankState_nulls,
    COUNT(*) FILTER (WHERE NAICS IS NULL) AS NAICS_nulls,
    COUNT(*) FILTER (WHERE ApprovalDate IS NULL) AS ApprovalDate_nulls,
    COUNT(*) FILTER (WHERE ApprovalFY IS NULL) AS ApprovalFY_nulls,
    COUNT(*) FILTER (WHERE Term IS NULL) AS Term_nulls,
    COUNT(*) FILTER (WHERE NoEmp IS NULL) AS NoEmp_nulls,
    COUNT(*) FILTER (WHERE NewExist IS NULL) AS NewExist_nulls,
    COUNT(*) FILTER (WHERE CreateJob IS NULL) AS CreateJob_nulls,
    COUNT(*) FILTER (WHERE RetainedJob IS NULL) AS RetainedJob_nulls,
    COUNT(*) FILTER (WHERE FranchiseCode IS NULL) AS FranchiseCode_nulls,
    COUNT(*) FILTER (WHERE UrbanRural IS NULL) AS UrbanRural_nulls,
    COUNT(*) FILTER (WHERE RevLineCr IS NULL) AS RevLineCr_nulls,
    COUNT(*) FILTER (WHERE LowDoc IS NULL) AS LowDoc_nulls,
    COUNT(*) FILTER (WHERE DisbursementDate IS NULL) AS DisbursementDate_nulls,
    COUNT(*) FILTER (WHERE DisbursementGross IS NULL) AS DisbursementGross_nulls,
    COUNT(*) FILTER (WHERE BalanceGross IS NULL) AS BalanceGross_nulls,
    COUNT(*) FILTER (WHERE MIS_Status IS NULL) AS MIS_Status_nulls,
    COUNT(*) FILTER (WHERE ChgOffPrinGr IS NULL) AS ChgOffPrinGr_nulls,
    COUNT(*) FILTER (WHERE GrAppv IS NULL) AS GrAppv_nulls,
    COUNT(*) FILTER (WHERE SBA_Appv IS NULL) AS SBA_Appv_nulls
FROM loan_application;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Let us fill the missing values in the state column
-- As we know, in the U.S., ZIP codes generally follow patterns, where certain ranges of ZIP codes are associated with specific states
-- So we will write the code accordingly as ZIP column has no null values

-- Update the State column based on the ZIP code prefix

UPDATE loan_application
SET State = CASE
    WHEN Zip LIKE '99%' THEN 'AK'
    WHEN Zip LIKE '35%' OR Zip LIKE '36%' OR Zip LIKE '70%' OR Zip LIKE '88%' THEN 'AL'
    WHEN Zip LIKE '71%' OR Zip LIKE '72%' OR Zip LIKE '73%' OR Zip LIKE '75%' OR Zip LIKE '77%' THEN 'AR'
    WHEN Zip LIKE '85%' OR Zip LIKE '86%' THEN 'AZ'
    WHEN Zip LIKE '90%' OR Zip LIKE '91%' OR Zip LIKE '92%' OR Zip LIKE '93%' OR Zip LIKE '94%' OR Zip LIKE '95%' OR Zip LIKE '96%' THEN 'CA'
    WHEN Zip LIKE '80%' OR Zip LIKE '81%' THEN 'CO'
    WHEN Zip LIKE '60%' OR Zip LIKE '61%' OR Zip LIKE '62%' OR Zip LIKE '63%' OR Zip LIKE '64%' OR Zip LIKE '65%' OR Zip LIKE '66%' OR Zip LIKE '67%' OR Zip LIKE '68%' OR Zip LIKE '69%' THEN 'CT'
    WHEN Zip LIKE '20%' THEN 'DC'
    WHEN Zip LIKE '19%' THEN 'DE'
    WHEN Zip LIKE '32%' OR Zip LIKE '33%' OR Zip LIKE '34%' THEN 'FL'
    WHEN Zip LIKE '30%' OR Zip LIKE '31%' THEN 'GA'
    WHEN Zip LIKE '96%' THEN 'HI'
    WHEN Zip LIKE '50%' OR Zip LIKE '51%' OR Zip LIKE '52%' THEN 'IA'
    WHEN Zip LIKE '60%' OR Zip LIKE '61%' OR Zip LIKE '62%' THEN 'IL'
    WHEN Zip LIKE '46%' OR Zip LIKE '47%' THEN 'IN'
    WHEN Zip LIKE '66%' OR Zip LIKE '67%' THEN 'KS'
    WHEN Zip LIKE '40%' OR Zip LIKE '41%' OR Zip LIKE '42%' THEN 'KY'
    WHEN Zip LIKE '70%' OR Zip LIKE '71%' THEN 'LA'
    WHEN Zip LIKE '01%' OR Zip LIKE '02%' THEN 'MA'
    WHEN Zip LIKE '20%' OR Zip LIKE '21%' OR Zip LIKE '22%' OR Zip LIKE '23%' THEN 'MD'
    WHEN Zip LIKE '39%' THEN 'ME'
    WHEN Zip LIKE '48%' OR Zip LIKE '49%' THEN 'MI'
    WHEN Zip LIKE '55%' OR Zip LIKE '56%' THEN 'MN'
    WHEN Zip LIKE '38%' OR Zip LIKE '39%' THEN 'MS'
    WHEN Zip LIKE '63%' OR Zip LIKE '64%' OR Zip LIKE '65%' THEN 'MO'
    WHEN Zip LIKE '59%' THEN 'MT'
    WHEN Zip LIKE '27%' OR Zip LIKE '28%' THEN 'NC'
    WHEN Zip LIKE '58%' OR Zip LIKE '59%' THEN 'ND'
    WHEN Zip LIKE '68%' OR Zip LIKE '69%' THEN 'NE'
    WHEN Zip LIKE '03%' OR Zip LIKE '04%' THEN 'NH'
    WHEN Zip LIKE '07%' OR Zip LIKE '08%' THEN 'NJ'
    WHEN Zip LIKE '87%' OR Zip LIKE '88%' THEN 'NM'
    WHEN Zip LIKE '10%' OR Zip LIKE '11%' OR Zip LIKE '12%' OR Zip LIKE '13%' OR Zip LIKE '14%' THEN 'NY'
    WHEN Zip LIKE '43%' OR Zip LIKE '44%' OR Zip LIKE '45%' THEN 'OH'
    WHEN Zip LIKE '73%' OR Zip LIKE '74%' THEN 'OK'
    WHEN Zip LIKE '97%' OR Zip LIKE '98%' THEN 'OR'
    WHEN Zip LIKE '15%' OR Zip LIKE '16%' THEN 'PA'
    WHEN Zip LIKE '28%' OR Zip LIKE '29%' THEN 'SC'
    WHEN Zip LIKE '57%' THEN 'SD'
    WHEN Zip LIKE '37%' OR Zip LIKE '38%' THEN 'TN'
    WHEN Zip LIKE '75%' OR Zip LIKE '76%' OR Zip LIKE '77%' OR Zip LIKE '78%' OR Zip LIKE '79%' THEN 'TX'
    WHEN Zip LIKE '84%' OR Zip LIKE '85%' THEN 'UT'
    WHEN Zip LIKE '22%' OR Zip LIKE '23%' OR Zip LIKE '24%' THEN 'VA'
    WHEN Zip LIKE '50%' OR Zip LIKE '51%' OR Zip LIKE '52%' OR Zip LIKE '53%' OR Zip LIKE '54%' THEN 'VT'
    WHEN Zip LIKE '98%' OR Zip LIKE '99%' THEN 'WA'
    WHEN Zip LIKE '25%' OR Zip LIKE '26%' THEN 'WV'
    WHEN Zip LIKE '53%' OR Zip LIKE '54%' THEN 'WI'
    WHEN Zip LIKE '82%' OR Zip LIKE '83%' THEN 'WY'
    ELSE State -- Leave the existing state if it does not match the ZIP ranges
END
WHERE State IS NULL;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Let us fill the missing values in the City column

-- Let us identify Most Common City for Each ZIP Code

WITH city_counts AS (
    SELECT Zip, City, COUNT(*) AS city_count
    FROM loan_application
    WHERE City IS NOT NULL
    GROUP BY Zip, City
),
most_common_city AS (
    SELECT Zip, City
    FROM (
        SELECT Zip, City, city_count,
               ROW_NUMBER() OVER (PARTITION BY Zip ORDER BY city_count DESC) AS rank
        FROM city_counts
    ) AS ranked_cities
    WHERE rank = 1
)
SELECT * FROM most_common_city;


-- Let us update NULL city values based on Zip code

UPDATE loan_application
SET City = (
    SELECT City
    FROM (
        WITH city_counts AS (
    SELECT Zip, City, COUNT(*) AS city_count
    FROM loan_application
    WHERE City IS NOT NULL
    GROUP BY Zip, City
)
        SELECT Zip, City
        FROM (
            SELECT Zip, City, COUNT(*) AS city_count,
                   ROW_NUMBER() OVER (PARTITION BY Zip ORDER BY COUNT(*) DESC) AS rank
            FROM loan_application
            WHERE City IS NOT NULL
            GROUP BY Zip, City
        ) AS ranked_cities
        WHERE rank = 1
    ) AS most_common_city
    WHERE loan_application.Zip = most_common_city.Zip
)
WHERE City IS NULL;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us fill the missing values in the Bank and BankState Column's

-- Let us find the most common Bank and BankState for each Zip

WITH bank_counts AS (
    SELECT Zip, Bank, BankState, COUNT(*) AS count_bank
    FROM loan_application
    WHERE Bank IS NOT NULL AND BankState IS NOT NULL
    GROUP BY Zip, Bank, BankState
),
most_common_bank AS (
    SELECT Zip, Bank, BankState
    FROM (
        SELECT Zip, Bank, BankState, count_bank,
               ROW_NUMBER() OVER (PARTITION BY Zip ORDER BY count_bank DESC) AS rank
        FROM bank_counts
    ) AS ranked_banks
    WHERE rank = 1
)
SELECT * FROM most_common_bank;

-- Let us update NULL Bank and BankState values based on Zip code

-- Update Bank Nulls based on Zip

WITH most_common_bank AS (
    SELECT Zip, Bank
    FROM (
        SELECT Zip, Bank, COUNT(*) AS bank_count,
               ROW_NUMBER() OVER (PARTITION BY Zip ORDER BY COUNT(*) DESC) AS rank
        FROM loan_application
        WHERE Bank IS NOT NULL
        GROUP BY Zip, Bank
    ) AS ranked_bank
    WHERE rank = 1
)
UPDATE loan_application
SET Bank = most_common_bank.Bank
FROM most_common_bank
WHERE loan_application.Zip = most_common_bank.Zip
AND loan_application.Bank IS NULL;

-- Update BankState Nulls based on Zip

WITH most_common_bank_state AS (
    SELECT Zip, BankState
    FROM (
        SELECT Zip, BankState, COUNT(*) AS bank_state_count,
               ROW_NUMBER() OVER (PARTITION BY Zip ORDER BY COUNT(*) DESC) AS rank
        FROM loan_application
        WHERE BankState IS NOT NULL
        GROUP BY Zip, BankState
    ) AS ranked_bank_state
    WHERE rank = 1
)
UPDATE loan_application
SET BankState = most_common_bank_state.BankState
FROM most_common_bank_state
WHERE loan_application.Zip = most_common_bank_state.Zip
AND loan_application.BankState IS NULL;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us Fill the null values for NewExist column

-- Value of NewExist=1 refer to the existing business and NewExist=2 to the new one
-- As we can guess for the new business number of emp. will less than existing one
-- We can verify it by seeing the average for both the business category

-- Average of New Business no of emp

SELECT AVG(NoEmp)
FROM loan_application
WHERE NewExist=2;

-- Average is almost 7
-- Average of existing business no of emp

SELECT AVG(NoEmp)
FROM loan_application
WHERE NewExist=1;

-- Average is 13
-- We can choose threshold that is close to both the averages (10)

-- Update NewExist based on NoEmp values
UPDATE loan_application
SET NewExist = CASE
    WHEN NoEmp <= 10 THEN 2  
    WHEN NoEmp > 10 THEN 1   
END
WHERE NewExist IS NULL AND NoEmp IS NOT NULL;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us fill the null values for the column Revolving Line of Credit
-- Let us see all the Distinct values in the column

SELECT DISTINCT RevLineCr
FROM loan_application;

-- The RevLineCr column is supposed to contain only two values: 'Y' (Yes) and 'N' (No), but it has various unexpected values such as 0, 1, nan, ,, T, etc.
-- We will assume that '0' means 'N', '1' means 'Y', 'T' means 'Y' and 'R' can be Revolving means 'Y' else we will assign as nulls

-- Update RevLineCr to clean up invalid values
UPDATE loan_application
SET RevLineCr = CASE
    WHEN RevLineCr = '0' THEN 'N'   
    WHEN RevLineCr = '1' THEN 'Y'  
    WHEN RevLineCr = 'T' THEN 'Y' 
	WHEN RevLinecr = 'R' THEN 'Y'
    WHEN RevLineCr IN ('`', ',', '.', '-', 'C', '3', '2', '7', 'A', '5', '4', 'Q') THEN NULL 
    ELSE RevLineCr 
END
WHERE RevLineCr IS NOT NULL;


SELECT DISTINCT RevLineCr, COUNT(*)
FROM loan_application
GROUP BY RevLineCr;

-- N is 6.77 lac, 'Y' is 2.16 lac and 4556 are null values 
-- So we will replace the null values with 'N'

UPDATE loan_application
SET RevLineCr = 'N'
WHERE RevLineCr IS NULL;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us now fill the null values for Low Document column

SELECT DISTINCT LowDoc
FROM loan_application;

-- The LowDoc column is supposed to contain only two values: 'Y' (Yes) and 'N' (No), but it has various unexpected values such as 0, 1, nan, ,, A, etc.
-- We will assume that '0' means 'N', '1' means 'Y' else we will assign as nulls


-- Update LowDoc to clean up invalid values
UPDATE loan_application
SET LowDoc = CASE
    WHEN LowDoc = '0' THEN 'N'   
    WHEN LowDoc = '1' THEN 'Y'  
    WHEN LowDoc IN ('C', 'A', 'R', 'S') THEN NULL 
    ELSE LowDoc 
END
WHERE LowDoc IS NOT NULL;


SELECT DISTINCT LowDoc, COUNT(*)
FROM loan_application
GROUP by lowDoc;

-- N is 7.8 lac, 'Y' is 1.1 lac and 4515 are null values 
-- So we will replace the null values with 'N'

UPDATE loan_application
SET LowDoc = 'N'
WHERE LowDoc IS NULL;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Since ChgOffDate column has almost all the null values and of no use for our analysis 
-- We will use this column to fill null values of MIS_Status column nulls, then we will drop the column

UPDATE loan_application
SET MIS_Status = CASE
    WHEN ChgOffDate IS NOT NULL THEN 'CHGOFF'  -- Loan was charged off (defaulted)
    WHEN ChgOffDate IS NULL THEN 'PIF'         -- Loan was paid in full
END
WHERE MIS_Status IS NULL;


-- Drop the column ChgOffDate column since it is no longer needed

ALTER TABLE loan_application DROP COLUMN ChgOffDate;

-- Let us confirm that MIS_Status contain only two values
SELECT DISTINCT MIS_Status
FROM loan_application;

-- Let us convert the 'P I F' values into 'PIF'
UPDATE loan_application
SET MIS_Status = 'PIF'
WHERE TRIM(MIS_Status) = 'P I F';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us fill the null values for column DisbursementDate

-- We will Replace NULL values in DisbursementDate with the mode

UPDATE loan_application
SET DisbursementDate = (
    SELECT DisbursementDate
    FROM loan_application
    WHERE DisbursementDate IS NOT NULL
    GROUP BY DisbursementDate
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
WHERE DisbursementDate IS NULL;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us delete the remaining null values

DELETE FROM loan_application
WHERE LoanNr_ChkDgt IS NULL
   OR Name IS NULL
   OR City IS NULL
   OR State IS NULL
   OR Zip IS NULL
   OR Bank IS NULL
   OR BankState IS NULL
   OR NAICS IS NULL
   OR ApprovalDate IS NULL
   OR ApprovalFY IS NULL
   OR Term IS NULL
   OR NoEmp IS NULL
   OR NewExist IS NULL
   OR CreateJob IS NULL
   OR RetainedJob IS NULL
   OR FranchiseCode IS NULL
   OR UrbanRural IS NULL
   OR RevLineCr IS NULL
   OR LowDoc IS NULL
   OR ChgOffPrinGr IS NULL
   OR GrAppv IS NULL
   OR SBA_Appv IS NULL;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us see the distribution for the Numerical columns

-- Distribution of Loan Amounts
SELECT AVG(DisbursementGross), MIN(DisbursementGross), MAX(DisbursementGross)
FROM loan_application;

-- min is 0, AVG is 0.2 million and MAX is 11 million
-- Max is too far from the Average, means column is right skewed
-- Means there are some Outliers in the dataset

-- Distribution of remainig loan amount
SELECT AVG(BalanceGross), MIN(BalanceGross), MAX(BalanceGross)
FROM loan_application;

-- Min is 0, AVG is 2 and max is 0.9 million       
-- there can be some outliers present here

-- Distribution of number of employees business has
SELECT AVG(NoEmp), MIN(NoEmp), MAX(NoEmp)
FROM loan_application;

-- min is 0, avg is 11 and max is 9999
-- We have some well established business with almost 10k number of employees    

-- Distribution of number of jobs created after loan
SELECT AVG(CreateJob), MIN(CreateJob), MAX(CreateJob)
FROM loan_application;

-- min is 0, avg is 8 and max is 8800
-- average job created was around 8 jobs  after loan with some outliers 

-- Distribution of defaulted principal loan amount
SELECT AVG(ChgOffPrinGr), MIN(ChgOffPrinGr), MAX(ChgOffPrinGr)
FROM loan_application;

-- min is 0, avg is 13k and max is 3.5 million

-- Distribution of approved loan amount
SELECT AVG(GrAppv), MIN(GrAppv), MAX(GrAppv)
FROM loan_application;

-- min is 200, avg is 0.2 million and max is 5.4 million

-- Distribution of amount Guranteed by the SBA
SELECT AVG(SBA_Appv), MIN(SBA_Appv), MAX(SBA_Appv)
FROM loan_application;

-- min is 100, avg is 0.15 million and max is 5.4 million

-- Distribution of Term of loan
SELECT AVG(Term), MIN(Term), MAX(Term)
FROM loan_application;

-- min is 0, avg is 110 and max is 569
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us Analyze the relationship between MIS_Status (whether a loan was paid in full or charged off) and other features.

-- Let us see the state with the most defaulted loan
SELECT State, COUNT(*) AS defaulted_loans
FROM loan_application
WHERE MIS_Status = 'CHGOFF'
GROUP BY State
ORDER BY defaulted_loans DESC
LIMIT 1;

-- California(CA) has the highest number of defaulted loans (24170)

-- City in california with highest number of defaulted loans
SELECT City, COUNT(*) AS defaulted_loans
FROM loan_application
WHERE MIS_Status = 'CHGOFF' AND State = 'CA' 
GROUP BY City
ORDER BY defaulted_loans DESC
LIMIT 1;

-- Los Angeles has the highest number of defaulted loans (3181)

-- Let us see the Bank with the highest number of defaulted loans
SELECT Bank, COUNT(*) AS defaulted_loans
FROM loan_application
WHERE MIS_Status = 'CHGOFF'
GROUP BY Bank
ORDER BY defaulted_loans DESC
LIMIT 1;

-- Bank of America NATL assoc. has the highest number of default loans(23948)

WITH disbursement_stats AS (
    SELECT
        MIS_Status,
        MIN(DisbursementGross) AS min_value,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY DisbursementGross) AS first_quartile,
        PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY DisbursementGross) AS median_value,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY DisbursementGross) AS third_quartile,
        MAX(DisbursementGross) AS max_value
    FROM loan_application
    GROUP BY MIS_Status
)
SELECT *
FROM disbursement_stats;

-----------------------------------------------------------------------------------------------------
-- "mis_status"	 "min_value"	"first_quartile"	"median_value"	"third_quartile"	"max_value"    |
--  "CHGOFF"	   0.00	             27050	             61250	         140000	          4362157.00   | 
--  "PIF"	        0.00	          48000	             100000  	     255100	          11446325.00  |
-----------------------------------------------------------------------------------------------------

-- As we can see smaller loans has high risk of default as compare to bigger loan amount

-- Let us if Loc Document or quick business loan has high risk of defaulting
SELECT MIS_Status, COUNT(*)
FROM loan_application
WHERE LowDoc = 'Y'
GROUP BY MIS_Status;

--"mis_status"	"count"
--  "CHGOFF"	 9919
--  "PIF"	    100412

-- So if we calculate it in percentage than we see that it is close to 9% that is not abnormal as generally low document loans has high default rate

-- Let us see if urban rural column contain any insight
-- Count of PIF and CHGOFF for each UrbanRural category (0, 1, 2)
SELECT UrbanRural,
       COUNT(*) FILTER (WHERE MIS_Status = 'PIF') AS pif_count,
       COUNT(*) FILTER (WHERE MIS_Status = 'CHGOFF') AS chgoff_count
FROM loan_application
GROUP BY UrbanRural
ORDER BY UrbanRural;

--"urbanrural"	"pif_count"	  "chgoff_count"
--      0	         300074	         23069
--      1	         355638	         115016
--      2	         85611	         19731

-- As we see Urban areas has high default rate with 24% 
-- Rural area has 18% default rate 
-- Ans Undefined category  has lowest default rate with only 7%

-- Let us see the Distribution of Number of employees according to the PIF and CHAOFF category
WITH noemp AS (
    SELECT
        MIS_Status,
        MIN(NoEmp) AS min_value,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY NoEmp) AS first_quartile,
        PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY NoEmp) AS median_value,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY NoEmp) AS third_quartile,
        MAX(NoEmp) AS max_value
    FROM loan_application
    GROUP BY MIS_Status
)
SELECT *
FROM noemp;

-- "mis_status"	"min_value"	"first_quartile"	"median_value"	"third_quartile"	"max_value"
--   "CHGOFF"	    0	           2	               3	           7	           9999
--   "PIF"	        0	           2	               5	           11	           9999

-- We do not see a much difference here

-- Let us see if New or Existing business has the high default rate
SELECT NewExist,
       COUNT(*) FILTER (WHERE MIS_Status = 'PIF') AS pif_count,
       COUNT(*) FILTER (WHERE MIS_Status = 'CHGOFF') AS chgoff_count
FROM loan_application
GROUP BY NewExist
ORDER BY NewExist;

-- "newexist"	"pif_count"	 "chgoff_count"
--     0	         965	      68
--     1	         534586	    110296
--     2	         205772	    47452

-- As we see Existing(1) business has 17% default rate and new business(2) has 18% default rate 
-- Here is also we do not see much difference

-- Let us see the distribution of Term for PIF and CHAOFF category

WITH term_status AS (
    SELECT
        MIS_Status,
        MIN(Term) AS min_value,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Term) AS first_quartile,
        PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Term) AS median_value,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Term) AS third_quartile,
        MAX(Term) AS max_value
    FROM loan_application
    GROUP BY MIS_Status
)
SELECT *
FROM term_status;

-- "mis_status"	 "min_value"	"first_quartile"	"median_value"	"third_quartile"	"max_value"
--   "CHGOFF"	      0	              30	              50	          69	           461
--   "PIF"	          0	              77	              84	          180	           569

-- As we can see shorter term loan has high risk of loan defaulting 

-- let us see if the Year that has recession period included has any effect on loan default rate
SELECT ApprovalFY,
       COUNT(*) FILTER (WHERE MIS_Status = 'PIF') AS pif_count,
       COUNT(*) FILTER (WHERE MIS_Status = 'CHGOFF') AS chgoff_count
FROM loan_application
GROUP BY ApprovalFY
ORDER BY ApprovalFY;

-- As we wanted to see if recession period has high default rate but did not found any such pattern

-- Let us see if Reolving line of credit has any effect on default rates
SELECT RevLineCr,
       COUNT(*) FILTER (WHERE MIS_Status = 'PIF') AS pif_count,
       COUNT(*) FILTER (WHERE MIS_Status = 'CHGOFF') AS chgoff_count
FROM loan_application
GROUP BY RevLineCr
ORDER BY RevLineCr;

-- "revlinecr"	"pif_count" 	"chgoff_count"
--     "N"	       582225	      100196
--     "Y"	       159098	       57620

-- As we can see For revolving line of credit has 26% default rate
-- But not Revolving line of credit has only 14% default rate



-- Let us add the column Term Bucket
ALTER TABLE loan_application ADD COLUMN TermBucket VARCHAR(20);

-- Update the TermBucket column based on term thresholds
UPDATE loan_application
SET TermBucket = CASE
    WHEN Term <= 30 THEN 'Critical Risk'   -- 54%
	WHEN Term > 30 AND Term <= 50 THEN 'High Risk'   -- 56%
    WHEN Term > 50 AND Term <= 70 THEN 'Moderate Risk'   -- 28%
    WHEN Term > 70 AND Term <= 100 THEN 'Low Risk'   -- 7%
    ELSE 'Negligible Risk'  -- 5%
END;

-- Let us see the Term Bucket column distribution according to the MIS_Status

SELECT TermBucket,
       COUNT(*) FILTER (WHERE MIS_Status = 'PIF') AS pif_count,
       COUNT(*) FILTER (WHERE MIS_Status = 'CHGOFF') AS chgoff_count
FROM loan_application
GROUP BY TermBucket
ORDER BY TermBucket;

-- We see that the Very High Risk Bucket has a 54% default rate followed by High Risk Bucket with 36% default rate
-- Low Risk and Very Low Risk Bucket has 7% and 5% default rate 


-- Let us add the column LoanBucket
ALTER TABLE loan_application ADD COLUMN LoanBucket VARCHAR(20);


-- Update the LoanBucket column based on loan thresholds
UPDATE loan_application
SET LoanBucket = CASE
    WHEN DisbursementGross <= 30000 THEN 'Very High Risk'   -- 25%
    WHEN DisbursementGross > 30000 AND DisbursementGross <= 70000 THEN 'High Risk'  -- 21% 
    WHEN DisbursementGross > 70000 AND DisbursementGross <= 100000 THEN 'Low Risk'   -- 18%
    ELSE 'Very Low Risk'  -- 12%
END;


-- Let us see the Term Bucket column distribution according to the MIS_Status
SELECT LoanBucket,
       COUNT(*) FILTER (WHERE MIS_Status = 'PIF') AS pif_count,
       COUNT(*) FILTER (WHERE MIS_Status = 'CHGOFF') AS chgoff_count
FROM loan_application
GROUP BY LoanBucket
ORDER BY LoanBucket;

-- We see that the Very High Risk Bucket has a 25% default rate followed by High Risk Bucket with 21% default rate
-- Low Risk and Very Low Risk Bucket has 18% and 12% default rate


-- Let us add the column LoanRiskScore
ALTER TABLE loan_application ADD COLUMN LoanRiskScore DECIMAL;


-- Update the LoanRiskScore column based on loan and Term and Revolving line of credit etc.
UPDATE loan_application
SET LoanRiskScore = CASE
    WHEN NoEmp = 0 THEN DisbursementGross * (CASE WHEN Term = 0 THEN 1.0 ELSE 1.0/Term END) * (CASE WHEN LowDoc = 'Y' THEN 1.5 ELSE 1 END) * (CASE WHEN RevLineCr = 'Y' THEN 1.5 ELSE 1 END)
    ELSE DisbursementGross / NoEmp * (CASE WHEN Term = 0 THEN 1.0 ELSE 1.0/Term END) * (CASE WHEN LowDoc = 'Y' THEN 1.5 ELSE 1 END) * (CASE WHEN RevLineCr = 'Y' THEN 1.5 ELSE 1 END)
END;


-- Let us see the Risk Score column distribution according to the MIS_Status
WITH risk_score AS (
    SELECT
        MIS_Status,
        MIN(LoanRiskScore) AS min_value,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY LoanRiskScore) AS first_quartile,
        PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY LoanRiskScore) AS median_value,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY LoanRiskScore) AS third_quartile,
        MAX(LoanRiskScore) AS max_value
    FROM loan_application
    GROUP BY MIS_Status
)
SELECT *
FROM risk_score;


-- "mis_status"	  "min_value"	"first_quartile"	"median_value"	"third_quartile"	"max_value"
--    "CHGOFF"	     0.0	         194.8	             500	         1333.3	          930382.5
--    "PIF"	         0.0	         106.2	             240	         547.6	          624750.0

-- As we see higher the score higher the risk of default


-- Let us see the top five customers with highest loan amount who have not defaulted in the last two years

SELECT *,
       ROW_NUMBER() OVER (ORDER BY DisbursementGross DESC) AS rank
FROM loan_application
WHERE MIS_Status = 'PIF'  -- Customers who have not defaulted
  AND EXTRACT(YEAR FROM ApprovalDate) IN (2013, 2014)  -- Loans approved in last two years
ORDER BY DisbursementGross DESC  -- Ordered by the highest loan amounts
LIMIT 5;



-- Let us add the new column with categorising the loan eligible cutomer 

ALTER TABLE loan_application ADD COLUMN LoanEligibility VARCHAR(10);


-- Update LoanEligibility based on certain criteria

UPDATE loan_application
SET LoanEligibility = CASE
    -- Criteria 1: MIS_Status = 'PIF' and Term < 30, LoanRiskScore > 1000
    WHEN MIS_Status = 'PIF' 
         AND Term < 30 
         AND LoanRiskScore > 1000 
         AND NoEmp > 100 
         AND RetainedJob = NoEmp THEN 'Approved'
         
    -- Criteria 2: MIS_Status = 'PIF' and Term >= 30, LoanRiskScore > 1000
    WHEN MIS_Status = 'PIF' 
         AND Term >= 30 
         AND LoanRiskScore > 1000 
         AND NoEmp > 10 
         AND RetainedJob = NoEmp THEN 'Approved'
         
    -- Criteria 3: All other cases where MIS_Status = 'PIF' And LoanRiskScore<1000
    WHEN MIS_Status = 'PIF'
	     AND Term >= 30
		 AND LoanRiskScore < 1000 THEN 'Approved'
    
    -- Decline all others
    ELSE 'Declined'
END;


-- Let us check the accuracy score by comparing the LoanEligibility column with the MIS_Status column


SELECT 
    (SUM(CASE 
             WHEN (LoanEligibility = 'Approved' AND MIS_Status = 'PIF')
                  OR (LoanEligibility = 'Declined' AND MIS_Status = 'CHGOFF') 
             THEN 1 
             ELSE 0 
         END) * 1.0 / COUNT(*)) AS accuracy_score
FROM loan_application;


-- Accuracy score is 88%





