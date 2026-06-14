CREATE DATABASE ipl_2025_analysis;
USE ipl_2025_analysis;

-- Table 1: Central Contracts
CREATE TABLE fact_ipl_central_contracts (
    contract_type VARCHAR(100),
    partner_sponsor_name VARCHAR(100),
    amount_in_crores_2025 VARCHAR(50),
    total_deal_value_in_crores VARCHAR(50),
    contract_duration VARCHAR(100)
);
INSERT INTO fact_ipl_advertisers
(sno, advertiser_brand, category, brand_ambassadors, celebrity_influence, health_social_risk)
VALUES
(1, 'Vimal Elaichi', 'Pan Masala', 'Shah Rukh Khan, Ajay Devgn, Akshay Kumar', 'Extremely High', 'Extremely High'),
(2, 'Dream11', 'Fantasy Gaming', 'Rohit Sharma, Aamir Khan, Ranbir Kapoor', 'Very High', 'Extremely High'),
(3, 'Reliance Consumer', 'FMCG', 'multiple', 'Medium', 'Moderate'),
(4, 'My11Circle', 'Fantasy Gaming', 'Sourav Ganguly, Shubman Gill', 'High', 'Extremely High'),
(5, 'Rajshree Elaichi', 'Pan Masala', 'Salman Khan', 'Very High', 'Extremely High'),
(6, 'Parle Biscuits', 'FMCG', 'Ananya Panday', 'Moderate', 'Moderate'),
(7, 'Kamla Pasand', 'Pan Masala', 'Virender Sehwag, Sunil Gavaskar', 'Very High', 'Extremely High'),
(8, 'PokerBaazi', 'Fantasy Gaming', 'Shahid Kapoor', 'High', 'Extremely High'),
(9, 'Britannia', 'FMCG', 'multiple', 'Medium', 'Moderate'),
(10, 'Amazon Prime', 'OTT', 'Varun Dhawan, Alia Bhatt', 'High', 'Low');

Select * from fact_ipl_advertisers;
TRUNCATE TABLE fact_ipl_advertisers;


INSERT INTO fact_ipl_central_contracts 
(contract_type, partner_sponsor_name, amount_in_crores_2025, total_deal_value_in_crores, contract_duration)
VALUES
('Title Sponsor', 'Tata Group', '500', '2500', '5 Years (2024-2028)'),
('Associate Partner', 'My11Circle', '125', '625', '5 Years (2024-2028)'),
('Associate Partner', 'Angel One', '82', '410', '5 Years (2024-2028)'),
('Associate Partner', 'RuPay', '42', '210', '5 Years (2024-2028)'),
('Official Broadcaster TV', 'Star Sports', '4715', '23575', '5 Years (2024-2028)'),
('Official Digital Streaming', 'JioCinema', '4751', '23758', '5 Years (2024-2028)'),
('Official Strategic Timeout', 'CEAT', 'n/a', 'n/a', '5 Years (2024-2028)'),
('Official Umpire Partner', 'Wonder Cement', 'n/a', 'n/a', '5 Years (2024-2028)'),
('Orange Purple Cap Partner', 'Aramco', 'n/a', 'n/a', '5 Years (2024-2028)');
SELECT * FROM fact_ipl_central_contracts;

-- Table 2: Advertisers
CREATE TABLE fact_ipl_advertisers (
    sno INT,
    advertiser_brand VARCHAR(100),
    category VARCHAR(100),
    brand_ambassadors TEXT,
    celebrity_influence VARCHAR(50),
    health_social_risk TEXT
);

INSERT INTO fact_ipl_advertisers
(sno, advertiser_brand, category, brand_ambassadors, celebrity_influence, health_social_risk)
VALUES
(1, 'Vimal Elaichi', 'Pan Masala', 'Shah Rukh Khan, Ajay Devgn, Akshay Kumar', 'Extremely High', 'Extremely High'),
(2, 'Dream11', 'Fantasy Gaming', 'Rohit Sharma, Aamir Khan, Ranbir Kapoor', 'Very High', 'Extremely High'),
(3, 'Reliance Consumer', 'FMCG', 'multiple', 'Medium', 'Moderate'),
(4, 'My11Circle', 'Fantasy Gaming', 'Sourav Ganguly, Shubman Gill', 'High', 'Extremely High'),
(5, 'Rajshree Elaichi', 'Pan Masala', 'Salman Khan', 'Very High', 'Extremely High'),
(6, 'Parle Biscuits', 'FMCG', 'Ananya Panday', 'Moderate', 'Moderate'),
(7, 'Kamla Pasand', 'Pan Masala', 'Virender Sehwag, Sunil Gavaskar', 'Very High', 'Extremely High'),
(8, 'PokerBaazi', 'Fantasy Gaming', 'Shahid Kapoor', 'High', 'Extremely High'),
(9, 'Britannia', 'FMCG', 'multiple', 'Medium', 'Moderate'),
(10, 'Amazon Prime', 'OTT', 'Varun Dhawan, Alia Bhatt', 'High', 'Low');

Select * from fact_ipl_advertisers;


-- Table 3: Revenue Demography
CREATE TABLE fact_revenue_demography (
    company VARCHAR(100),
    sector VARCHAR(100),
    parent VARCHAR(100),
    latest_annual_revenue VARCHAR(100),
    age_group VARCHAR(100),
    income_group VARCHAR(100),
    urban_population VARCHAR(100),
    demographic_notes TEXT
);
INSERT INTO fact_revenue_demography
(company, sector, parent, latest_annual_revenue, age_group, income_group, urban_population, demographic_notes)
VALUES
('Dream11', 'Fantasy/App', 'Dream Sports', '6384', '20-35', 'Middle & Upper-middle', 'Urban & Tier 2/3', '77% male'),
('PokerBaazi', 'Fantasy/App', 'Moonshine Technology', '415', '25-34', 'Middle & Upper-middle', 'Urban', '68% male'),
('My11Circle', 'Fantasy/App', 'Games24x7', '2000', '25-34', 'Middle & Upper-middle', 'Urban & Rural', '81% male'),
('Vimal Pan Masala', 'Pan Masala', 'DS Group', '5267', '18-40', 'Lower to Upper-middle', 'Urban & Rural', 'Mass market'),
('Kamla Pasand', 'Pan Masala', 'KP Group', 'Not disclosed', '18-40', 'Lower to Upper-middle', 'Urban & Rural', 'North/Central India'),
('Rajshree', 'Pan Masala', 'KP Group', 'Not disclosed', '18-40', 'Lower to Middle', 'Urban & Rural', 'Rural focus');

Select * from fact_revenue_demography;

-- Table 4: Summary Demography

CREATE TABLE fact_summary_demography (
    income_group VARCHAR(100),
    annual_income VARCHAR(100),
    estimated_user_population VARCHAR(100),
    key_characteristics TEXT
);
INSERT INTO fact_summary_demography
(income_group, annual_income, estimated_user_population, key_characteristics)
VALUES
('Lower Income', 'Less than 3 Lakhs', '150-200 million', 'Daily wage workers, rural populations'),
('Lower-Middle', '3-7 Lakhs', '100-150 million', 'Urban migrants, small traders'),
('Middle', '7-12 Lakhs', '30-50 million', 'Urban professionals, casual gamers'),
('Upper-Middle', '12-25 Lakhs', '15-25 million', 'Corporate professionals, active investors'),
('High Income', 'Above 25 Lakhs', '5-10 million', 'Business owners, senior executives');

Select * from fact_summary_demography;

-- ================================================
-- IPL 2025 Business Analytics
-- SQL Analysis Queries
-- ================================================

USE ipl_2025_analysis;

-- ================================================
-- QUERY 1: Total IPL Revenue 2025
-- ================================================
SELECT 
    SUM(CAST(amount_in_crores_2025 AS DECIMAL(10,2))) AS total_revenue_crores
FROM fact_ipl_central_contracts
WHERE amount_in_crores_2025 != 'n/a';

-- ================================================
-- QUERY 2: Revenue % by Sponsor
-- ================================================
SELECT 
    partner_sponsor_name,
    contract_type,
    amount_in_crores_2025,
    ROUND(
        CAST(amount_in_crores_2025 AS DECIMAL(10,2)) / 
        (SELECT SUM(CAST(amount_in_crores_2025 AS DECIMAL(10,2))) 
         FROM fact_ipl_central_contracts 
         WHERE amount_in_crores_2025 != 'n/a') * 100, 2
    ) AS revenue_percentage
FROM fact_ipl_central_contracts
WHERE amount_in_crores_2025 != 'n/a'
ORDER BY CAST(amount_in_crores_2025 AS DECIMAL(10,2)) DESC;

-- ================================================
-- QUERY 3: Health Risk Index by Brand
-- ================================================
SELECT 
    advertiser_brand,
    category,
    celebrity_influence,
    health_social_risk,
    CASE 
        WHEN health_social_risk = 'Extremely High' THEN 5
        WHEN health_social_risk = 'Very High' THEN 4
        WHEN health_social_risk = 'High' THEN 3
        WHEN health_social_risk = 'Moderate' THEN 2
        WHEN health_social_risk = 'Low' THEN 1
        ELSE 0
    END AS health_risk_index,
    CASE 
        WHEN celebrity_influence = 'Extremely High' THEN 5
        WHEN celebrity_influence = 'Very High' THEN 4
        WHEN celebrity_influence = 'High' THEN 3
        WHEN celebrity_influence = 'Moderate' THEN 2
        WHEN celebrity_influence = 'Medium' THEN 2
        WHEN celebrity_influence = 'Low' THEN 1
        ELSE 0
    END AS celebrity_influence_index
FROM fact_ipl_advertisers
ORDER BY health_risk_index DESC;

-- ================================================
-- QUERY 4: Combined Risk Score
-- ================================================
SELECT 
    advertiser_brand,
    category,
    CASE 
        WHEN health_social_risk = 'Extremely High' THEN 5
        WHEN health_social_risk = 'Very High' THEN 4
        WHEN health_social_risk = 'Moderate' THEN 2
        WHEN health_social_risk = 'Low' THEN 1
        ELSE 0
    END AS health_risk_index,
    CASE 
        WHEN celebrity_influence = 'Extremely High' THEN 5
        WHEN celebrity_influence = 'Very High' THEN 4
        WHEN celebrity_influence = 'High' THEN 3
        WHEN celebrity_influence = 'Moderate' THEN 2
        WHEN celebrity_influence = 'Medium' THEN 2
        WHEN celebrity_influence = 'Low' THEN 1
        ELSE 0
    END AS celebrity_index,
    ROUND(
        (CASE 
            WHEN health_social_risk = 'Extremely High' THEN 5
            WHEN health_social_risk = 'Very High' THEN 4
            WHEN health_social_risk = 'Moderate' THEN 2
            WHEN health_social_risk = 'Low' THEN 1
            ELSE 0
        END +
        CASE 
            WHEN celebrity_influence = 'Extremely High' THEN 5
            WHEN celebrity_influence = 'Very High' THEN 4
            WHEN celebrity_influence = 'High' THEN 3
            WHEN celebrity_influence = 'Moderate' THEN 2
            WHEN celebrity_influence = 'Medium' THEN 2
            WHEN celebrity_influence = 'Low' THEN 1
            ELSE 0
        END) / 2, 1
    ) AS combined_risk_score
FROM fact_ipl_advertisers
ORDER BY combined_risk_score DESC;

-- ================================================
-- QUERY 5: Category wise Risk Analysis
-- ================================================
SELECT 
    category,
    COUNT(*) AS total_brands,
    ROUND(AVG(
        CASE 
            WHEN health_social_risk = 'Extremely High' THEN 5
            WHEN health_social_risk = 'Very High' THEN 4
            WHEN health_social_risk = 'Moderate' THEN 2
            WHEN health_social_risk = 'Low' THEN 1
            ELSE 0
        END
    ), 1) AS avg_health_risk,
    ROUND(AVG(
        CASE 
            WHEN celebrity_influence = 'Extremely High' THEN 5
            WHEN celebrity_influence = 'Very High' THEN 4
            WHEN celebrity_influence = 'High' THEN 3
            WHEN celebrity_influence = 'Moderate' THEN 2
            WHEN celebrity_influence = 'Medium' THEN 2
            WHEN celebrity_influence = 'Low' THEN 1
            ELSE 0
        END
    ), 1) AS avg_celebrity_influence
FROM fact_ipl_advertisers
GROUP BY category
ORDER BY avg_health_risk DESC;

-- ================================================
-- QUERY 6: Population Vulnerability Analysis
-- ================================================
SELECT 
    income_group,
    annual_income,
    estimated_user_population,
    key_characteristics,
    CASE
        WHEN income_group IN ('Lower Income', 'Lower-Middle') 
        THEN 'High Vulnerability'
        WHEN income_group = 'Middle' 
        THEN 'Medium Vulnerability'
        ELSE 'Low Vulnerability'
    END AS vulnerability_level
FROM fact_summary_demography
ORDER BY 
    CASE income_group
        WHEN 'Lower Income' THEN 1
        WHEN 'Lower-Middle' THEN 2
        WHEN 'Middle' THEN 3
        WHEN 'Upper-Middle' THEN 4
        WHEN 'High Income' THEN 5
    END;

-- ================================================
-- QUERY 7: High Risk Brands Population Impact
-- ================================================
SELECT 
    r.company,
    r.sector,
    r.age_group,
    r.income_group,
    r.urban_population,
    a.health_social_risk,
    CASE 
        WHEN a.health_social_risk = 'Extremely High' THEN 5
        WHEN a.health_social_risk = 'Very High' THEN 4
        WHEN a.health_social_risk = 'Moderate' THEN 2
        WHEN a.health_social_risk = 'Low' THEN 1
        ELSE 0
    END AS risk_score
FROM fact_revenue_demography r
JOIN fact_ipl_advertisers a 
    ON r.sector = a.category
ORDER BY risk_score DESC;

-- ================================================
-- QUERY 8: Advertising Ethics Index (AEI)
-- ================================================
SELECT 
    ROUND(
        (SUM(CASE 
            WHEN health_social_risk = 'Low' THEN 100
            WHEN health_social_risk = 'Moderate' THEN 60
            WHEN health_social_risk = 'High' THEN 30
            WHEN health_social_risk = 'Very High' THEN 15
            WHEN health_social_risk = 'Extremely High' THEN 5
            ELSE 0
        END) / (COUNT(*) * 100)) * 100
    , 1) AS advertising_ethics_index
FROM fact_ipl_advertisers;

-- ================================================
-- QUERY 9: Revenue vs Risk Comparison
-- ================================================
SELECT 
    c.contract_type,
    c.partner_sponsor_name,
    c.amount_in_crores_2025,
    COALESCE(a.health_social_risk, 'N/A') AS health_risk,
    COALESCE(a.category, 'N/A') AS category
FROM fact_ipl_central_contracts c
LEFT JOIN fact_ipl_advertisers a 
    ON c.partner_sponsor_name = a.advertiser_brand
ORDER BY CAST(
    CASE WHEN c.amount_in_crores_2025 = 'n/a' 
    THEN '0' 
    ELSE c.amount_in_crores_2025 END 
AS DECIMAL(10,2)) DESC;

-- ================================================
-- QUERY 10: Top High Risk Brands Summary
-- ================================================
SELECT 
    advertiser_brand,
    category,
    brand_ambassadors,
    health_social_risk,
    celebrity_influence,
    CASE 
        WHEN health_social_risk = 'Extremely High' THEN 'BANNED in many countries'
        WHEN health_social_risk = 'Very High' THEN 'Heavily regulated'
        WHEN health_social_risk = 'Moderate' THEN 'Some regulations'
        ELSE 'Minimal regulations'
    END AS regulatory_status
FROM fact_ipl_advertisers
WHERE health_social_risk IN ('Extremely High', 'Very High')
ORDER BY health_social_risk DESC;

SET SQL_SAFE_UPDATES = 0;

UPDATE fact_summary_demography SET min_population = 150, max_population = 200 
WHERE income_group = 'Lower Income';

UPDATE fact_summary_demography SET min_population = 100, max_population = 150 
WHERE income_group = 'Lower-Middle';

UPDATE fact_summary_demography SET min_population = 30, max_population = 50 
WHERE income_group = 'Middle';

UPDATE fact_summary_demography SET min_population = 15, max_population = 25 
WHERE income_group = 'Upper-Middle';

UPDATE fact_summary_demography SET min_population = 5, max_population = 10 
WHERE income_group = 'High Income';

-- Turn safe mode back on
SET SQL_SAFE_UPDATES = 1;

-- Verify
SELECT * FROM fact_summary_demography;