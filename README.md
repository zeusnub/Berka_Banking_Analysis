# Berka Banking Analytics | SQL & Power BI

## Project Overview

An end-to-end banking analytics project built using **MySQL and Microsoft Power BI**, focused on exploring customer demographics, account activity, transaction behaviour, loan distribution and repayment performance.

The project uses the historical Czech banking dataset (Berka / PKDD '99) to analyse over one million financial transaction records and uncover patterns in banking operations and loan portfolios.

The objective is to transform raw relational banking data into meaningful business insights through SQL analysis, data modelling and interactive Power BI dashboards.

## Tools & Technologies

- **MySQL** – Data exploration, querying, joins, aggregations, CTEs, subqueries and window functions.
- **Microsoft Power BI** – Data modelling, DAX measures, interactive visualisations and dashboard development.
- **Power Query** – Data cleaning, transformation and date formatting.
- **DAX** – KPI calculations, conditional measures and portfolio analysis.

## Dataset Overview

The project uses eight relational tables:

| Table | Description |
|---|---|
| `account` | Bank account information |
| `card` | Issued bank card details |
| `client` | Customer demographic information |
| `disp` | Customer-account relationship mapping |
| `district` | Regional demographic and economic indicators |
| `loan` | Loan amounts, durations, instalments and repayment status |
| `order` | Standing orders and payment instructions |
| `trans` | Historical banking transactions |

**Dataset scale:**

- 5,369 customers
- 4,500 accounts
- 892 bank cards
- 682 loans
- 1,056,320 transactions
- 77 districts
- 6,471 standing orders

**Total records: 1,079,680**

## SQL Analysis

The SQL component is organised into three analytical phases, comprising 12 business-oriented queries.

### Phase 1 – Customer & Account Analytics

1. Customer and Account Overview
2. Customer Distribution by District
3. Account Activity & Transaction Frequency
4. Customer Segmentation by Account Activity

### Phase 2 – Loan Portfolio & Risk Analysis

5. Loan Portfolio Overview by Status
6. Loan Distribution by District
7. Loan Repayment Performance Analysis
8. High-Value Loan Analysis

### Phase 3 – Transaction & Financial Behaviour

9. Monthly Transaction Trends
10. Transaction Type & Operation Analysis
11. Transaction Purpose Analysis
12. Account-Level Financial Behaviour Analysis

### SQL Concepts Applied

- INNER JOIN and LEFT JOIN
- Aggregate functions: COUNT, SUM, AVG
- GROUP BY and HAVING
- CASE WHEN conditional logic
- Subqueries
- Common Table Expressions (CTEs)
- Window functions and NTILE()
- Date conversion and formatting
- NULL handling and NULLIF()

## Power BI Dashboard

The interactive dashboard consists of two analytical pages.

### Page 1 – Banking Performance & Customer Insights

Focuses on overall banking activity, customer distribution and transaction behaviour.

**Key Performance Indicators:**
- Total Customers
- Total Accounts
- Total Transactions
- Total Loan Amount

**Visualisations:**
- Monthly Transaction Amount Trends
- Customer Distribution by District
- Transaction Distribution by Type
- Account Distribution by Statement Frequency

### Page 2 – Loan Portfolio & Risk Analysis

Focuses on loan exposure, repayment performance and portfolio composition.

**Key Performance Indicators:**
- Total Loans
- Total Loan Amount
- Loans with Repayment Problems
- Loan Status Share

**Visualisations:**
- Loan Portfolio Distribution by Status
- Loan Amount by District
- Loans with Repayment Problems by District
- Loan Distribution by Duration
- Loan Portfolio Share by Status
- High-Value Loan Distribution by Status

## Key Observations

The dashboard highlights several important patterns in the historical banking dataset:

- The dataset contains 682 loans with a combined original loan amount of approximately 103.26 million.
- 76 loans are classified as having repayment problems, representing approximately 11.14% of the loan portfolio.
- Loan exposure varies considerably across districts, with Prague showing the highest loan amount in the district analysis.
- Transaction activity can be examined across different transaction types, banking operations and historical periods.
- Customer activity segmentation provides a way to compare account-linked transaction behaviour.

**Important:** Loans classified as having repayment problems are not automatically equivalent to defaults or confirmed non-performing loans. The analysis uses the dataset's original repayment-status classifications.

## Data Modelling

The Power BI model uses relationships between customers, accounts, districts, transactions, loans, cards and standing orders.

The `disp` table acts as a bridge between customers and accounts, allowing customer-account relationships to be analysed.

District-level loan analysis uses the relationship between `district`, `account` and `loan`.

## Project Objectives

This project was developed to demonstrate practical capabilities in:

- Relational database analysis using SQL.
- Extracting business insights from large datasets.
- Financial and customer behaviour analysis.
- Data modelling and relationship management.
- Developing interactive dashboards using Power BI.
- Translating analytical findings into business-oriented visualisations.

## Repository Structure

```text
Berka-Banking-Analytics/
│
├── SQL/
│   ├── Berka_Banking_Analysis_Q1-Q4.sql
│   ├── Berka_Banking_Analysis_Q5-Q8.sql
│   └── Berka_Banking_Analysis_Q9-Q12.sql
│
├── Dashboard/
│   └── Berka_Banking_Dashboard.pdf
│
└── README.md
```

## Dataset Source

Berka Banking Dataset – Czech Financial Dataset (PKDD'99).

Original dataset repository: https://github.com/jlacko/berka-dataset

## Author

Developed as a portfolio project to demonstrate SQL, data analytics, financial data exploration and Power BI dashboard development.
