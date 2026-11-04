/*
=====================================================================
QUERY 9: MONTHLY TRANSACTION TRENDS
=====================================================================

Business Question:
How does the bank's transaction activity change over time, and
which months record the highest transaction volumes and values?

Objective:
1. Calculate the total number of transactions per month.
2. Calculate the total transaction amount per month.
3. Calculate the average transaction amount per month.
4. Identify months with the highest transaction activity.
5. Analyse monthly transaction trends.

Tables Used:
- trans

SQL Concepts:
- DATE FUNCTIONS
- STR_TO_DATE()
- DATE_FORMAT()
- COUNT()
- SUM()
- AVG()
- ROUND()
- GROUP BY
- ORDER BY

Expected Business Outcome:
Understand monthly transaction patterns, identify periods of
high financial activity, and evaluate changes in transaction
volume and value over time.

=====================================================================
*/

USE berka_banking;

SELECT
    DATE_FORMAT(
        STR_TO_DATE(CAST(date AS CHAR), '%y%m%d'),
        '%Y-%m'
    ) AS transaction_month,
    COUNT(trans_id) AS total_transactions,
    SUM(amount) AS total_transaction_amount,
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM trans
GROUP BY transaction_month
ORDER BY transaction_month;


/*
=====================================================================
QUERY 10: TRANSACTION TYPE AND OPERATION ANALYSIS
=====================================================================

Business Question:
Which transaction types and banking operations account for the
highest transaction volumes and financial values?

Objective:
1. Identify different transaction types.
2. Calculate the number of transactions for each type.
3. Calculate total transaction amounts by type.
4. Analyse transaction operations.
5. Identify the most frequently used banking operations.
6. Compare financial activity across transaction categories.

Tables Used:
- trans

SQL Concepts:
- GROUP BY
- COUNT()
- SUM()
- AVG()
- ROUND()
- ORDER BY

Expected Business Outcome:
Understand customer transaction behaviour, identify frequently
used banking operations, and evaluate financial activity across
different transaction categories.

=====================================================================
*/

USE berka_banking;

SELECT
    type AS transaction_type,
    operation AS transaction_operation,
    COUNT(trans_id) AS total_transactions,
    SUM(amount) AS total_transaction_amount,
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM trans
GROUP BY
    type,
    operation
ORDER BY total_transaction_amount DESC;


/*
=====================================================================
QUERY 11: TRANSACTION PURPOSE ANALYSIS
=====================================================================

Business Question:
What are the most common purposes of banking transactions, and
which transaction categories account for the highest financial values?

Objective:
1. Identify different transaction purpose categories.
2. Calculate the number of transactions for each purpose.
3. Calculate the total transaction amount by purpose.
4. Calculate the average transaction amount for each purpose.
5. Identify the most frequently occurring transaction purposes.
6. Compare transaction values across different categories.

Tables Used:
- trans

SQL Concepts:
- GROUP BY
- COUNT()
- SUM()
- AVG()
- ROUND()
- HAVING
- ORDER BY
- NULL Handling

Expected Business Outcome:
Understand transaction purposes, identify common banking activities,
and evaluate the financial value associated with different
transaction categories.

=====================================================================
*/

USE berka_banking;

SELECT
    k_symbol AS transaction_purpose,
    COUNT(trans_id) AS total_transactions,
    SUM(amount) AS total_transaction_amount,
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM trans
GROUP BY k_symbol
HAVING COUNT(trans_id) > 100
ORDER BY total_transactions DESC;


/*
=====================================================================
QUERY 12: ACCOUNT-LEVEL FINANCIAL BEHAVIOUR ANALYSIS
=====================================================================

Business Question:
Which bank accounts demonstrate the highest transaction activity,
and how do their transaction volumes and average recorded balances
compare?

Objective:
1. Calculate the total number of transactions per account.
2. Calculate the total transaction amount per account.
3. Calculate the average transaction amount per account.
4. Calculate the average recorded account balance.
5. Rank accounts based on transaction activity.
6. Categorise accounts into high, medium and low activity groups.

Tables Used:
- account
- trans

SQL Concepts:
- Common Table Expressions (CTEs)
- LEFT JOIN
- COUNT()
- SUM()
- AVG()
- ROUND()
- COALESCE()
- Window Functions
- NTILE()
- CASE WHEN
- ORDER BY

Expected Business Outcome:
Understand account-level financial behaviour, identify highly active
accounts, and segment accounts according to their transaction activity.

=====================================================================
*/

USE berka_banking;

WITH account_activity AS (
    SELECT
        a.account_id,
        a.frequency AS statement_frequency,
        COUNT(t.trans_id) AS total_transactions,
        COALESCE(SUM(t.amount), 0) AS total_transaction_amount,
        ROUND(AVG(t.amount), 2) AS average_transaction_amount,
        ROUND(AVG(t.balance), 2) AS average_recorded_balance
    FROM account AS a
    LEFT JOIN trans AS t
        ON a.account_id = t.account_id
    GROUP BY
        a.account_id,
        a.frequency
),

account_ranking AS (
    SELECT
        account_id,
        statement_frequency,
        total_transactions,
        total_transaction_amount,
        average_transaction_amount,
        average_recorded_balance,
        NTILE(3) OVER (
            ORDER BY total_transactions DESC
        ) AS activity_group
    FROM account_activity
)

SELECT
    account_id,
    statement_frequency,
    total_transactions,
    total_transaction_amount,
    average_transaction_amount,
    average_recorded_balance,
    CASE
        WHEN activity_group = 1 THEN 'High Activity'
        WHEN activity_group = 2 THEN 'Medium Activity'
        WHEN activity_group = 3 THEN 'Low Activity'
    END AS account_segment
FROM account_ranking
ORDER BY total_transactions DESC;
