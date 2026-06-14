# 🏏 IPL 2025 — Economic & Social Impact Analysis
**Business Analytics Dashboard** — Analyzing IPL 2025's massive economic footprint alongside the social and health implications of its advertising ecosystem, using SQL and Power BI.

---

## 📌 Project Overview
This project analyzes IPL 2025's central sponsorship contracts, advertiser portfolio, and target demographics to provide a **balanced view** of how IPL drives economic growth while examining the potential consequences of certain advertising practices (Pan Masala, Fantasy Gaming/Betting apps).

Inspired by the **CodeBasics Resume Project Challenge #15** — "Provide Insights to a Business Magazine by Analysing the Economic and Social Impact of the IPL."

---

## 🎯 Problem Statement
More than 50% of IPL advertisements are occupied by fantasy sports apps and pan masala brands. This project answers:
- 💰 What is IPL's total revenue from central contracts in 2025, and who are the top contributors?
- ⚠️ What is the health/social risk index of major advertisers?
- 👥 How many people are exposed to high-risk advertising during IPL?
- 📊 What is IPL's overall "Advertising Ethics Index" (AEI)?

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| MySQL | Data cleaning, risk index calculation, KPI queries |
| Power BI (DAX, Power Query) | 3-page interactive dashboard |
| Excel | Source data (CodeBasics datasets) |

---

## 📊 Dataset

| File | Contains |
|------|----------|
| fact_ipl_central_contracts | Sponsorship deals, amounts (2025), total deal value, duration |
| fact_ipl_advertisers | Advertiser brands, categories, celebrity ambassadors, health/social risk |
| fact_revenue_demography | Company revenue, target age/income groups, urban reach |
| fact_summary_demography | Income groups, population estimates, key characteristics |

Source: CodeBasics Resume Project Challenge #15

---

## 🔑 Key SQL Queries

### 1. Total IPL Revenue 2025
```sql
SELECT SUM(CAST(amount_in_crores_2025 AS DECIMAL(10,2))) AS total_revenue_crores
FROM fact_ipl_central_contracts
WHERE amount_in_crores_2025 != 'n/a';
```

### 2. Health Risk Index (Qualitative to Quantitative)
```sql
SELECT advertiser_brand, category,
    CASE 
        WHEN health_social_risk LIKE '%Extremely High%' THEN 5
        WHEN health_social_risk LIKE '%Carcinogenic%' THEN 4
        WHEN health_social_risk LIKE '%Moderate%' THEN 2
        WHEN health_social_risk LIKE '%Low%' THEN 1
        ELSE 0
    END AS health_risk_index
FROM fact_ipl_advertisers
ORDER BY health_risk_index DESC;
```

### 3. Advertising Ethics Index (AEI)
```sql
SELECT ROUND(
    (SUM(CASE 
        WHEN health_social_risk LIKE '%Low%' THEN 100
        WHEN health_social_risk LIKE '%Moderate%' THEN 60
        WHEN health_social_risk LIKE '%Carcinogenic%' THEN 15
        WHEN health_social_risk LIKE '%Extremely High%' THEN 5
        ELSE 0
    END) / (COUNT(*) * 100)) * 100, 1) AS advertising_ethics_index
FROM fact_ipl_advertisers;
```

---

## 💡 Key Insights

- 💰 IPL 2025 Total Central Contract Revenue = **₹10,215 Crores**
- 📺 Media Rights (JioCinema 46.51% + Star Sports 46.16%) = **92.67%** of total revenue
- 🏆 Title Sponsor (Tata Group) contributes only **4.89%**
- 🔴 **6 out of 10** major advertisers (60%) carry "Extremely High" or "Carcinogenic" health/social risk
- ⚖️ Pan Masala and Fantasy Gaming/Betting categories each average a **5.0/5** risk score
- 📉 **Advertising Ethics Index (AEI) = 33/100** — indicating a poor ethical advertising environment
- 👥 An estimated **300 million people (88.2%)** fall in the income groups most targeted by high-risk advertisers
- 🌟 Top celebrities (Shah Rukh Khan, Salman Khan, Rohit Sharma, Sourav Ganguly) endorse brands with the highest combined risk scores

---

## 📋 Dashboard Pages

### Page 1 — Revenue & Contracts Dashboard
- KPI Cards: Total Revenue, Total Sponsors, Advertising Ethics Index, High Risk Brands
- Donut Chart: Revenue share by sponsor
- Bar Chart: Revenue by contract type
- Table: Sponsor-wise contract details

### Page 2 — Advertiser Risk Analysis
- KPI Cards: High Risk Brands, Avg Risk Score, High Risk %, AEI
- Bar Chart: Risk Score by Brand
- Pie Chart: Risk distribution by category
- Table: Brand, category, celebrity influence, health/social risk

### Page 3 — Population & Social Impact
- KPI Cards: Total Population at Risk, Safe Population %, Total Population, High Vulnerability %
- Bar Chart: Population by income group
- Column Chart: Vulnerability level by income group
- Table: Income group demographics and vulnerability classification

---

## 📁 Repository Files

| File | Description |
|------|-------------|
| fact_ipl_central_contracts.xlsx | Raw sponsorship contracts data |
| fact_ipl_advertisers.xlsx | Raw advertiser/brand data |
| fact_revenue_demography.xlsx | Raw revenue and demographic data |
| fact_summary_demography.xlsx | Raw income group population data |
| IPL_2025_Analysis.sql | All SQL queries for KPI and risk analysis |
| Ipl_2025_Analysis.pbix | Power BI 3-page interactive dashboard |
| IPL_2025_Dashboard.pdf | Dashboard PDF export |

---

## 🎯 Expected Outcomes Addressed
- ✅ Balanced scorecard evaluating economic contribution vs. social impact
- ✅ Custom "Advertising Ethics Index" KPI (scored 33/100 for IPL 2025)
- ✅ Recommendations for responsible advertising while preserving revenue

---

## 👤 Author
**Chandu Manikanta**  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?logo=linkedin)](https://www.linkedin.com/in/chandumanikanta/) [![GitHub](https://img.shields.io/badge/GitHub-black?logo=github)](https://github.com/chandu2627)
