WITH transaction_summary AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        AVG(s.new_balance) AS avg_transaction_value
    FROM savings_savingsaccount s
    WHERE s.new_balance > 0
    GROUP BY s.owner_id
),
tenure_calc AS (
    SELECT 
        u.id AS customer_id,
        u.name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months
    FROM users_customuser u
),
clv_calc AS (
    SELECT 
        t.customer_id,
        t.name,
        t.tenure_months,
        ts.total_transactions,
        ROUND(
            (ts.total_transactions / t.tenure_months) * 12 * (ts.avg_transaction_value * 0.001),
            2
        ) AS estimated_clv
    FROM tenure_calc t
    JOIN transaction_summary ts ON t.customer_id = ts.owner_id
    WHERE t.tenure_months > 0
)
SELECT *
FROM clv_calc
ORDER BY estimated_clv DESC;
