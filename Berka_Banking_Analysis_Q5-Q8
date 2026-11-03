-- =====================================================================
-- BERKA | BANKING ANALYSIS (MySQL)
-- =====================================================================


/*
QUERY 5: LOAN PORTFOLIO OVERVIEW BY STATUS

Business Question:
How is the bank's loan portfolio distributed across completed and
ongoing loans, and how many loans have experienced repayment problems?

Objective:
1. Calculate the total number of loans in each status category.
2. Calculate the total loan amount for each category.
3. Determine the average loan amount.
4. Identify completed versus ongoing loans.
5. Identify loans with repayment problems.
6. Analyse average monthly payments across loan categories.

Tables Used:
- loan

SQL Concepts:
- GROUP BY
- COUNT()
- SUM()
- AVG()
- ROUND()
- CASE WHEN
- ORDER BY DESC

Expected Business Outcome:
Understand the bank's lending portfolio, evaluate loan distribution,
and identify categories with repayment difficulties.
*/
USE Berka_banking;

SELECT status AS loan_status,
       CASE
           WHEN status = 'A' THEN 'Finished-No repayment problems'
           WHEN status = 'B' THEN 'Finished-Repayment problems'
           WHEN status = 'C' THEN 'Running-No repayment problems'
           WHEN status = 'D' THEN 'Running-repayment problems'
       END AS loan_status_description,
       COUNT(loan_id) AS total_loans,
       SUM(amount) AS total_loan_amount,
       ROUND(AVG(amount), 2) AS average_loan_amount,
       ROUND(AVG(payments), 2) AS average_monthly_payment
FROM loan
GROUP BY status
ORDER BY total_loans DESC;


/*
QUERY 6: LOAN DISTRIBUTION BY DISTRICT

Business Question:
Which districts have the highest loan exposure, and how does the
bank's lending activity vary across different geographical regions?

Objective:
1. Calculate the total number of loans in each district.
2. Calculate the total loan amount issued in each district.
3. Calculate the average loan amount per district.
4. Identify districts with the highest lending exposure.
5. Compare loan distribution across districts.

Tables Used:
- loan
- account
- district

SQL Concepts:
- INNER JOIN
- GROUP BY
- COUNT()
- SUM()
- AVG()
- ROUND()
- ORDER BY DESC

Expected Business Outcome:
Identify geographical areas with the highest lending activity,
understand loan concentration, and compare the bank's loan exposure
across different districts.
*/
USE Berka_banking;

SELECT d.A1 AS district_id,
       d.A2 AS district_name,
       d.A3 AS region,
       d.A4 AS population,
       COUNT(l.loan_id) AS total_loans,
       SUM(l.amount) AS total_loan_amount,
       ROUND(AVG(l.amount), 2) AS average_loan_amount,
       ROUND(COUNT(l.loan_id) / NULLIF(d.A4, 0) * 100, 2) AS loan_penetration_percentage
FROM loan AS l
INNER JOIN account AS a
        ON l.account_id = a.account_id
INNER JOIN district d
        ON d.A1 = a.district_id
GROUP BY d.A1, d.A2, d.A3, d.A4
ORDER BY total_loans DESC;


/*
QUERY 7: LOAN REPAYMENT PERFORMANCE ANALYSIS

Business Question:
What proportion of the bank's loans have repayment problems, and
how does repayment performance differ between completed and ongoing
loans?

Objective:
1. Calculate the total number of loans in each repayment category.
2. Identify loans with repayment problems.
3. Calculate the percentage of loans with repayment problems.
4. Compare repayment performance between completed and ongoing loans.
5. Understand the bank's loan repayment risk distribution.

Tables Used:
- loan

SQL Concepts:
- CASE WHEN
- COUNT()
- SUM()
- GROUP BY
- ROUND()
- Aggregate Functions
- Conditional Aggregation

Expected Business Outcome:
Evaluate loan repayment performance, identify categories with
repayment difficulties, and understand the bank's historical
loan repayment risk distribution.
*/
USE Berka_banking;

SELECT CASE
           WHEN status IN ('A', 'B') THEN 'Finished'
           WHEN status IN ('C', 'D') THEN 'Running'
       END AS loan_status,
       COUNT(loan_id) AS total_loans,
       SUM(CASE
               WHEN status IN ('B', 'D') THEN 1
               ELSE 0
           END) AS loan_repayment_problems,
       ROUND(SUM(CASE
                     WHEN status IN ('B', 'D') THEN 1
                     ELSE 0
                 END) * 100 / COUNT(loan_id), 2) AS loan_repayment_percentage
FROM loan
GROUP BY loan_status
ORDER BY loan_repayment_percentage DESC;


/*
QUERY 8: HIGH-VALUE LOAN ANALYSIS

Business Question:
Which loans represent the highest financial exposure for the bank,
and how do high-value loans differ in repayment performance?

Objective:
1. Identify loans with amounts above the average loan amount.
2. Calculate the number of high-value loans.
3. Calculate their combined loan value.
4. Identify high-value loans with repayment problems.
5. Compare high-value loans against the overall loan portfolio.

Tables Used:
- loan

SQL Concepts:
- Subqueries
- AVG()
- COUNT()
- SUM()
- CASE WHEN
- WHERE
- Aggregate Functions

Expected Business Outcome:
Identify high-value lending exposure and evaluate whether larger
loans are associated with a greater frequency of repayment problems.
*/
USE berka_banking;

SELECT COUNT(loan_id) AS total_high_value_loans,
       SUM(amount) AS total_high_value_loan_amount,
       ROUND(AVG(amount), 2) AS average_high_value_loan_amount,
       SUM(CASE
               WHEN status IN ('B', 'D') THEN 1
               ELSE 0
           END) AS high_value_loans_with_repayment_problems,
       ROUND(SUM(CASE
                     WHEN status IN ('B', 'D') THEN 1
                     ELSE 0
                 END) * 100.0 / COUNT(loan_id),
             2) AS loan_repayment_problem_percentage
FROM loan
WHERE amount > (
    SELECT AVG(amount)
    FROM loan
);
