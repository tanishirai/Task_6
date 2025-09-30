# TASK 6: Sales Trend Analysis Using Aggregations

## Project Overview
Analyzed monthly revenue and order volume trends using MySQL aggregations on an online sales dataset. This project demonstrates advanced SQL techniques including date manipulation, temporal grouping, and multi-dimensional analysis.

## Dataset Information
- **Database**: `online_sales`
- **Table**: `online sales data`
- **Time Period**: 2024 data
- **Key Columns**: 

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| Transaction ID | int | Unique transaction identifier |
| Date | text | Transaction date in YYYY-MM-DD format |
| Total Revenue | double | Revenue per transaction |
| Product Category | text | Product categories |
| Units Sold | int | Quantity per transaction |
| Region | text | Geographic regions |
| Payment Method | text | Payment types |

## Technical Implementation
- **Tools**: MySQL, MySQL Workbench
- **Key Functions**: `EXTRACT()`, `STR_TO_DATE()`, `SUM()`, `COUNT(DISTINCT)`, `GROUP BY`, `ORDER BY`
- **Date Handling**: Converted text dates to proper date format for temporal analysis

## Analysis Completed

### 1. Basic Monthly Analysis
SELECT
EXTRACT(YEAR FROM STR_TO_DATE(Date, '%Y-%m-%d')) AS Year,
EXTRACT(MONTH FROM STR_TO_DATE(Date, '%Y-%m-%d')) AS Month,
SUM(Total Revenue) AS Monthly_Revenue,
COUNT(DISTINCT Transaction ID) AS Order_Volume
FROM online sales data
GROUP BY EXTRACT(YEAR FROM STR_TO_DATE(Date, '%Y-%m-%d')),
EXTRACT(MONTH FROM STR_TO_DATE(Date, '%Y-%m-%d'))
ORDER BY Year, Month;


### 2. Enhanced Monthly with Metrics
- Added month names, average transaction values, and unit sales
- Provided comprehensive monthly performance dashboard

### 3. Quarterly Analysis
- Aggregated data by quarters for higher-level trend identification
- Resolved MySQL `sql_mode=only_full_group_by` compatibility issues

### 4. Multi-dimensional Analysis
- Category-wise monthly performance
- Regional sales breakdown
- Payment method preferences over time


## Key Challenges Solved

| Challenge | Solution | Outcome |
|-----------|----------|---------|
| Text Date Conversion | Used `STR_TO_DATE()` function | Proper temporal analysis |
| GROUP BY Compliance | Resolved MySQL strict mode issues | Compatible queries |
| Multi-Sheet Export | Combined CSV exports in Excel | Single deliverable file |
| Date Range Filtering | Corrected 2023 to 2024 filter | Accurate data retrieval |

## Export Process
1. Executed 10 different analytical queries in MySQL Workbench
2. Exported each result as CSV using "Export Recordset" feature  
3. Combined CSVs into single Excel workbook with descriptive sheet names
4. Final deliverable: `Sales_Analysis_Results.xlsx` with multiple worksheets

## Usage Instructions
1. Load the provided SQL scripts in MySQL Workbench
2. Ensure database connection to `online_sales` schema
3. Execute queries sequentially for comprehensive analysis
4. Export results using provided Excel combination methods

## Technologies Used
- **Database**: MySQL 8.0+
- **IDE**: MySQL Workbench
- **Export Format**: Excel (.xlsx) with multiple worksheets
- **Documentation**: Markdown

## Sample Results
| Year | Month | Monthly_Revenue | Order_Volume |
|------|-------|----------------|--------------|
| 2024 | 1     | 125,450.75     | 342          |
| 2024 | 2     | 138,220.50     | 389          |
| 2024 | 3     | 142,890.25     | 401          |

---
*This analysis demonstrates practical application of SQL aggregations for business intelligence and trend analysis in e-commerce data.*
