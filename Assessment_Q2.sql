WITH customer_txn_summary AS (
    SELECT 
        owner_id,
        COUNT(*) / 12.0 AS avg_txn_per_month
    FROM savings_savingsaccount
    WHERE transaction_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
    GROUP BY owner_id
),
categorized_customers AS (
    SELECT 
        CASE
            WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txn_per_month
    FROM customer_txn_summary
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM categorized_customers
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');

