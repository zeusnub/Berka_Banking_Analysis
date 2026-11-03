-- =====================================================================
-- BERKA | BANKING ANALYSIS (MySQL)
-- =====================================================================


/*
QUERY 1: CUSTOMER AND ACCOUNT OVERVIEW

Business Question:
How many unique customers and bank accounts does the bank have, and how are customer-account relationships distributed between account owners and authorised users?

Objective:
Analyse the bank's customer base and account structure by identifying:
1. Total number of unique customers.
2. Total number of unique bank accounts.
3. Total customer-account relationships.
4. Number of account-owner relationships (OWNER).
5. Number of authorised-user relationships (DISPONENT).

Tables Used:
- client
- disp
- account

SQL Concepts:
- INNER JOIN
- COUNT()
- COUNT(DISTINCT)
- CASE WHEN
- Table Aliases

Expected Business Outcome:
Understand the bank's customer-account structure, distinguish account owners from authorised users, and identify the nature of account relationships.
*/
USE Berka_banking;

SELECT COUNT(DISTINCT c.client_id) AS total_customers,
       COUNT(DISTINCT a.account_id) AS total_accounts,
       COUNT(DISTINCT d.disp_id) AS total_relationships,
       COUNT(DISTINCT CASE WHEN d.type = 'Owner' THEN d.disp_id END) AS owner_relationships,
       COUNT(DISTINCT CASE WHEN d.type = 'DISPONENT' THEN d.disp_id END) AS disponent_relationships
FROM client AS c
INNER JOIN disp AS d
        ON c.client_id = d.client_id
INNER JOIN account AS a
        ON d.account_id = a.account_id;


/*
QUERY 2: CUSTOMER DISTRIBUTION BY DISTRICT

Business Question:
Which districts have the highest concentration of bank customers, and how is the bank's customer base distributed geographically?

Objective:
1. Identify the total number of customers in each district.
2. Display district names and their corresponding regions.
3. Compare customer distribution across districts.
4. Include district population for geographical context.
5. Rank districts based on customer concentration.

Tables Used:
- client
- district

SQL Concepts:
- LEFT JOIN
- COUNT(DISTINCT)
- GROUP BY
- ORDER BY DESC
- Table Aliases

Expected Business Outcome:
Identify districts with the highest customer concentration and understand the geographical distribution of the bank's customer base.
*/
USE Berka_banking;

SELECT d.A1 AS district_id,
       d.A2 AS district_name,
       d.A3 AS region,
       d.A4 AS population,
       COUNT(DISTINCT c.client_id) AS total_customers
FROM district AS d
LEFT JOIN client AS c
       ON d.A1 = c.district_id
GROUP BY d.A1, d.A2, d.A3, d.A4
ORDER BY total_customers DESC;


/*
QUERY 3: ACCOUNT ACTIVITY AND TRANSACTION FREQUENCY

Business Question:
Which bank accounts are the most active based on transaction frequency, and how much financial activity is recorded across each account?

Objective:
1. Calculate the total number of transactions per account.
2. Calculate total transaction amounts per account.
3. Determine average transaction amounts.
4. Calculate average recorded account balances.
5. Rank accounts based on transaction activity.
6. Identify accounts with no recorded transactions.

Tables Used:
- account
- trans

SQL Concepts:
- LEFT JOIN
- COUNT()
- SUM()
- AVG()
- ROUND()
- COALESCE()
- GROUP BY
- ORDER BY DESC

Expected Business Outcome:
Identify highly active accounts, understand transaction patterns and compare financial activity across bank accounts.
*/
USE Berka_banking;

SELECT a.account_id,
       a.frequency AS statement_frequency,
       COUNT(t.trans_id) AS total_transaction,
       COALESCE(SUM(t.amount), 0) AS total_transaction_amount,
       ROUND(AVG(t.amount), 2) AS average_transaction_amount,
       ROUND(AVG(t.balance), 2) AS average_transaction_balance
FROM account AS a
LEFT JOIN trans AS t
       ON a.account_id = t.account_id
GROUP BY a.account_id, a.frequency
ORDER BY total_transaction DESC;


/*
QUERY 4: CUSTOMER SEGMENTATION BY ACCOUNT ACTIVITY

Business Question:
How can bank customers be segmented based on their transaction activity, and which customers demonstrate high, medium, or low banking engagement?

Objective:
1. Calculate the total number of transactions per customer.
2. Calculate total transaction amounts per customer.
3. Rank customers according to transaction frequency.
4. Divide customers into high, medium, and low activity groups.
5. Identify differences in customer banking engagement.

Tables Used:
- client
- disp
- trans

SQL Concepts:
- LEFT JOIN
- COUNT(DISTINCT)
- SUM()
- COALESCE()
- GROUP BY
- Common Table Expressions (CTEs)
- Window Functions
- NTILE()
- CASE WHEN

Expected Business Outcome:
Understand customer transaction behaviour, identify highly active customers, and segment the customer base for targeted banking strategies.
*/
USE Berka_banking;

WITH customer_activity AS (
    SELECT c.client_id,
           COUNT(DISTINCT t.trans_id) AS total_transactions,
           COALESCE(SUM(t.amount), 0) AS total_transaction_amount
    FROM client AS c
    LEFT JOIN disp AS d
           ON c.client_id = d.client_id
    LEFT JOIN trans AS t
           ON d.account_id = t.account_id
    GROUP BY c.client_id
),
customer_ranking AS (
    SELECT client_id,
           total_transactions,
           total_transaction_amount,
           NTILE(3) OVER (
               ORDER BY total_transactions DESC
           ) AS activity_group
    FROM customer_activity
)
SELECT client_id,
       total_transactions,
       total_transaction_amount,
       CASE
           WHEN activity_group = 1 THEN 'High Activity'
           WHEN activity_group = 2 THEN 'Medium Activity'
           WHEN activity_group = 3 THEN 'Low Activity'
       END AS customer_segment
FROM customer_ranking
ORDER BY total_transactions DESC;
