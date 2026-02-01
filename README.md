# Global-Tech-Layoffs-Analysis-SQL-Project-# Global Tech Layoffs Analysis (SQL Project)

## Project Overview
This project focuses on cleaning, transforming, and analyzing a real-world global layoffs dataset using **SQL**.  
The primary goal was to convert a raw, inconsistent dataset into a **report-ready / dashboard-ready format**, and then perform **exploratory data analysis (EDA)** to answer some of the most relevant business and industry questions surrounding recent layoffs.

The project demonstrates strong SQL skills including data cleaning, window functions, joins, date handling, and analytical queries commonly used in real-world data roles.

---

## Dataset Description
The dataset contains information on global company layoffs, including:
- Company name
- Location and country
- Industry
- Number of employees laid off
- Percentage of workforce laid off
- Company funding stage
- Funds raised
- Date of layoffs

**Source:** Public layoffs dataset (CSV format)

---

## Tools & Technologies
- **SQL (MySQL)**
- Window Functions
- CTEs
- Aggregate Functions
- Data Cleaning & Transformation
- Exploratory Data Analysis (EDA)

---

## Data Cleaning Process
The raw dataset contained duplicates, inconsistent text values, missing data, and incorrect data types.  
A structured multi-step cleaning process was applied using SQL.

### 1. Data Backup & Staging
- Created a staging table to preserve the original data.
- All transformations were applied on copied tables to ensure data safety.

### 2. Standardization & Text Cleaning
- Removed leading and trailing spaces from company names.
- Standardized country names (e.g., fixed `"United States."` → `"United States"`).
- Unified inconsistent industry labels (e.g., grouped all Crypto-related values under `"Crypto"`).

### 3. Duplicate Removal (Advanced SQL)
- Used `ROW_NUMBER()` window function to identify duplicate records.
- Partitioned by all relevant columns to accurately detect redundancy.
- Deleted rows where `ROW_NUM > 1`.

### 4. Handling Missing Values
- Converted blank industry values to `NULL`.
- Used **self-joins** to populate missing industry values based on matching company names.
- Removed rows where both `total_laid_off` and `percentage_laid_off` were `NULL`, as they added no analytical value.

### 5. Date Formatting
- Converted date values from text format to proper `DATE` datatype using `STR_TO_DATE`.
- Ensured consistency for time-based analysis.

### 6. Final Dataset Optimization
- Dropped helper columns used during cleaning (e.g., `ROW_NUM`).
- Resulted in a **clean, consistent, and analysis-ready dataset**.

---

## Exploratory Data Analysis (EDA)
Once the dataset was cleaned, multiple analytical queries were executed to extract meaningful insights.

### Key Business Questions Answered

#### 1. Which companies laid off the most employees?
- Aggregated total layoffs per company.
- Ranked companies by total layoffs to identify major contributors.

#### 2. Which countries were most impacted by layoffs?
- Calculated country-wise total layoffs.
- Highlighted regions most affected by workforce reductions.

#### 3. Layoffs trend over time
- Year-wise analysis of total layoffs.
- Identified peak years for layoffs globally.

#### 4. Rolling layoffs analysis (Time Series)
- Calculated monthly layoffs.
- Used CTEs to compute cumulative (rolling) layoffs over time.

#### 5. Company-year level insights
- Analyzed layoffs per company per year.
- Helped identify repeated or sustained workforce reductions.

---

## SQL Concepts Demonstrated
- Data Cleaning & Standardization
- Window Functions (`ROW_NUMBER()`, `OVER()`)
- Common Table Expressions (CTEs)
- Self Joins
- Aggregate Functions (`SUM`, `GROUP BY`)
- Date Functions & Type Conversion
- Analytical Queries for Business Insights

---

## Outcome
- Transformed a messy raw dataset into a **dashboard-ready analytical dataset**
- Generated insights that are directly applicable to:
  - Business reporting
  - Workforce trend analysis
  - Economic and industry-level studies

This project reflects **real-world SQL workflows** commonly used by data analysts and data engineers.

---

## Future Enhancements
- Build an interactive dashboard using Tableau / Power BI
- Perform industry-wise trend analysis
- Correlate layoffs with funding stages and funds raised

---

## Author
**Mayur Bhamare**  
Data Analyst | SQL | Data Cleaning & Analytics

