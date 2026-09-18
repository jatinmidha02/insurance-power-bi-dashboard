# Insurance Claims Analytics

## Overview

Insurance Claims Analytics is an end-to-end data analytics project focused on analyzing insurance customer, policy, and claims data.

The project demonstrates a complete Data Analyst workflow using **SQL Server, Python, and Power BI**. SQL Server is used for structured data storage and querying, Python is used for data cleaning and exploratory analysis, and Power BI is used for interactive business reporting.

The objective is to analyze claim volume, claim amounts, approval rates, processing times, product performance, regional trends, and time-based patterns.

## Business Problem

Insurance companies generate large volumes of customer, policy, and claims data. This project analyzes that data to answer questions such as:

- How many claims are being processed?
- What is the total claim amount?
- What percentage of claims are approved, rejected, pending, or under investigation?
- Which insurance products generate the most claims?
- Which products have the highest average processing time?
- Which regions have the highest claim volume and claim value?
- How does claim activity change over time?

## Dataset

The project contains three relational datasets:

### Customers

| Column | Description |
|---|---|
| `Customer_ID` | Unique customer identifier |
| `Customer_Name` | Customer name |
| `Age` | Customer age |
| `Gender` | Customer gender |
| `Region` | Customer region |

### Policies

| Column | Description |
|---|---|
| `Policy_ID` | Unique policy identifier |
| `Customer_ID` | Customer associated with the policy |
| `Product` | Insurance product |
| `Policy_Start` | Policy start date |
| `Premium` | Policy premium amount |

### Claims

| Column | Description |
|---|---|
| `Claim_ID` | Unique claim identifier |
| `Policy_ID` | Policy associated with the claim |
| `Claim_Date` | Claim submission date |
| `Claim_Amount` | Amount claimed |
| `Claim_Status` | Current claim status |
| `Processing_Days` | Number of days required to process the claim |

### Dataset Size

- **1,000 Customers**
- **1,500 Policies**
- **5,000 Claims**

A small amount of missing data is intentionally included for data-quality and missing-value handling practice.

## Project Architecture

```text
                    CSV DATA
                       |
                       v
                +--------------+
                | SQL Server   |
                |    SSMS      |
                +------+-------+
                       |
                 SQL Analysis
                       |
             +---------+---------+
             |                   |
             v                   v
       +-----------+       +------------+
       |  Python   |       |  Power BI  |
       |  Pandas   |       | Dashboard  |
       +-----+-----+       +------------+
             |
        EDA & Cleaning
```

## Tools & Technologies

### SQL Server / SSMS

Used for:

- Database creation
- Table creation
- Relational data modeling
- Primary and foreign keys
- JOIN operations
- Aggregations
- Business analysis
- CTEs
- CASE statements
- Window functions

### Python

Libraries:

- Pandas
- NumPy
- Matplotlib

Used for:

- Data-quality checks
- Missing-value analysis
- Data cleaning
- Exploratory Data Analysis (EDA)
- Statistical analysis
- Trend analysis
- Data visualization

### Power BI

Used for:

- Power Query
- Data modeling
- Relationships
- DAX
- KPI creation
- Interactive dashboards
- Slicers and filters
- Business reporting

## Data Model

```text
Customers
    |
    | 1 : Many
    v
Policies
    |
    | 1 : Many
    v
Claims
```

Relationships:

```text
Customers.Customer_ID
        |
        v
Policies.Customer_ID

Policies.Policy_ID
        |
        v
Claims.Policy_ID
```

## Project Workflow

### 1. Data Loading

The CSV datasets are imported into SQL Server and stored as relational tables.

### 2. SQL Analysis

SQL is used to join tables, filter records, aggregate metrics, and answer business questions.

Example:

```sql
SELECT
    p.Product,
    AVG(c.Processing_Days) AS Avg_Processing_Days
FROM Claims c
JOIN Policies p
    ON c.Policy_ID = p.Policy_ID
GROUP BY p.Product
ORDER BY Avg_Processing_Days DESC;
```

### 3. Python Analysis

Relevant data is extracted from SQL Server into Python using Pandas.

Example:

```python
import pandas as pd

df = pd.read_sql(query, engine)
```

Python is then used for:

- Missing-value analysis
- Duplicate detection
- Data cleaning
- GroupBy analysis
- Aggregation
- Distribution analysis
- Outlier investigation
- Trend analysis
- Visualization

Example:

```python
product_analysis = (
    df.groupby('Product')
      .agg(
          Total_Claims=('Claim_ID', 'count'),
          Total_Claim_Amount=('Claim_Amount', 'sum'),
          Avg_Processing_Days=('Processing_Days', 'mean')
      )
      .sort_values('Total_Claims', ascending=False)
)
```

### 4. Power BI

Power BI is connected **directly to SQL Server** for the final reporting layer.

```text
SQL Server
    |
    v
Power BI
    |
    v
Data Model
    |
    v
DAX Measures
    |
    v
Interactive Dashboard
```

## Power BI Dashboard

The dashboard includes the following KPIs:

- Total Claims
- Total Claim Amount
- Approval Rate
- Average Processing Days

### Visualizations

- Claims by Product
- Claims by Status
- Claims by Region
- Claim Amount by Region
- Monthly Claim Trend
- Average Processing Days by Product

### Filters / Slicers

- Year
- Region
- Product
- Claim Status

## DAX Measures

### Total Claims

```DAX
Total Claims =
COUNT(Claims[Claim_ID])
```

### Total Claim Amount

```DAX
Total Claim Amount =
SUM(Claims[Claim_Amount])
```

### Approved Claims

```DAX
Approved Claims =
CALCULATE(
    [Total Claims],
    Claims[Claim_Status] = "Approved"
)
```

### Approval Rate

```DAX
Approval Rate =
DIVIDE(
    [Approved Claims],
    [Total Claims],
    0
)
```

### Average Processing Days

```DAX
Average Processing Days =
AVERAGE(Claims[Processing_Days])
```

## Key Business Questions

### Claims

- What is the total claim volume?
- What is the total claim value?
- What is the average claim amount?

### Status

- What percentage of claims are approved?
- How many claims are rejected?
- How many claims remain pending?
- How many claims are under investigation?

### Product

- Which product has the highest claim volume?
- Which product generates the highest claim value?
- Which product has the longest processing time?

### Region

- Which region has the highest claim volume?
- Which region has the highest claim amount?
- How does processing time vary by region?

### Time

- Which months have the highest claim volume?
- How does claim activity change over time?

## Business Value

The analysis provides a centralized view of insurance claims performance and can help stakeholders:

- Monitor claim volumes
- Track claim approval performance
- Identify high-value claim segments
- Compare insurance products
- Monitor processing efficiency
- Analyze regional differences
- Identify trends requiring further investigation

## Project Structure

```text
Insurance_Claims_Analytics/
|
+-- data/
|   +-- customers.csv
|   +-- policies.csv
|   +-- claims.csv
|
+-- sql/
|   +-- claims_analysis.sql
|
+-- python/
|   +-- claims_analysis.ipynb
|
+-- powerbi/
|   +-- insurance_claims_dashboard.pbix
|
+-- README.md
```

## How to Reproduce the Project

1. Import `customers.csv`, `policies.csv`, and `claims.csv` into SQL Server.
2. Create the `InsuranceAnalytics` database and relational tables.
3. Establish primary and foreign key relationships.
4. Run SQL queries to perform business analysis.
5. Connect Python to SQL Server using Pandas and analyze the extracted data.
6. Perform data cleaning and exploratory analysis in Python.
7. Connect Power BI directly to the SQL Server database.
8. Build the data model and relationships.
9. Create DAX measures.
10. Build the interactive dashboard and document the resulting business insights.

## Skills Demonstrated

### SQL

- SQL Server
- Database Design
- Data Modeling
- SELECT
- Filtering
- GROUP BY
- Aggregations
- JOINs
- CASE WHEN
- CTEs
- Window Functions

### Python

- Pandas
- NumPy
- Matplotlib
- Data Cleaning
- Missing Value Handling
- Exploratory Data Analysis
- GroupBy
- Aggregations
- Data Visualization
- Basic Statistical Analysis

### Power BI

- Power Query
- Data Modeling
- Relationships
- DAX
- KPI Development
- Interactive Visualizations
- Slicers
- Dashboard Design
- Business Reporting

## Project Objective

The primary objective is to demonstrate an end-to-end **Data Analyst workflow** by combining SQL-based data management, Python-based exploratory analysis, and Power BI-based business intelligence.

The project demonstrates how raw insurance data can be transformed into structured information, analyzed to identify meaningful patterns, and presented through an interactive dashboard for business stakeholders.
