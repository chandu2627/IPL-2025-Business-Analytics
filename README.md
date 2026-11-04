# 🏏 IPL 2025 — Economic & Social Impact Analysis

**Business Analytics Dashboard | SQL • MySQL • Power BI**

An end-to-end business analytics project analyzing IPL 2025's economic footprint, sponsorship revenue, advertiser risk, and demographic impact using MySQL and Power BI.

---

## 📌 Project Overview

The Indian Premier League (IPL) is one of the world's major sporting and entertainment events, generating substantial revenue through media rights, sponsorships, and advertising.

This project explores the economic contribution of IPL 2025 while examining the potential health and social implications of its advertising ecosystem, particularly Fantasy Gaming/Betting and Pan Masala brands.

The project was developed as part of the **CodeBasics Resume Project Challenge #15**:

*"Provide Insights to a Business Magazine by Analysing the Economic and Social Impact of the IPL."*

---

## 🎯 Business Problem

The project addresses the following business questions:

- 💰 What is the total revenue generated through IPL 2025 central contracts?
- 📊 Which sponsors contribute the most to IPL revenue?
- ⚠️ What are the health and social risks associated with major advertisers?
- 👥 Which income groups are potentially more vulnerable to high-risk advertising?
- ⚖️ What is the overall Advertising Ethics Index (AEI)?

---

## 🛠️ Tools & Technologies

| Technology | Purpose |
|---|---|
| Microsoft Excel | Original source datasets |
| MySQL | Database storage, data quality checks, SQL analysis |
| SQL | Aggregations, joins, CASE statements, window functions |
| Power BI | Interactive dashboard development |
| Power Query | MySQL data connection and transformation |
| DAX | KPI calculations, measures and analytical metrics |
| GitHub | Project version control and documentation |

---

## 🔄 Project Workflow

**Excel → MySQL → Power BI → Business Insights**

1. **Data Collection:** Started with four source datasets provided for the CodeBasics project challenge.
2. **Database Setup:** Created the `ipl_2025_analysis_clean` database in MySQL.
3. **Data Loading:** Imported the four source datasets into their corresponding MySQL tables.
4. **Data Quality:** Performed missing-value checks and populated demographic estimation fields.
5. **SQL Analysis:** Developed analytical queries using aggregations, joins, CASE statements and window functions.
6. **Power BI Integration:** Connected Power BI directly to MySQL using Power Query.
7. **Dashboard Development:** Created three interactive dashboard pages with DAX measures and visualizations.

---

## 🗄️ MySQL Database Structure

**Database:** `ipl_2025_analysis_clean`

The database contains four tables:

| Table | Description | Records |
|---|---|---:|
| `fact_ipl_advertisers` | Advertiser brands, categories, ambassadors and health/social risks | 10 |
| `fact_ipl_central_contracts` | Central sponsorship contracts and revenue | 9 |
| `fact_revenue_demography` | Company revenue and demographic information | 6 |
| `fact_summary_demography` | Income groups, population estimates and vulnerability levels | 3 |

**Total records: 28**

---

## 📊 Key SQL Concepts Used

- Database and table creation
- Data quality and NULL checks
- UPDATE statements
- Aggregate functions: `SUM()`, `COUNT()`, `AVG()`
- Conditional logic using `CASE WHEN`
- Data type conversion using `CAST()`
- String manipulation using `TRIM()` and `REPLACE()`
- Joins: `INNER JOIN` and `LEFT JOIN`
- Window functions using `SUM() OVER()`
- Percentage contribution and risk calculations
- Population and demographic analysis

The complete SQL analysis is available in [`IPL_2025_Analysis.sql`](IPL_2025_Analysis.sql).

---

## 📈 Key Business Insights

### Revenue & Sponsorship

- 💰 **Total IPL 2025 Central Contract Revenue: ₹10,215 Crores**
- 📺 JioCinema contributes approximately **46.51%** of revenue.
- 📺 Star Sports contributes approximately **46.16%** of revenue.
- Together, the two media partners contribute approximately **92.67%**.
- 🏆 Tata Group contributes approximately **4.89%**.

### Advertiser Risk Analysis

- 🔴 **6 out of 10 advertisers (60%)** fall into the project's high-risk classification.
- ⚖️ **Advertising Ethics Index (AEI): 33/100**.
- 📊 Average Advertiser Risk Score: **3.50**.
- Fantasy Gaming/Betting and Pan Masala/Mouth Freshener are the two categories highlighted in the risk distribution analysis.

### Population & Social Impact

- 👥 Estimated total population represented by the selected income groups: **340 million**.
- 🔴 Estimated population in the Lower Income and Lower-Middle groups: **300 million**.
- **High Vulnerability: 88.2%**.
- **Safe Population: 11.8%**.

*Population figures are midpoint-based estimates calculated from the supplied population ranges. They should not be interpreted as independently verified population counts or direct measurements of advertising exposure.*

---

## 📊 Power BI Dashboard

The project contains three dashboard pages.

### 1. Revenue & Contracts Dashboard

- KPI Cards: Total Revenue, Total Sponsors, Advertising Ethics Index and High Risk Brands.
- Donut Chart: Revenue contribution by sponsor.
- Bar Chart: Revenue by contract type.
- Table: Sponsor-wise contract details.

### 2. Advertiser Risk Analysis

- KPI Cards: High Risk Brands, Average Risk Score, High Risk Percentage and AEI.
- Pie Chart: Advertiser distribution by category.
- Bar Chart: Combined Risk Score by Brand.
- Table: Advertiser brand, category, celebrity influence and health/social risk.

### 3. Population & Social Impact

- KPI Cards: Total Population at Risk, Safe Population Percentage, Total Population and High Vulnerability Percentage.
- Bar Chart: Population by income group.
- Column Chart: Vulnerability by income group.
- Table: Income group, annual income, user population, key characteristics and vulnerability level.

---

## 📁 Repository Structure

```text
IPL-2025-Business-Analytics/
│
├── IPL_2025_Analysis.sql
├── Ipl_2025_Analysis.pbix
├── Ipl_2025_Analysis.pdf
├── README.md
│
├── fact_ipl_advertisers.xlsx
├── fact_ipl_central_contracts.xlsx
├── fact_revenue_demography.xlsm
└── fact_summary_demography.xlsx
```

### Repository Files

| File | Description |
|---|---|
| `IPL_2025_Analysis.sql` | SQL database setup, data quality checks and analysis queries |
| `Ipl_2025_Analysis.pbix` | Three-page interactive Power BI dashboard |
| `Ipl_2025_Analysis.pdf` | Dashboard PDF export |
| `fact_ipl_advertisers.xlsx` | Original advertiser dataset |
| `fact_ipl_central_contracts.xlsx` | Original sponsorship contracts dataset |
| `fact_revenue_demography.xlsm` | Original revenue and demographic dataset |
| `fact_summary_demography.xlsx` | Original population summary dataset |

---

## ⚙️ How to Run This Project

### Prerequisites

- MySQL Server and MySQL Workbench
- Microsoft Power BI Desktop
- MySQL connector for Power BI

### Step 1: Prepare the Database

Create the database and tables using the SQL script.

```sql
CREATE DATABASE ipl_2025_analysis_clean;
USE ipl_2025_analysis_clean;
```

### Step 2: Import the Source Datasets

Import the four Excel datasets into their corresponding MySQL tables using MySQL Workbench.

### Step 3: Execute SQL Analysis

Run the SQL script to perform data quality checks, population updates and business analysis.

### Step 4: Open Power BI

Open `Ipl_2025_Analysis.pbix`.

Configure the MySQL connection using your own server and database credentials if required.

**Note:** The published PBIX was developed using a local MySQL connection. Other users must configure their own MySQL environment and connection settings to refresh the report.

---

## 📌 Methodology & Assumptions

- Advertiser risk scores and the Advertising Ethics Index are project-defined analytical measures, not official regulatory ratings.
- Population estimates use the midpoint of the supplied minimum and maximum ranges.
- High-risk classification follows the definitions used in the Power BI KPI calculations.
- Revenue figures are based on the supplied IPL 2025 central contract dataset.
- Demographic insights are based on the supplied project datasets and should be interpreted within their limitations.

---

## 🎯 Project Outcomes

- Built a MySQL database containing four analytical datasets.
- Developed SQL queries for revenue, advertiser risk and demographic analysis.
- Integrated MySQL with Power BI using Power Query.
- Created a three-page interactive business intelligence dashboard.
- Developed custom KPIs, including the Advertising Ethics Index.
- Connected economic performance analysis with social-impact indicators.

---

## 👤 Author

**Chandu Manikanta**

- [LinkedIn](https://www.linkedin.com/in/chandumanikanta/)
- [GitHub](https://github.com/chandu2627)

---

**If you find this project useful, feel free to explore the repository and share your feedback!**
