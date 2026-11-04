/*
PROJECT: IPL 2025 — ECONOMIC & SOCIAL IMPACT ANALYSIS
DATABASE: ipl_2025_analysis_clean
PURPOSE: SQL data-quality checks and business analysis for the IPL 2025 Power BI dashboard.

RUNNING NOTE:
1. Create the database and tables below.
2. Import the four source Excel datasets into the corresponding tables using MySQL Workbench.
3. Run the data-quality checks, required population updates, and analysis queries.
4. The script assumes the source data has been imported; it does not contain INSERT statements
   or recreate the Excel import process.

NOTE: Population figures are midpoint-based estimates from the supplied ranges.
Risk categories and index weights are project-defined analytical assumptions.
*/

-- SECTION 1: DATABASE AND TABLE SETUP
CREATE DATABASE IF NOT EXISTS ipl_2025_analysis_clean;
USE ipl_2025_analysis_clean;

-- 1. Central Contracts
CREATE TABLE fact_ipl_central_contracts (
    contract_type VARCHAR(150),
    partner_sponsor_name VARCHAR(150),
    amount_in_crores_2025 VARCHAR(50),
    total_deal_value_in_crores VARCHAR(50),
    contract_duration VARCHAR(100)
);

-- 2. Advertisers
CREATE TABLE fact_ipl_advertisers (
    sno INT PRIMARY KEY,
    advertiser_brand VARCHAR(150),
    category VARCHAR(150),
    brand_ambassadors TEXT,
    celebrity_influence VARCHAR(50),
    health_social_risk VARCHAR(150)
);

-- 3. Revenue Demography
CREATE TABLE fact_revenue_demography (
    company VARCHAR(150),
    sector VARCHAR(100),
    parent VARCHAR(150),
    latest_annual_revenue VARCHAR(100),
    age_group VARCHAR(100),
    income_group VARCHAR(150),
    urban_population VARCHAR(100),
    demographic_notes TEXT,
    source_url TEXT
);

-- 4. Summary Demography
CREATE TABLE fact_summary_demography (
    income_group VARCHAR(100),
    annual_income VARCHAR(100),
    estimated_user_population VARCHAR(100),
    key_characteristics TEXT,
    min_population DECIMAL(10,2),
    max_population DECIMAL(10,2),
    vulnerability_level VARCHAR(100)
);

USE ipl_2025_analysis_clean;

-- SECTION 2: IMPORTED RECORD-COUNT VALIDATION
SELECT 'fact_ipl_advertisers' AS table_name,
       COUNT(*) AS total_records
FROM fact_ipl_advertisers

UNION ALL

SELECT 'fact_ipl_central_contracts',
       COUNT(*)
FROM fact_ipl_central_contracts

UNION ALL

SELECT 'fact_revenue_demography',
       COUNT(*)
FROM fact_revenue_demography

UNION ALL

SELECT 'fact_summary_demography',
       COUNT(*)
FROM fact_summary_demography;

USE ipl_2025_analysis_clean;

-- SECTION 3: DATA QUALITY CHECKS
-- Data Quality Check: Identify Missing Values in Advertiser Records
SELECT
    sno,
    advertiser_brand,
    category,
    celebrity_influence,
    health_social_risk
FROM fact_ipl_advertisers
WHERE advertiser_brand IS NULL
   OR category IS NULL
   OR celebrity_influence IS NULL
   OR health_social_risk IS NULL;
   
   -- Data Quality Check: Identify Missing Values in Central Contract Records
   SELECT
    contract_type,
    partner_sponsor_name,
    amount_in_crores_2025,
    total_deal_value_in_crores,
    contract_duration
FROM fact_ipl_central_contracts
WHERE contract_type IS NULL
   OR partner_sponsor_name IS NULL
   OR contract_duration IS NULL;
   
   -- Data Quality Check: Identify Missing Values in Revenue Demographic Records
   SELECT
    company,
    sector,
    parent,
    latest_annual_revenue,
    age_group,
    income_group,
    urban_population
FROM fact_revenue_demography
WHERE company IS NULL
   OR sector IS NULL
   OR parent IS NULL
   OR age_group IS NULL
   OR income_group IS NULL
   OR urban_population IS NULL;
   
 -- Data Quality Check: Identify Missing Values in Summary Demographic Records  
   SELECT
    income_group,
    annual_income,
    estimated_user_population,
    min_population,
    max_population,
    vulnerability_level
FROM fact_summary_demography
WHERE income_group IS NULL
   OR annual_income IS NULL
   OR estimated_user_population IS NULL
   OR min_population IS NULL
   OR max_population IS NULL
   OR vulnerability_level IS NULL;

UPDATE fact_summary_demography
SET min_population = 150,
    max_population = 200,
    vulnerability_level = 'High Vulnerability'
WHERE income_group = 'Lower Income'
LIMIT 1;

UPDATE fact_summary_demography
SET min_population = 100,
    max_population = 150,
    vulnerability_level = 'High Vulnerability'
WHERE income_group = 'Lower-Middle'
LIMIT 1;

UPDATE fact_summary_demography
SET min_population = 30,
    max_population = 50,
    vulnerability_level = 'Medium Vulnerability'
WHERE income_group = 'Middle'
LIMIT 1;

SELECT *
FROM fact_summary_demography;

-- ADDITIONAL CHECK: SUMMARY DEMOGRAPHIC POPULATION AND VULNERABILITY
SELECT
    income_group,
    min_population,
    max_population,
    vulnerability_level
FROM fact_summary_demography;

-- SECTION 4: REVENUE AND SPONSORSHIP ANALYSIS
-- QUERY 1: IPL 2025 SPONSOR-WISE REVENUE ANALYSIS
SELECT
    partner_sponsor_name,
    CAST(
        REPLACE(amount_in_crores_2025, ',', '')
        AS DECIMAL(12,2)
    ) AS revenue_in_crores
FROM fact_ipl_central_contracts
WHERE amount_in_crores_2025 IS NOT NULL
  AND LOWER(amount_in_crores_2025) NOT IN ('n/a', 'na', '')
ORDER BY revenue_in_crores DESC;

-- QUERY 2: SPONSOR-WISE REVENUE CONTRIBUTION (%) USING WINDOW FUNCTIONS
SELECT
    partner_sponsor_name,
    CAST(
        REPLACE(amount_in_crores_2025, ',', '')
        AS DECIMAL(12,2)
    ) AS revenue_in_crores,
    ROUND(
        CAST(
            REPLACE(amount_in_crores_2025, ',', '')
            AS DECIMAL(12,2)
        ) * 100 /
        SUM(
            CAST(
                REPLACE(amount_in_crores_2025, ',', '')
                AS DECIMAL(12,2)
            )
        ) OVER (),
        2
    ) AS revenue_contribution_pct
FROM fact_ipl_central_contracts
WHERE amount_in_crores_2025 IS NOT NULL
  AND LOWER(amount_in_crores_2025) NOT IN ('n/a', 'na', '')
ORDER BY revenue_in_crores DESC;

-- SECTION 5: ADVERTISER RISK ANALYSIS
-- QUERY 3: ADVERTISER HEALTH AND SOCIAL RISK CLASSIFICATION
SELECT
    advertiser_brand,
    category,
    health_social_risk,
    CASE
        WHEN health_social_risk LIKE 'Extremely High%'
          OR health_social_risk LIKE 'Carcinogenic%'
            THEN 'Very High Risk'

        WHEN health_social_risk LIKE 'Very High%'
            THEN 'High Risk'

        WHEN health_social_risk LIKE 'High%'
            THEN 'High Risk'

        WHEN health_social_risk LIKE 'Moderate%'
            THEN 'Medium Risk'

        WHEN health_social_risk LIKE 'Low%'
            THEN 'Low Risk'

        ELSE 'Unclassified'
    END AS risk_category
FROM fact_ipl_advertisers
ORDER BY advertiser_brand;

-- QUERY 4: Combined Advertiser Risk Score Analysis
SELECT
    advertiser_brand,
    category,
    health_social_risk,
    celebrity_influence,

    -- Health and Social Risk Index
    CASE
        WHEN health_social_risk LIKE 'Extremely High%' 
          OR health_social_risk LIKE 'Carcinogenic%' THEN 5
        WHEN health_social_risk LIKE 'Very High%' THEN 4
        WHEN health_social_risk LIKE 'High%' THEN 3
        WHEN health_social_risk LIKE 'Moderate%' THEN 2
        WHEN health_social_risk LIKE 'Low%' THEN 1
        ELSE 0
    END AS health_risk_index,

    -- Celebrity Influence Index
    CASE
        WHEN TRIM(celebrity_influence) = 'Extremely High' THEN 5
        WHEN TRIM(celebrity_influence) LIKE 'Very%High%' THEN 4
        WHEN TRIM(celebrity_influence) = 'High' THEN 3
        WHEN TRIM(celebrity_influence) = 'Moderate' THEN 2
        WHEN TRIM(celebrity_influence) = 'Medium' THEN 2
        WHEN TRIM(celebrity_influence) = 'Low' THEN 1
        ELSE 0
    END AS celebrity_index,

    -- Combined Risk Score
    ROUND(
        (
            CASE
                WHEN health_social_risk LIKE 'Extremely High%' 
                  OR health_social_risk LIKE 'Carcinogenic%' THEN 5
                WHEN health_social_risk LIKE 'Very High%' THEN 4
                WHEN health_social_risk LIKE 'High%' THEN 3
                WHEN health_social_risk LIKE 'Moderate%' THEN 2
                WHEN health_social_risk LIKE 'Low%' THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN TRIM(celebrity_influence) = 'Extremely High' THEN 5
                WHEN TRIM(celebrity_influence) LIKE 'Very%High%' THEN 4
                WHEN TRIM(celebrity_influence) = 'High' THEN 3
                WHEN TRIM(celebrity_influence) = 'Moderate' THEN 2
                WHEN TRIM(celebrity_influence) = 'Medium' THEN 2
                WHEN TRIM(celebrity_influence) = 'Low' THEN 1
                ELSE 0
            END
        ) / 2,
        1
    ) AS combined_risk_score

FROM fact_ipl_advertisers
ORDER BY combined_risk_score DESC;

-- QUERY 5: Category-wise Advertiser Risk Analysis
SELECT
    category,
    COUNT(*) AS total_brands,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS category_percentage
FROM fact_ipl_advertisers
GROUP BY category
ORDER BY total_brands DESC;

-- QUERY 6: Advertiser Risk Distribution by Category
SELECT
    category,
    COUNT(*) AS total_brands,

    SUM(
        CASE
            WHEN health_social_risk LIKE 'Extremely High%'
              OR health_social_risk LIKE 'Carcinogenic%'
              OR health_social_risk LIKE 'Very High%'
              OR health_social_risk LIKE 'High%'
            THEN 1
            ELSE 0
        END
    ) AS high_risk_brands,

    ROUND(
        SUM(
            CASE
                WHEN health_social_risk LIKE 'Extremely High%'
                  OR health_social_risk LIKE 'Carcinogenic%'
                  OR health_social_risk LIKE 'Very High%'
                  OR health_social_risk LIKE 'High%'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS high_risk_percentage

FROM fact_ipl_advertisers
GROUP BY category
ORDER BY high_risk_percentage DESC;

-- QUERY 7: OVERALL ADVERTISER RISK SUMMARY
-- Matches the Power BI definition: Extremely High or Carcinogenic.

SELECT
    COUNT(*) AS total_advertisers,
    SUM(
        CASE
            WHEN health_social_risk LIKE '%Extremely High%'
              OR health_social_risk LIKE '%Carcinogenic%'
            THEN 1
            ELSE 0
        END
    ) AS high_risk_advertisers,
    ROUND(
        SUM(
            CASE
                WHEN health_social_risk LIKE '%Extremely High%'
                  OR health_social_risk LIKE '%Carcinogenic%'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS high_risk_percentage
FROM fact_ipl_advertisers;

-- QUERY 8: Advertising Ethics Index (AEI)

SELECT
    COUNT(*) AS total_advertisers,
    ROUND(
        SUM(
            CASE
                WHEN health_social_risk LIKE '%Extremely High%' THEN 5
                WHEN health_social_risk LIKE '%Carcinogenic%' THEN 15
                WHEN health_social_risk LIKE '%Moderate%' THEN 60
                WHEN health_social_risk LIKE '%Low%' THEN 100
                ELSE 0
            END
        ) / (COUNT(*) * 100.0) * 100,
        1
    ) AS advertising_ethics_index
FROM fact_ipl_advertisers;

-- QUERY 9: Sponsor and Advertiser Name Matching
SELECT
    c.partner_sponsor_name,
    a.advertiser_brand,
    c.amount_in_crores_2025,
    a.health_social_risk,
    a.celebrity_influence
FROM fact_ipl_central_contracts c
LEFT JOIN fact_ipl_advertisers a
    ON LOWER(TRIM(c.partner_sponsor_name))
     = LOWER(TRIM(a.advertiser_brand))
ORDER BY c.partner_sponsor_name;

-- QUERY 10: Revenue and Advertiser Risk Comparison
SELECT
    c.partner_sponsor_name,
    CAST(
        REPLACE(c.amount_in_crores_2025, ',', '')
        AS DECIMAL(12,2)
    ) AS revenue_in_crores,
    a.category,
    a.health_social_risk,
    a.celebrity_influence,
    CASE
        WHEN a.advertiser_brand IS NULL THEN 'No Risk Data'
        WHEN a.health_social_risk LIKE 'Extremely High%'
          OR a.health_social_risk LIKE 'Carcinogenic%'
            THEN 'Very High Risk'
        WHEN a.health_social_risk LIKE 'Very High%'
            THEN 'High Risk'
        WHEN a.health_social_risk LIKE 'High%'
            THEN 'High Risk'
        WHEN a.health_social_risk LIKE 'Moderate%'
            THEN 'Medium Risk'
        WHEN a.health_social_risk LIKE 'Low%'
            THEN 'Low Risk'
        ELSE 'Unclassified'
    END AS risk_category
FROM fact_ipl_central_contracts c
LEFT JOIN fact_ipl_advertisers a
    ON LOWER(TRIM(c.partner_sponsor_name))
     = LOWER(TRIM(a.advertiser_brand))
WHERE c.amount_in_crores_2025 IS NOT NULL
  AND LOWER(c.amount_in_crores_2025) NOT IN ('n/a', 'na', '')
ORDER BY revenue_in_crores DESC;

-- QUERY 11: Top High-Risk Advertisers Analysis
SELECT
    advertiser_brand,
    category,
    brand_ambassadors,
    health_social_risk,
    celebrity_influence,

    CASE
        WHEN health_social_risk LIKE 'Extremely High%'
          OR health_social_risk LIKE 'Carcinogenic%'
            THEN 'Very High Risk'

        WHEN health_social_risk LIKE 'Very High%'
            THEN 'High Risk'

        WHEN health_social_risk LIKE 'High%'
            THEN 'High Risk'

        ELSE 'Other Risk'
    END AS risk_category

FROM fact_ipl_advertisers

WHERE health_social_risk LIKE 'Extremely High%'
   OR health_social_risk LIKE 'Carcinogenic%'
   OR health_social_risk LIKE 'Very High%'
   OR health_social_risk LIKE 'High%'

ORDER BY health_social_risk, advertiser_brand;

-- SECTION 6: DEMOGRAPHIC AND POPULATION ANALYSIS
-- QUERY 12: POPULATION VULNERABILITY ANALYSIS
SELECT
    income_group,
    annual_income,
    estimated_user_population,
    min_population,
    max_population,
    key_characteristics,
    vulnerability_level
FROM fact_summary_demography
ORDER BY
    CASE income_group
        WHEN 'Lower Income' THEN 1
        WHEN 'Lower-Middle' THEN 2
        WHEN 'Middle' THEN 3
        ELSE 4
    END;

-- QUERY 13: High-Risk Brands and Demographic Impact
SELECT
    a.advertiser_brand,
    a.category,
    d.company AS demographic_company,
    d.age_group,
    d.income_group,
    d.urban_population,
    d.demographic_notes,
    a.health_social_risk
FROM fact_ipl_advertisers a
INNER JOIN fact_revenue_demography d
    ON (
        (a.advertiser_brand = 'Sporta Technologies (Dream11)'
            AND d.company = 'Dream11')
        OR
        (a.advertiser_brand = 'PokerBaazi'
            AND d.company = 'PokerBaazi')
        OR
        (a.advertiser_brand = 'My11Circle'
            AND d.company = 'My11Circle')
        OR
        (a.advertiser_brand = 'Vishnu Packaging (Vimal Elaichi)'
            AND d.company = 'Vimal Pan Masala')
        OR
        (a.advertiser_brand = 'Kamla Pasand'
            AND d.company = 'Kamla Pasand')
        OR
        (a.advertiser_brand = 'Rajshree Silver Coated Elaichi'
            AND d.company = 'Rajshree')
    )
WHERE
    a.health_social_risk LIKE 'Extremely High%'
    OR a.health_social_risk LIKE 'Carcinogenic%'
    OR a.health_social_risk LIKE 'Very High%'
    OR a.health_social_risk LIKE 'High%'
ORDER BY a.advertiser_brand;

-- SECTION 7: POWER BI KPI VALIDATION QUERIES
-- QUERY 14: AVERAGE ADVERTISER RISK SCORE

SELECT
    ROUND(
        AVG(
            CASE
                WHEN health_social_risk LIKE '%Extremely High%' THEN 5
                WHEN health_social_risk LIKE '%Carcinogenic%' THEN 4
                WHEN health_social_risk LIKE '%Moderate%' THEN 2
                WHEN health_social_risk LIKE '%Low%' THEN 1
                ELSE 0
            END
        ),
        2
    ) AS average_risk_score
FROM fact_ipl_advertisers;

-- QUERY 15: HIGH-RISK ADVERTISER SUMMARY

SELECT
    COUNT(*) AS total_advertisers,
    SUM(
        CASE
            WHEN health_social_risk LIKE '%Extremely High%'
              OR health_social_risk LIKE '%Carcinogenic%'
            THEN 1
            ELSE 0
        END
    ) AS high_risk_brands,
    ROUND(
        SUM(
            CASE
                WHEN health_social_risk LIKE '%Extremely High%'
                  OR health_social_risk LIKE '%Carcinogenic%'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS high_risk_percentage
FROM fact_ipl_advertisers;

-- QUERY 16: POPULATION IMPACT SUMMARY

SELECT
    SUM(
        (min_population + max_population) / 2
    ) AS total_population_millions,

    SUM(
        CASE
            WHEN income_group IN ('Lower Income', 'Lower-Middle')
            THEN (min_population + max_population) / 2
            ELSE 0
        END
    ) AS population_at_risk_millions,

    ROUND(
        SUM(
            CASE
                WHEN income_group IN ('Lower Income', 'Lower-Middle')
                THEN (min_population + max_population) / 2
                ELSE 0
            END
        ) * 100.0 /
        SUM((min_population + max_population) / 2),
        1
    ) AS high_vulnerability_percentage

FROM fact_summary_demography;
