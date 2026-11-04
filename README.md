# Berka Banking Analytics: SQL + Power BI Dashboard

An end-to-end analysis of the **Berka Czech Banking Dataset**, exploring customer and account activity, loan portfolio performance, repayment behaviour, transaction trends and district-level banking patterns. The project includes **12 SQL queries across 8 tables**, covering SQL fundamentals, joins, aggregations and advanced business analysis, followed by a two-page **Power BI dashboard**.

> **Tools:** MySQL 8 · MySQL Workbench · Power BI Desktop  
> **Dataset:** [Berka Czech Banking Dataset](https://github.com/jlacko/berka-dataset)  
> **Dashboard:** Two-page Power BI dashboard covering Banking Performance & Customer Insights and Loan Portfolio & Risk Analysis.

---

## Business Questions

This project explores questions relevant to banking and financial institutions:

1. How are customers and accounts distributed across districts?
2. How frequently are accounts used for transactions?
3. Which accounts show higher or lower transaction activity?
4. How is the loan portfolio distributed across different loan statuses?
5. Which districts have the highest loan exposure?
6. How many loans have repayment problems?
7. How does repayment performance vary across districts?
8. What are the monthly transaction trends?
9. Which transaction types and operations are most common?
10. What are the most frequent transaction purposes?
11. Which accounts demonstrate higher financial activity?
12. How do loan amounts and repayment statuses vary across the portfolio?

---

## Power BI Dashboard

The dashboard is built using the Berka banking database, with two pages:

| **Page** | **What it shows** |
|---|---|
| **Banking Performance & Customer Insights** | Total customers, total accounts, transaction volume, total loan amount, monthly transaction trends, transaction distribution by type, customer distribution by district and account statement frequency |
| **Loan Portfolio & Risk Analysis** | Total loans, total loan amount, loans with repayment problems, repayment problem rate, loan status distribution, loan exposure by district, repayment problems by district, loan duration and high-value loans by status |

The dashboard focuses on understanding banking activity, customer distribution, loan exposure and repayment performance through interactive visualisations.

---

## Key Findings

- **Customer and account base:** The dataset contains 5,369 customers and 4,500 accounts.
- **Transaction activity:** The database contains 1,056,320 transaction records, providing a substantial basis for analysing financial activity over time.
- **Loan portfolio:** The dataset contains 682 loans with a combined original loan amount of approximately 103.26 million.
- **Repayment problems:** 76 loans have repayment-problem statuses (B and D), representing approximately 11.14% of the loan portfolio.
- **District-level loan exposure:** Hl. m. Praha has the highest recorded loan amount among the districts shown in the dashboard.
- **Loan status:** The portfolio contains 403 completed loans without repayment problems, 45 completed loans with repayment problems, 203 running loans without repayment problems and 31 running loans with repayment problems.

### Business Recommendations

1. **Monitor repayment risk:** Banks should closely monitor loans with repayment-problem statuses and identify patterns that could help improve repayment performance.
2. **Strengthen district-level analysis:** District-level loan exposure can help financial institutions understand geographic concentration and review lending strategies.
3. **Monitor account activity:** Transaction frequency and account-level activity can help identify different customer banking behaviours.
4. **Improve loan portfolio monitoring:** Analysing loan amounts, durations and statuses together can support better portfolio management and risk assessment.

---

## Dataset

The project uses the Berka Czech Banking Dataset, originally released for the PKDD'99 Discovery Challenge. It contains anonymised banking records covering customers, accounts, transactions, loans, payment orders, cards and district information.

I imported the following 8 tables into a MySQL schema called `berka_banking`:

| **Table** | **Rows** | **What it holds** |
|---|---:|---|
| `account` | 4,500 | Account details, creation dates, frequency and district information |
| `card` | 892 | Issued card information associated with client dispositions |
| `client` | 5,369 | Customer identifiers, birth numbers and district references |
| `disp` | 5,369 | Relationships between clients and bank accounts |
| `district` | 77 | District-level demographic and socioeconomic information |
| `loan` | 682 | Loan amounts, repayment instalments, durations and statuses |
| `order` | 6,471 | Standing orders and payment instructions |
| `trans` | 1,056,320 | Transaction records, dates, amounts, balances and transaction types |

**Total records imported: 1,079,680 across 8 tables.**

### How the Tables Connect

- `client` connects to `disp` through `client_id`.
- `disp` connects to `account` through `account_id`.
- `account` connects to `trans`, `loan` and `order` through `account_id`.
- `disp` connects to `card` through `disp_id`.
- `client` and `account` contain district references that connect to `district` through `district_id` and `A1`, respectively.

---

## SQL Analysis

The project contains 12 SQL queries organised into three phases:

| **File** | **Queries** | **Topics** |
|---|---|---|
| `Berka_Banking_Analysis_Q1-Q4.sql` | 1–4 | Customer and account overview, district distribution, account activity and customer segmentation |
| `Berka_Banking_Analysis_Q5-Q8.sql` | 5–8 | Loan portfolio overview, district-level loan distribution, repayment performance and high-value loan analysis |
| `Berka_Banking_Analysis_Q9-Q12.sql` | 9–12 | Monthly transaction trends, transaction type analysis, transaction purpose and account-level financial behaviour |

### SQL Concepts Demonstrated

- Filtering and sorting using `WHERE` and `ORDER BY`
- Aggregations using `COUNT`, `SUM` and `AVG`
- Grouping using `GROUP BY` and `HAVING`
- Multi-table `INNER JOIN` operations
- Subqueries and conditional logic
- Date-based transaction analysis
- Customer and account segmentation
- Loan portfolio and repayment analysis
- Financial behaviour analysis

---

## Repository Structure

```text
Berka_Banking_Analysis/
│
├── README.md
│
├── Berka_Banking_Analysis_Q1-Q4.sql
├── Berka_Banking_Analysis_Q5-Q8.sql
├── Berka_Banking_Analysis_Q9-Q12.sql
│
├── Screenshot 2026-11-04 191323.png
├── Screenshot 2026-11-04 191434.png
│
└── berka_bank_analysis.pbix
```

| **File** | **Purpose** |
|---|---|
| `Berka_Banking_Analysis_Q1-Q4.sql` | Customer and account analytics |
| `Berka_Banking_Analysis_Q5-Q8.sql` | Loan portfolio and repayment risk analysis |
| `Berka_Banking_Analysis_Q9-Q12.sql` | Transaction and financial behaviour analysis |
| `berka_bank_analysis.pbix` | Interactive Power BI dashboard project file |
| `Screenshot 2026-11-04 191323.png` | Dashboard visualisation screenshot |
| `Screenshot 2026-11-04 191434.png` | Dashboard visualisation screenshot |

| **File** | **Purpose** |
|---|---|
| `Berka_Banking_Analysis_Q1-Q4.sql` | Customer and account analytics |
| `Berka_Banking_Analysis_Q5-Q8.sql` | Loan portfolio and repayment risk analysis |
| `Berka_Banking_Analysis_Q9-Q12.sql` | Transaction and financial behaviour analysis |
| `Berka_Banking_Dashboard.pdf` | Static preview of the two-page Power BI dashboard |
| `berka_bank_analysis.pbix` | Power BI Desktop project file |

---

## Data Notes and Decisions

- **Client and account relationships:** The `disp` table acts as a bridge between clients and accounts. An account can be associated with multiple clients, so account-linked transaction activity should not automatically be interpreted as an individual's personal spending.
- **Loan status definitions:** A represents a finished loan without repayment problems; B represents a finished loan with repayment problems; C represents a running loan without repayment problems; and D represents a running loan with repayment problems.
- **Repayment problems vs. defaults:** Statuses B and D indicate repayment problems. They should not automatically be interpreted as confirmed loan defaults.
- **Loan amount:** The `loan.amount` field represents the original loan amount, not the outstanding loan balance.
- **Transaction balance:** Average transaction balance represents the average of recorded transaction balances, not necessarily the current account balance.
- **District-level loan analysis:** Loans per 100 residents is a district-level ratio, not a direct measure of borrower penetration.
- **Data modelling:** Relationships between customer, account, district and transaction tables were configured in Power BI to support meaningful filtering and aggregation.

---

## How to Reproduce

1. Download the dataset from the [Berka Banking Dataset repository](https://github.com/jlacko/berka-dataset).
2. Create a MySQL schema:

   ```sql
   CREATE DATABASE berka_banking;
   ```

3. Import the eight CSV files into MySQL using MySQL Workbench.
4. Run the three SQL files in sequence, one query at a time.
5. Open the `.pbix` file using Power BI Desktop.
6. Connect to the `berka_banking` MySQL database if prompted and explore the interactive dashboard.

---

## Skills Demonstrated

- SQL querying and multi-table joins
- Aggregations, grouping and filtering
- Subqueries and conditional analysis
- Customer and account segmentation
- Financial transaction analysis
- Loan portfolio analysis and repayment risk assessment
- Date-based trend analysis
- Data cleaning and transformation using Power Query
- Data modelling and relationships in Power BI
- DAX measures and calculated columns
- Interactive dashboard development
- Translating financial data into business insights and recommendations

---

## Limitations

- The dataset is historical and represents a Czech banking environment; its findings should not be treated as representative of current banking behaviour.
- Repayment-problem statuses do not necessarily indicate confirmed defaults.
- Loan amounts represent original principal amounts rather than current outstanding balances.
- Account-linked transaction analysis does not always establish which individual associated with an account performed a transaction.
- District-level ratios provide descriptive comparisons and should not be interpreted as direct measures of individual customer behaviour.

---

## About

**Ajith B.**  
Computer Science (Data Science) Graduate

[LinkedIn](https://www.linkedin.com/in/ajith-b-7549b2376/) · [GitHub](https://github.com/zeusnub) · [Email](mailto:ajithbalachandran911@gmail.com)

*Dataset credit: Original Berka Czech Banking Dataset, released for the PKDD'99 Discovery Challenge. Please refer to the original dataset repository for source information and usage conditions.*
